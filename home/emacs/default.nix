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
      forge
      gptel
      olivetti
      vertico
      marginalia
      embark
      embark-consult
      helpful
      orderless
      rg
      consult
      corfu
      auctex
      pdf-tools
    ];
  };
}
