HOST=$1
sudo nixos-install --flake /tmp/nixos-config#$HOST
echo "Now that it's installed, we will reboot (that's all that's needed). Remember to change password for wj!"
sleep 5
reboot
