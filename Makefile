NIXADDR ?= localhost
# This can be whatever you want it to be when you start the qemu VM
NIXPORT ?= 6022
NIXUSER ?= wj

# Get the path to this Makefile and directory
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# The name of the nixosConfiguration in the flake
NIXNAME ?= nix-test

# SSH options that are used. These aren't meant to be overridden but are
# reused a lot so we just store them up here.
SSH_OPTIONS=-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# TODO: Add a way to save secrets

# bootstrap a brand new VM. The VM should have NixOS ISO on the CD drive
# and just set the password of the root user to "root". This will install
# NixOS. After installing NixOS, you must reboot and set the root password
# for the next step.
vm/setup-fs:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
  	       parted /dev/sda --script \
		  mklabel gpt \
		  mkpart ESP fat32 1MiB 501MiB \
		  set 1 esp on \
		  mkpart primary ext4 501MiB 100% && \
	       udevadm settle && \
	       mkfs.fat -F 32 /dev/sda1 -n NIXBOOT && \
	       mkfs.ext4 /dev/sda2 -L NIXROOT && \
	       udevadm settle && \
	       mount /dev/disk/by-label/NIXROOT /mnt && \
	       mkdir -p /mnt/boot && \
	       mount /dev/disk/by-label/NIXBOOT /mnt/boot; \
	       nixos-generate-config --root /mnt; \
	       sed --in-place 's/#\ boot.loader.grub.device/boot.loader.grub.device/g' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd && reboot; \
	"
