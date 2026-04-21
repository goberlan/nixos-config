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
    inputs.disko.nixosModules.disko
    # this is causing build issues when already partitioned
    ./disko.nix
    ./kanata.nix
    # Applies to all hosts
    ../../common
    ../../modules/hyprland.nix
  ];

  home-manager.users.wj = import ../../home;

  networking = {
    hostName = "ppw";
  };

  powerManagement.powertop.enable = true;
  system.stateVersion = "25.11";

  # for touchpad
  services.libinput.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.options = "caps:escape";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # Powers up the controller on boot

  # Framework-specific: Ensure firmware is available
  # hardware.enableAllFirmware = true;

  # Enable the Bluetooth system service (Bluez)
  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    # pipewire doesn't output on its own
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
