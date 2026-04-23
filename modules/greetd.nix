{ pkgs, ... }:
{

  # modules/greetd.nix
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'uwsm start hyprland-uwsm.desktop'";
      user = "greeter";
    };
  };

}
