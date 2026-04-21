{ pkgs, ... }: {
  home.username = "wj";
  home.homeDirectory = "/home/wj";
  home.stateVersion = "25.11";
  # may not need this... may be better to use programs.<prog>.enable
  # home.packages = with pkgs; [
  #   zig
  # ];
    
  imports = [
    ./hyprland.nix
    ./ghostty.nix
    ./emacs/default.nix
    ./bluetooth.nix
  ];
}
