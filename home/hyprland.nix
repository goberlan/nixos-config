{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        input = {
          kb_layout = "us";
          kb_variant = "colemak_dh";
          touchpad = {
            disable_while_typing = false;
            natural_scroll = true;
          };
        };
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

