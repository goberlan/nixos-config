{ pkgs, ... }: {
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernalPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    emacs-pgtk # wayland
    ripgrep
    fd
  ];

  users.users.wj = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.experimental-features = [ "nix-command", "flakes" ];
  networking.networkManager.enable = "true";

  # TODO may not want or need for server?
  programs.firefox.enable = true;
}
