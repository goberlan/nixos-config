{ pkgs, ... }: {
    programs.hyprland.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    hardware.graphics.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
      xwayland
    ];
}

  
