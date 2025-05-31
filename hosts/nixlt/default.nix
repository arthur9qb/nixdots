{
    inputs,
    lib,
    overlays,
    ...
}: with inputs; nixpkgs.lib.nixosSystem {
    specialArgs = {
        inherit inputs lib overlays;
    };
    modules = [ 
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager {
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hb";
                extraSpecialArgs = {
                    inherit inputs;
                };
                users = {
                    arthur = import ../../home/arthur;
                };
            };
        }
        ./system.nix
    ];
}
