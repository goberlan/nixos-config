HOST=$1
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/nixos-config/hosts/$HOST/disko.nix
