{ pkgs, ... }:
let
  getSc2 = pkgs.writeShellApplication {
    name = "get-sc2";
    runtimeInputs = [ pkgs.rsync ];
    text = ''
      rsync -avz --info=progress2 pws:/home/wj/wine-sc2 "$HOME/wine-sc2/"
    '';
  };
in
{
  home.packages = [ getSc2 ];
  xdg.desktopEntries.battlenet = {
    name = "Battle.net";
    comment = "Battle.net launcher via Wine";
    exec = "battlenet";
    icon = "/home/wj/wine-sc2/drive_c/Program Files (x86)/Battle.net/Battle.net Launcher.exe";
    categories = [ "Game" ];
    terminal = false;
  };

  home.file.".local/bin/battlenet" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      export WINEPREFIX="$HOME/wine-sc2"
      exec ${pkgs.wineWowPackages.staging}/bin/wine \
        "C:/Program Files (x86)/Battle.net/Battle.net Launcher.exe" "$@"
    '';
  };
}
