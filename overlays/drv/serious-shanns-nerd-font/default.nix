{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "serious-shanns-nerd-font";
        src = fetchurl {
            url = "https://raw.githubusercontent.com/kaBeech/serious-shanns/refs/heads/main/SeriousShanns/SeriousShanns.zip";
            sha256 = "sha256-TXdn6d+ja/89DUX6uJK0ptA1KoMBuDF8bYlfDQ5nbMI=";
        };
        buildInputs = [
            unzip
        ];
        phases = [
            "installPhase"
        ];
        installPhase = ''
            mkdir -p $out/share/fonts/opentype
            for dir in NerdFontPropo NerdFont NerdFontMono; do
                unzip -j "$src" "*/$dir/*.otf" -d "$out/share/fonts/opentype"
            done
        '';
    }
