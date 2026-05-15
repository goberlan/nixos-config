{ ... }: {
  programs.git = {
    enable = true;
    userName = "goberlan";
    userEmail = "goberlan@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
