{
    pkgs,
    ...
}: {
    home = {
        packages = with pkgs; [
            wl-clipboard
            pulsemixer
            bluetuith
            ov
            nix-search-cli
        ];
    };
}
