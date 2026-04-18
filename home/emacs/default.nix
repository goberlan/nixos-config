{ pkgs, ... }: {
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
  xdg.configFile."emacs".source = ./config;  
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraConfig = builtins.readFile ./config/init.el;
    extraPackages = e: [
      e.nix-mode
      e.nixfmt
      e.magit
      e.gptel
    ];
  };
}
