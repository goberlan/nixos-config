HOST=$1
sudo nixos-build --flake /tmp/nixos-config#$HOST
