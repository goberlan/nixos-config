{ pkgs, ... }:
{
  # for when it breaks: https://itsohen.github.io/hyprrulefix/ (converter)
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/files/wallpapers/wp12002164-bladerunner-2049-4k-computer-wallpapers.jpg"
        "~/files/wallpapers/wp12002181-bladerunner-2049-4k-computer-wallpapers.jpg"
      ];
      wallpaper = [
        # By display
        #"DP-2,~/wallpapers/wallpaper2.jpg"
        # By default/fallback
        # ",~/files/wallpapers/wp12002164-bladerunner-2049-4k-computer-wallpapers.jpg"
        ",~/files/wallpapers/wp12002181-bladerunner-2049-4k-computer-wallpapers.jpg"
      ];
    };
  };

  
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      "$modS" = "$mod SHIFT";
      "$modA" = "$mod ALT";
      "$modC" = "$mod CTRL";
      "$modAll" = "$mod CTRL ALT SHIFT";
      "$menu" = "fuzzel";
      input = {
        kb_layout = "us";
        # kb_variant = "colemak_dh";
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        repeat_rate = 60;
        repeat_delay = 190;

        touchpad = {
          # i wonder if this will prevent dragn'cap?
          disable_while_typing = true;
          natural_scroll = false;
        };
      };
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
      };
      gesture = [
        "3, horizontal, workspace"
      ];
      cursor = {
        hide_on_touch = true;
      };
      # when this updates to after 0.52, the syyntax will be:
      # windowrule=match:class com.mitchellh.ghostty, workspace 1
      # <props>, <effec>
      windowrule =
        let
          emacs = "class:emacs";
          steam = "class:steam_app_[0-9]*";
          ghostty = "class:com.mitchellh.ghostty";
          firefox = "class:firefox";
          signal = "class:signal";
        in
        [
          "workspace 1 silent, ${ghostty}"
          "workspace 2 silent, ${emacs}"
          "workspace 3 silent, ${firefox}"
          "workspace 7 silent, ${steam}"
          "workspace 9 silent, ${signal}"
        ];
      # bindel repeats the key when held down (and during lock)
      bindel = [
        "$mod,B,exec,brightnessctl set +3%"
        "$modA,B,exec,brightnessctl set 3%-"
        "$mod,V, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "$modA,V, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "$mod,M, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "$modA,M, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
      # works while locked
      bindl = [
        "$mod,P, exec, playerctl play-pause"
        "$modA,P, exec, playerctl previous"
        "$mod,N, exec, playerctl next"
      ];
      bind = [
        "$mod, return, exec, ghostty +new-window" # ghostty should auto run as a d-bus/systemd app so this should work (this attaches to the server)
        "$mod, K, killactive"
        "$mod CTRL SHIFT ALT, K, exit"
        "$mod, Space, exec, $menu"
        "$mod, E, exec, $fileManager"
        "$mod, F, togglefloating"
        "$mod, S, togglesplit"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 5"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$modS, 1, movetoworkspace, 1"
        "$modS, 2, movetoworkspace, 2"
        "$modS, 3, movetoworkspace, 3"
        "$modS, 4, movetoworkspace, 4"
        "$modS, 5, movetoworkspace, 5"
        "$modS, 6, movetoworkspace, 5"
        "$modS, 7, movetoworkspace, 7"
        "$modS, 8, movetoworkspace, 8"
        "$modS, 9, movetoworkspace, 9"
        "$modS, 0, movetoworkspace, 10"
        "$mod, l, movefocus, l"
        "$mod, r, movefocus, r"
        "$mod, u, movefocus, u"
        "$mod, d, movefocus, d"
      ];
      animations = {
        enabled = true;
        bezier = [
          "easeout,0.5, 1, 0.9, 1"
          "easeoutback,0.34,1.22,0.65,1"
        ];

        animation = [
          "fadeIn,1,3,easeout"
          "fadeLayersIn,1,3,easeout"
          "fadeOut,1,3,easeout"
          "fadeLayersOut,1,3,easeout"
          "fadeSwitch,1,2,easeout"
          "fadeDim,1,3,easeout"
          "fadeShadow,1,2,easeout"
          "border,1,2,easeout"

          "layersIn,1,3,easeoutback,slide"
          "layersOut,1,3,easeoutback,slide"

          "windowsOut,1,3,easeout,slide"
          "windowsMove,1,3,easeoutback"
          "windowsIn,1,3,easeoutback,slide"

          "workspaces,1,2.5,easeoutback,slidefade"
        ];
      };
    };
  };

  programs.fuzzel.enable = true; # app launcher
}
