{
    pkgs,
    ...
}:
    with pkgs; stdenvNoCC.mkDerivation {
        name = "winsur-white-cursors";
        src = fetchFromGitHub {
            owner = "yeyushengfan258";
            repo = "WinSur-white-cursors";
            rev = "e6d1ba908df807a93b7a81ff43cb6f2fb7eb2d04";
            sha256 = "sha256-EdliC9jZcFmRBq3KCNiev5ECyCWdNlb0lA9c2/JVqwo=";
        };
        phases = [
            "installPhase"
        ];
        installPhase = ''
            mkdir -p $out/share/icons/WinSur-white-cursors
            cp -r $src/dist/* $out/share/icons/WinSur-white-cursors
        '';
    }
