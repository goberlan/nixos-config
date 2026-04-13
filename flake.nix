{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    # ".follows" makes home-manager follow the same versoin as nixpkgs.url so you don't end up with 2 different nixpkgs 25.11
    # the home-manager flake.nix would have a different lock
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # this is to get special hardware changes 
    hardware.url = "github:nixos/nixos-hardware";

    # TODO: may need overlays at some points
    # Overlays allow you to merge a uniquely defined package over what is in the 25.11 packages. This is incase the 25.11 has bugs and you need to "overlay" the newer version over the default one in pkgs-25.11 release
  };

  # the "..." allows you to add more variables to the "inputs" above without errors or for specifically selecting them for "destructuring".
  # the "@ inputs" will allow you to access the extra variables that aren't explicitly stated before the ellipsis.
  # So, if i add disko = {} as a new variable, i /could/ add it before the elipsis to have an explicit handle, or i can just use `inputs.disko` to access it
  outputs = {
    self,
      nixpkgs,
      home-manager,
      ...
  } @ inputs: let
    # the :let syntax allows you to define local variables that can be used in the "in {}" block below
    # Example:
    systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin"];

    # this is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument (don't really understand this)
    forAllSystems = nixpkgs.lib.genAttrs systems;

    # function so we don't need to duplicate code for each host
    mkHost = hostName: system: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs hostName; };
      modules = [
        ./hosts/${hostName}
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # passes global inputs to home.nix
          # does it really need to be extraSpecialArgs?
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
            
    # define variables here
  in {
    nixosConfig = {
      ppw = mkHost "ppw" "x86_64-linux";
      pw = mkHost "pw" "x86_64-linux";
      pws = mkHost "pws" "x86_64-linux";
    };
  };
}
 
