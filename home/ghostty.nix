{ pkgs, ... }: {
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    theme = "catppuccin-mocha";
    font-size = 13;
  };
}
