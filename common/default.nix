{ pkgs, ... }: {
  system.stateVersion = "25.11";
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # For framework: Fn + Alt + F11 (hold the Alt key after presssing them)
  # Useful shortcuts, triggered using Alt+SysRq+<key>:
  #  h: Print help to the system log.
  #  f: Trigger the kernel oom killer.
  #  s: Sync data to disk before triggering the reset options below.
  #  e: SIGTERM all processes except PID 0.
  #  i: SIGKILL all processes except PID 0.
  #  b: Reboot the system.
  # Check journalctl to see if you are triggering the shortcuts correctly, which might be different for your keyboard, as noted in the Wikipedia page. 
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    ripgrep
    fd
    fzf
    unzip
    zip
    zoxide
    nixfmt
    gnumake
    brightnessctl
  ];

  users.users.wj = {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.wj = import ../home;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;

  # # TODO may not want or need for server?
  programs.firefox.enable = true;
  imports = [
    # Applies to all hosts
    ../modules/hyprland.nix
    ../modules/audio.nix
    ../modules/greetd.nix
    ../modules/wine.nix
  ];

  # Enable Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Powers up the controller on boot
    settings = {
      General = {
        # https://wiki.nixos.org/wiki/Bluetooth#Enabling_A2DP_Sink
        Enable = "Source,Sink,Media,Socket"; # for A2DP support
        # https://wiki.nixos.org/wiki/Bluetooth#Showing_battery_charge_of_bluetooth_devices
        Experimental = true;   # Battery % reporting
      };
    };
  };

  # Enable the Bluetooth system service (Bluez)
  services.blueman.enable = true;
}
