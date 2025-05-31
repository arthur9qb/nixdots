{
    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs/nixos-unstable";
        };
        disko = {
            url = "github:nix-community/disko";
            inputs = {
                nixpkgs = {
                    follows = "nixpkgs";
                };
            };
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs = {
                nixpkgs = {
                    follows = "nixpkgs";
                };
            };
        };
        ags = {
            url = "github:aylur/ags";
            inputs = {
                nixpkgs = {
                    follows = "nixpkgs";
                };
            };
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                nixpkgs = {
                    follows = "nixpkgs";
                };
            };
        };
    };
    outputs = {
        nixpkgs,
        ...
    }@inputs: let
        pkgs = import nixpkgs {
            system = "x86_64-linux";
        };
        lib = import ./lib pkgs;
        overlays = import ./overlays;
    in {
        nixosConfigurations = {
            nixlt = import ./hosts/nixlt {
                inherit inputs lib overlays;
            };
        };
    };
}
