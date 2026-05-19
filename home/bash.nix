{ pkgs, ... }:
let
  rustInitProject = pkgs.writeShellApplication {
    name = "rust-init-project";
    text = ''
      nix flake init -t ~/nixos-config#rust
    '';
  };
in
{
  home.packages = [ rustInitProject ];
  programs.bash = {
    enable = true;
  };

}
