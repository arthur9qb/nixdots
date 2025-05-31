{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "comic-jens-free-pro-font";
        src = fetchurl {
            url = "https://www.1001fonts.com/download/font/comic-jens.jens-free-pro.ttf";
            sha256 = "sha256-w53/4KIE39oNuM9+xb9G1xD/ZqQjSHoMC8PqHWRKJK8=";
        };
        phases = [
            "installPhase"
        ];
        installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp $src $out/share/fonts/truetype
        '';
    }
