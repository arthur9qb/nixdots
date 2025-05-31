{
    lib,
    overlays,
    ...
}: {
    imports = lib.utils.nixos.mkModulesFromDirectory {
        directory = ./.;
        exclude = [
            "default.nix"
            "system.nix"
        ];
    };
    system = {
        stateVersion = "25.05";
    };
    nix = {
        settings = {
            experimental-features = "nix-command flakes";
            auto-optimise-store = true;
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };
    nixpkgs = {
        hostPlatform = "x86_64-linux";
        overlays = with overlays; [
            additions
        ];
        config = {
            allowUnfree = true;
        };
    };
    documentation = {
        nixos = {
            enable = false;
        };
    };
}
