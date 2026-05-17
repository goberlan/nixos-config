{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./disko.nix
    ./kanata.nix
    ../../common
  ];

  networking = {
    hostName = "ppw";
  };

  powerManagement.powertop.enable = true;
  system.stateVersion = "25.11";
  # FIX 5-10-2026: This was to prevent the key spamming from happening.
  # Usb keyboard was suspending after 5 seconds and then they key i press to wake
  # was a key it would spam.
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  facter.reportPath = ./facter.json;

  # for touchpad
  services.libinput.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
}
