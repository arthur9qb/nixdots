{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "hui-font";
        src = fetchurl {
            url = "https://ftp.vector.co.jp/43/55/114/HuiFontP29.lzh";
            sha256 = "sha256-LZLApeQmLcENQxnYpcA38Qq+V8lVAGaUVpRow1OmM0U=";
        };
        buildInputs = [
            lha
        ];
        phases = [
            "installPhase"
        ];
        installPhase = ''
            mkdir -p $out/share/fonts/truetype
            lha -x -w=$out/share/fonts/truetype $src "*.ttf"
        '';
    }
