{
    inputs,
    ...
}: {
    imports = with inputs; [
        ags.homeManagerModules.default
        zen-browser.homeModules.beta
        ./home.nix
    ];
}

