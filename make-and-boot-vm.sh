# Change these as you need...
VM_PORT=6022
OVMF_ROOT=/usr/share/edk2/x64/
VM_DIR=$HOME/vm/nixos
NIXOS_VERSION=25.11
NIXOS_ISO=$VM_DIR/nixos-$NIXOS_VERSION.iso
NIXOS_IMG_NAME=nixos-$NIXOS_VERSION.img
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
if [[ ! -f $VM_DIR/$NIXOS_IMG_NAME ]]; then
    echo "No image exists. Creating now."
    fallocate -l 60G $VM_DIR/$NIXOS_IMG_NAME
fi

# Boot VM
# man qemu-system for info on these options used.
# also: https://wiki.archlinux.org/title/QEMU

if [[ $1 == "-bg" ]]; then
    echo "Booting VM in background."
    qemu-system-x86_64 -enable-kvm -cdrom $NIXOS_ISO -m 32G -boot order=d -drive if=pflash,format=raw,readonly=on,file=$OVMF_ROOT/OVMF_CODE.4m.fd \
                       -drive if=pflash,format=raw,file=$HOME/vm/nixos/OVMF_VARS.4m.fd -drive file=$VM_DIR/$NIXOS_IMG_NAME,format=raw -nic user,hostfwd=tcp::$VM_PORT-:22 -vga std &
else
    echo "Booting VM in foreground."
    qemu-system-x86_64 -enable-kvm -cdrom $NIXOS_ISO -m 32G -boot order=d -drive if=pflash,format=raw,readonly=on,file=$OVMF_ROOT/OVMF_CODE.4m.fd \
                       -drive if=pflash,format=raw,file=$HOME/vm/nixos/OVMF_VARS.4m.fd -drive file=$VM_DIR/$NIXOS_IMG_NAME,format=raw -nic user,hostfwd=tcp::$VM_PORT-:22 -vga std
fi

