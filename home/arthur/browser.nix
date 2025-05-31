{
    pkgs,
    ...
}: {
    programs = {
        zen-browser = {
            enable = true;
            policies = {
                DisableAppUpdate = true;
                DisableTelemetry = true;
                NoDefaultBookmarks = true;
                ExtensionSettings = {
                    "*" = {
                        installation_mode = "blocked";
                    };
                    "uBlock0@raymondhill.net" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                        installation_mode = "force_installed";
                    };
                    "addon@darkreader.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                        installation_mode = "force_installed";
                    };
                };
            };
            profiles = {
                arthur = let
                    userChrome = pkgs.fetchurl {
                        url = "https://raw.githubusercontent.com/catppuccin/zen-browser/refs/heads/main/themes/Frappe/Blue/userChrome.css";
                        sha256 = "sha256-TN8Ec/6IgInVJKT4sSUFTC3brkzWDoq9C43W6CXw14U=";
                    };
                    userContent = pkgs.fetchurl {
                        url = "https://raw.githubusercontent.com/catppuccin/zen-browser/refs/heads/main/themes/Frappe/Blue/userContent.css";
                        sha256 = "sha256-gKUgU02FlbsELvzhSLjIttwjgLeTpaPF8rd6JKyWV9g=";
                    };
                in {
                    isDefault = true;
                    userChrome = builtins.readFile userChrome;
                    userContent = builtins.readFile userContent;
                };
            };
        };
    };
}
