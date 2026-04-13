# Change these as you need...
VM_PORT=6022
OVMF_ROOT=/usr/share/edk2/x64/
VM_DIR=$HOME/vm/nixos
NIXOS_ISO=$VM_DIR/nixos.iso
NIXOS_VERSION=25.11
mkdir -p $VM_DIR

if [[ ! -f $NIXOS_ISO ]]; then
    echo "No iso file. Getting it!"
    wget --output-document $NIXOS_ISO https://channels.nixos.org/nixos-$NIXOS_VERSION/latest-nixos-minimal-x86_64-linux.iso 
fi

if [[ ! -f $HOME/vm/nixos/OVMF_VARS.4m.fd ]]; then
    echo "No ovmf vars file. This is needed for UEFI booting. Copying..." 
    cp $OVMF_ROOT/OVMF_VARS.4m.fd $HOME/vm/nixos
fi


# I tried the `qemu-img` command but it didn't really work...
if [[ ! -f $VM_DIR/nixos.img ]]; then
    echo "No image exists. Creating now."
    fallocate -l 60G $VM_DIR/nixos.img
fi

# Boot VM
# man qemu-system for info on these options used.
# also: https://wiki.archlinux.org/title/QEMU
echo "Booting VM in background."
qemu-system-x86_64 -enable-kvm -cdrom $NIXOS_ISO -m 32G -boot order=d -drive if=pflash,format=raw,readonly=on,file=$OVMF_ROOT/OVMF_CODE.4m.fd \
-drive if=pflash,format=raw,file=$HOME/vm/nixos/OVMF_VARS.4m.fd -drive file=$VM_DIR/nixos.img,format=raw -nic user,hostfwd=tcp::$VM_PORT-:22 -vga std &
