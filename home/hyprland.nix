{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, return, exec, ghostty +new-window" # ghostty should auto run as a d-bus/systemd app so this should work
          "$mod, Q, killactive"
        ];
      };
    };

  programs.waybar.enable = true;
  programs.fuzzel.enable = true;  # app launcher
  programs.ghostty.enable = true;
}

