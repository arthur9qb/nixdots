{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "nanum-pen-script-font";
        src = fetchurl {
            url = "https://font.download/dl/font/nanum-pen.zip";
            sha256 = "sha256-n9NYkVWfkN+7AZAZt+OdJ3lskRYrILblOFTHQ/lNvM4=";
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
