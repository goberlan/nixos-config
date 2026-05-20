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
      vterm
      multi-vterm
      vertico
      rustic
      envrc
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
