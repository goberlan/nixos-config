{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # May need these for framework hw modules
    # inputs.hardware.nixosModules.common-pc-ssd
    # inputs.hardware.nixosModules.framework-16-7040-amd
    # this will have all the partitioning and such
    ./hardware-configuration.nix
    # this is causing build issues when already partitioned
    ./disko.nix
    ./kanata.nix
    ../../common
  ];

  networking = {
    hostName = "ppw";
  };

  powerManagement.powertop.enable = true;
  system.stateVersion = "25.11";
  # FIX : This was to prevent the key spamming from happening.
  # Usb keyboard was suspending after 5 seconds and then they key i press to wake
  # was a key it would spam.
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  # for touchpad
  services.libinput.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.options = "caps:escape";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Framework-specific: Ensure firmware is available
  # hardware.enableAllFirmware = true;
}
