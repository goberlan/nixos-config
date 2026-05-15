HOST=$1
sudo nixos-install --no-root-passwd --flake /tmp/nixos-config#$HOST
echo "Now that it's installed, we will reboot (that's all that's needed). Remember to change password for wj!"
sleep 5
reboot
