# CHANGE ME
NIXADDR ?= localhost
# This can be whatever you want it to be when you start the qemu VM (it just needs to match what you use in the VM)
NIXPORT ?= 6022
NIXUSER ?= wj

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# The name of the nixosConfiguration in the flake

NIXNAME ?= pw

# SSH options that are used. These aren't meant to be overridden but are
# reused a lot so we just store them up here.
SSH_OPTIONS=-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# !!! PLZ READ !!!
# When your VM boots up, you need to run `sudo su` then `passwd` to create a password for `root`. You then use this password for the ssh command below.
# Some notes:
# --script makes `parted` not prompt user
# `--flake` in nixos-generate-config will setup if i want to use flakes (which i probably do)

vm/bootstrap:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
	       parted /dev/sda --script \
		  mklabel gpt \
		  mkpart ESP fat32 1MB 512MB \
		  set 1 esp on \
		  mkpart root ext4 512MB 100% && \
	       udevadm settle && \
	       mkfs.fat -F 32 /dev/sda1 -n NIXBOOT && \
	       mkfs.ext4 /dev/sda2 -L NIXROOT && \
	       udevadm settle && \
	       mount /dev/disk/by-label/NIXROOT /mnt && \
	       mkdir -p /mnt/boot && \
	       mount /dev/disk/by-label/NIXBOOT /mnt/boot; \
	       nixos-generate-config --root /mnt --flake; \
		sed --in-place '/system\.stateVersion = .*/a \
			nix.package = pkgs.nixVersions.latest;\n \
			nix.extraOptions = \"experimental-features = nix-command flakes\";\n \
			services.openssh.enable = true;\n \
			services.openssh.settings.PasswordAuthentication = true;\n \
			services.openssh.settings.PermitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd && reboot; \
	"
vm/setup:
	NIXUSER=root $(MAKE) vm/copy
	NIXUSER=root $(MAKE) vm/switch
	ssh $(SSH_OPTIONS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo reboot; \
	"

vm/copy:
	rsync -av -e 'ssh $(SSH_OPTIONS) -p$(NIXPORT)' \
		--exclude='.git/' \
		--exclude='.gitignore' \
		--rsync-path="sudo rsync" \
		$(MAKEFILE_DIR)/ $(NIXUSER)@$(NIXADDR):/nixos-config

# run the nixos-rebuild switch command. This does NOT copy files so you
# have to run vm/copy before.
vm/switch:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"/nixos-config#${NIXNAME}\" \
	"

disko:
	sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount $(MAKEFILE_DIR)/hosts/$(NIXNAME)/disko.nix

install:
	sudo nixos-install --no-root-passwd --flake $(MAKEFILE_DIR)#$(NIXNAME)
	@echo "Now that it's installed, we will reboot in 5 seconds. Remember to change password for $(NIXUSER)!"
	sleep 5
	reboot

rebuild-ppw:
	NIXNAME=ppw
	sudo nixos-rebuild switch --flake $(MAKEFILE_DIR)#$(NIXNAME)
rebuild-pw:
	NIXNAME=pw
	sudo nixos-rebuild switch --flake $(MAKEFILE_DIR)#$(NIXNAME)

# You use this so that your nix will install the correct drivers and such for your hardware
hardware:
	sudo nix run --option experimental-features "nix-command flakes" nixpkgs#nixos-facter -- -o facter.json
