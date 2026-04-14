{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
	"$modS" = "$mod SHIFT";
	"$menu" = "fuzzel";
        input = {
          kb_layout = "us";
          kb_variant = "colemak_dh";
          touchpad = {
            disable_while_typing = false;
            natural_scroll = false;
          };
        };
	general = {
		gaps_in = 5;
		gaps_out = 20;
		border_size = 2;
	};
        bind = [
          "$mod, return, exec, ghostty +new-window" # ghostty should auto run as a d-bus/systemd app so this should work
          "$mod, K, killactive"
	  "$mod, Space, exec, $menu"
	  "$mod, E, exec, $fileManager"
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

  programs.waybar.enable = true;
  programs.fuzzel.enable = true;  # app launcher
  programs.ghostty.enable = true;
}

