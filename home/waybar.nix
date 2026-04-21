{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true; # starts with Hyprland via systemd

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # height = 15;
        spacing = 2;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
            urgent = "";
          };
        };

        clock = {
          format = "{:%H:%M  %a %d %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "Bat: {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr} ";
          format-disconnected = "⚠ Disconnected";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }
      window#waybar {
        background-color: rgba(26, 27, 38, 0.9);
        color: #cdd6f4;
        border-bottom: 2px solid #89b4fa;
      }
      #workspaces button.active {
        background-color: #89b4fa;
        color: #1e1e2e;
      }
    '';
  };
}
