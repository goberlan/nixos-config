{ pkgs, inputs, ... }:
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
        enumitem
        titlesec
        ec
        cm-super
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
    mpv
    anki
    signal-desktop-bin
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.gemini-cli
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.pi-coding-agent
    # claude is not free... i can do pi
  ];

  imports = [
    ./git.nix
    ./hyprland.nix
    ./waybar.nix
    ./ghostty.nix
    ./emacs/default.nix
    ./bluetooth.nix
    ./audio.nix
    ./sc2.nix
    ./ssh.nix
    ./direnv.nix
    ./bash.nix
  ];
}
