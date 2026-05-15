{ pkgs, ...}: {
environment.systemPackages = with pkgs; [
  wineWowPackages.staging  # 64-bit wine with 32-bit support
  winetricks
];

hardware.graphics = {
  enable = true;
  enable32Bit = true;
};
}
