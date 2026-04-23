{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    xwayland
  ];
}
