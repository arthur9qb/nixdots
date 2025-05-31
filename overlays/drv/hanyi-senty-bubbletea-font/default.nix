{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "hanyi-senty-bubbletea-font";
        src = fetchurl {
            url = "https://www.sentyfont.com/index_htm_files/HanyiSentyBubbleTea.ttf";
            sha256 = "sha256-Q5Iqs73FD3wI3buPTjxsf9boqla6AfxeHOEPdemM+zo=";
        };
        phases = [
            "installPhase"
        ];
        installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp $src $out/share/fonts/truetype
        '';
    }
