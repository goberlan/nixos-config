# In your home.nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    blueman
  ];

  # Home Manager can manage the blueman-applet service for you
  services.blueman-applet.enable = true; 
}
