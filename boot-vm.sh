qemu-system-x86_64 -enable-kvm -cdrom ~/Downloads/nixos-minimal-25.05.812778.3acb677ea67d-x86_64-linux.iso -m 32G -boot order=d -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2/x64/OVMF_CODE.4m.fd \
-drive if=pflash,format=raw,file=/home/whompyjaw/vm/nixos/ovmf_vars.4m.fd -drive file=~/vm/nixos/nixos.img,format=raw -nic user,hostfwd=tcp::6022-:22 -vga std
