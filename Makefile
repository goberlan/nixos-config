# CHANGE ME
NIXADDR ?= localhost
# This can be whatever you want it to be when you start the qemu VM (it just needs to match what you use in the VM)
NIXPORT ?= 6022
NIXUSER ?= wj

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# The name of the nixosConfiguration in the flake
NIXNAME ?= TODO

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
			services.openssh.enable = true;\n \
			services.openssh.settings.PasswordAuthentication = true;\n \
			services.openssh.settings.PermitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd --flake /mnt/etc/nixos#nixos && reboot; \
	"
