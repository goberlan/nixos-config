# nix flake init -t ~/nixos-config#rust
# nix develop
{
  description = "Basic rust template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          rustc
          cargo
          rust-analyzer
          rustfmt
          clippy
          pkg-config
          openssl
        ];

        RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
      };
    };
}
