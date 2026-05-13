{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # this will fail if already partitioned
    ./disko.nix
    ../../common
  ];

  networking = {
    hostName = "pw";
  };

  users.users.wj.openssh.authorizedKeys.keyFiles = [ ./authorized_keys ];
}
