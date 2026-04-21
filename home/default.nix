{ pkgs, ... }:
let
  tex = (
    pkgs.texliveBasic.withPackages (
      ps: with ps; [
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        #(setq org-latex-compiler "lualatex")
        #(setq org-preview-latex-default-process 'dvisvgm)
      ]
    )
  );
in
{
  home.username = "wj";
  home.homeDirectory = "/home/wj";
  home.stateVersion = "25.11";
  # may not need this... may be better to use programs.<prog>.enable
  home.packages = with pkgs; [
    zig
    tex

  ];

  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./ghostty.nix
    ./emacs/default.nix
    ./bluetooth.nix
  ];
}
