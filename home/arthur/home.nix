{
    lib,
    ...
}: {
    imports = lib.utils.nixos.mkModulesFromDirectory {
        directory = ./.;
        exclude = [
            "default.nix"
            "home.nix"
        ];
    };
    home = rec {
        stateVersion = "25.05";
        username = "arthur";
        homeDirectory = "/home/${username}";
    };
}

