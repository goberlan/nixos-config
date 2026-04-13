# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disk-config.nix
{ device ? "/dev/nvme0n1", ... }: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              extraArgs = [ "-n" "NIXBOOT" ];
            };
          };
          swap = {
            size = "64G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true; 
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              extraArgs = [ "-L" "NIXROOT" ];
            };
          };
        };
      };
    };
  };
}
