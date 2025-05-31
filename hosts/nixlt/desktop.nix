{
    pkgs,
    ...
}: {
    programs = { 
        uwsm = {
            enable = true;
        };
        dconf = {
            enable = true;
        };
        hyprland = {
            enable = true;
            xwayland = {
                enable = true;
            };
            withUWSM = true;
        }; 
    };
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
            ];
        };
        terminal-exec = {
            enable = true;
            settings = {
                default = [
                    "ghostty.desktop"
                ];
            };
        };
    };
    fonts = {
        packages = with pkgs; [
            serious-shanns-nerd-font
            mali-font
            comic-jens-free-pro-font
            hanyi-senty-bubbletea-font
            hui-font
            nanum-pen-script-font
            noto-fonts-color-emoji
        ];
        fontconfig = {
            enable = true;
            defaultFonts = {
                serif = [
                    "SeriousShanns Nerd Font Propo"
                    "Mali"
                    "Comic Jens Free Pro"
                    "HanyiSentyBubbleTea"
                    "HuiFontP"
                    "Nanum Pen"
                ];
                sansSerif = [
                    "SeriousShanns Nerd Font"
                    "Mali"
                    "Comic Jens Free Pro"
                    "HanyiSentyBubbleTea"
                    "HuiFontP"
                    "Nanum Pen"
                ];
                monospace = [
                    "SeriousShanns Nerd Font Mono"
                    "Mali"
                    "Comic Jens Free Pro"
                    "HanyiSentyBubbleTea"
                    "HuiFontP"
                    "Nanum Pen"
                ];
                emoji = [
                    "Noto Color Emoji"
                ];
            };
        };
    };
}

