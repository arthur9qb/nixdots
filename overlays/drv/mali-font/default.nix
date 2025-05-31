{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "mali-font";
        src = fetchurl {
            url = "https://font.download/dl/font/mali.zip";
            sha256 = "sha256-eFr2SFohKdu4kiz70nxTqqGKhhZZHBL8LsLUWaxOuPk=";
        };
        buildInputs = [
            unzip
        ];
        phases = [
            "installPhase"
        ];
        installPhase = ''
            mkdir -p $out/share/fonts/truetype
            unzip -j $src "*.ttf" -d $out/share/fonts/truetype
        '';
    }
