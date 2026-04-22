{ pkgs, ... }: {
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
  xdg.configFile."emacs".source = ./config;  
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: with epkgs; [
      nix-mode
      magit
      gptel
      vertico
      marginalia
      embark
      rg
      consult
      corfu
      auctex
      pdf-tools
    ];
  };
}
