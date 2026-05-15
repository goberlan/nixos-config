{ ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "rs" = {
        hostname = "fm1631.rsync.net";
        user = "fm1631";
      };
      "pws" = {
        hostname = "192.168.88.119";
        user = "wj";
        forwardX11 = true;
        port = 4195;
      };
      "pw" = {
        hostname = "192.168.88.249";
        user = "wj";
        port = 4195;
      };
      # These are tailscale
      "pwt" = {
          hostname = "100.96.255.46";
          user = "wj";
          port = 4195;
      };
      "pwst" = {
          hostname = "100.93.143.100";
          user = "wj";
          forwardX11 = true;
          port = 4195;
      };
      "mbp" = {
          hostname = "100.99.184.21";
          user = "wj";
          port = 4195;
          extraOptions = { "SetEnv" = "TERM=xterm-256color"; };
      };
    };
  };
}
    
