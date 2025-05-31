{
    inputs,
    pkgs,
    lib,
    ...
}: {
    wayland = {
        windowManager = {
            hyprland = {
                enable = true;
                xwayland = {
                    enable = true;
                };
                systemd = {
                    enable = false;
                };
                settings = with lib.utils.hyprland; {
                    exec-once = [
                        "hyprctl hyprsunset temperature 5000"
                        "hyprctl setcursor Winsur-white-cursors 40"
                    ];
                    monitor = [
                        "eDP-1, 1920x1080@165, 0x0, 1"
                        ", preferred, auto, 1"
                    ];
                    input = {
                        kb_layout = "us, th";
                        kb_options = "caps:none, grp:caps_toggle";
                        touchpad = {
                            natural_scroll = false;
                        };
                        accel_profile = "flat";
                    };
                    general = {
                        gaps_in = 5;
                        gaps_out = 10;
                        border_size = 3;
                        "col.active_border" = "rgb(8caaee)";
                        "col.inactive_border" = "rgb(737994)";
                        layout = "master";
                    };
                    decoration = {
                        rounding = 10;
                        rounding_power = 2;
                        shadow = {
                            enabled = false;
                        };
                        blur = {
                            enabled = true;
                            passes = 1;
                            size = 3;
                        };
                    };
                    misc = {
                        disable_hyprland_logo = true;
                        disable_splash_rendering = true;
                        background_color = "rgb(303446)";
                        vrr = 1;
                    }; 
                    dwindle = {
                        pseudotile = true;
                        preserve_split = true;
                        smart_split = true;
                        smart_resizing = true;
                    };
                    master = {
                        smart_resizing = true;
                    };
                    animations = {
                        enabled = true;
                        bezier = [
                            "easeOutQuint, 0.23, 1, 0.32, 1"
                            "almostLinear, 0.5, 0.5, 0.75, 1.0"
                            "linear, 0, 0, 1, 1"
                        ];
                        animation = [
                            "windowsIn, 1, 7, easeOutQuint, popin"
                            "windowsOut, 1, 5, linear, popin"
                            "windowsMove, 1, 3, almostLinear" 
                            "layersIn, 1, 7, easeOutQuint, fade"
                            "layersOut, 1, 5, linear, fade"
                            "fadeIn, 1, 4, almostLinear"
                            "fadeOut, 1, 3, almostLinear"
                            "fadeLayersIn, 1, 4, almostLinear"
                            "fadeLayersOut, 1, 3, almostLinear"
                            "border, 1, 7, easeOutQuint"
                            "workspacesIn, 1, 4, almostLinear, fade"
                            "workspacesOut, 1, 4, almostLinear, fade"
                        ];
                    };
                    windowrulev2 = [
                        "opacity 0.9 0.9 1, class:.*"
                        "float, class:zen-beta, title:Picture-in-Picture"
                        "idleinhibit focus, class:steam_app_.*"
                    ];
                    "$uwsm-app" = "uwsm app --";
                    "$screenlock" = "hyprlock";
                    "$terminal" = "xdg-terminal-exec";
                    "$editor" = "nvim";
                    "$filemanager" = "yazi";
                    "$taskmanager" = "btop";
                    "$browser" = "zen";
                    bind = mkBind [
                        {
                            modifier = "super";
                            trigger = [{ key = "q"; }];
                            command = "killactive";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "f"; }];
                            command = "togglefloating";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "f11"; }];
                            command = "fullscreen";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "s"; }];
                            command = "togglesplit";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "p"; }];
                            command = "pseudo";
                        } 
                        {
                            modifier = "super";
                            trigger = [
                                { key = "left"; argument = "l"; }
                                { key = "right"; argument = "r"; }
                                { key = "up"; argument = "u"; }
                                { key = "down"; argument = "d"; }
                            ];
                            command = "movefocus";
                        }
                        {
                            modifier = "super shift";
                            trigger = [
                                { key = "left"; argument = "l"; }
                                { key = "right"; argument = "r"; }
                                { key = "up"; argument = "u"; }
                                { key = "down"; argument = "d"; }
                            ];
                            command = "movewindow";
                        }
                        {
                            modifier = "super ctrl";
                            trigger = [
                                { key = "left"; argument = "-10 0"; }
                                { key = "right"; argument = "10 0"; }
                                { key = "up"; argument = "0 -10"; }
                                { key = "down"; argument = "0 10"; }
                            ];
                            command = "resizeactive";
                        }
                        {
                            modifier = "super";
                            trigger = [
                                { key = "1"; argument = "1"; }
                                { key = "2"; argument = "2"; }
                                { key = "3"; argument = "3"; }
                                { key = "4"; argument = "4"; }
                                { key = "5"; argument = "5"; }
                                { key = "6"; argument = "6"; }
                                { key = "7"; argument = "7"; }
                                { key = "8"; argument = "8"; }
                                { key = "9"; argument = "9"; }
                                { key = "0"; argument = "10"; }
                            ];
                            command = "workspace";
                        }
                        {
                            modifier = "super shift";
                            trigger = [
                                { key = "1"; argument = "1"; }
                                { key = "2"; argument = "2"; }
                                { key = "3"; argument = "3"; }
                                { key = "4"; argument = "4"; }
                                { key = "5"; argument = "5"; }
                                { key = "6"; argument = "6"; }
                                { key = "7"; argument = "7"; }
                                { key = "8"; argument = "8"; }
                                { key = "9"; argument = "9"; }
                                { key = "0"; argument = "10"; }
                            ];
                            command = "movetoworkspace";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "tab"; }];
                            command = "overview:toggle";
                        }
                        {
                            modifier = "super shift";
                            trigger = [{ key = "l"; }];
                            execute = true;
                            command = "$uwsm-app $screenlock";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "t"; }];
                            execute = true;
                            command = "$uwsm-app $terminal";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "n"; }];
                            execute = true;
                            command = "$uwsm-app $terminal $editor";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "e"; }];
                            execute = true;
                            command = "$uwsm-app $terminal $filemanager";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "escape"; }];
                            execute = true;
                            command = "$uwsm-app $terminal $taskmanager";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "b"; }];
                            execute = true;
                            command = "$uwsm-app $browser";
                        } 
                    ];
                    bindm = mkBind [
                        {
                            modifier = "super";
                            trigger = [{ key = "mouse:273"; }];
                            command = "resizewindow";
                        }
                        {
                            modifier = "super";
                            trigger = [{ key = "mouse:272"; }];
                            command = "movewindow";
                        }
                    ];
                    ecosystem = {
                        no_update_news = true;
                        no_donation_nag = true;
                    };
                    plugin = {
                        overview = {
                            workspaceActiveBorder = "rgb(8caaee)";
                            workspaceInactiveBorder = "rgb(737994)";
                            workspaceBorderSize = 2;
                            centerAligned = true;
                            gapsIn = 5;
                            gapsOut = 10;
                            affectStrut = false;
                            showNewWorkspace = false;
                            showEmptyWorkspace = false;
                        };
                    };
                };
                plugins = with pkgs.hyprlandPlugins; [
                    hyprspace
                ];
            };
        };
    };
    services = {
        hypridle = {
            enable = true;
            settings = {
                general = {
                    ignore_dbus_inhibit = false;
                    lock_cmd = "pidof hyprlock || hyprlock";
                    after_sleep_cmd = "hyprctl dispatch dpms on";
                };
                listener = [
                    {
                        timeout = 150;
                        on-timeout = "brillo -O; brillo -u 300000 -S 10";
                        on-resume = "brillo -u 300000 -I";
                    }
                    {
                        timeout = 300;
                        on-timeout = "loginctl lock-session";
                    }
                    {
                        timeout = 305;
                        on-timeout = "hyprctl dispatch dpms off";
                        on-resume = "hyprctl dispatch dpms on";
                    }
                    {
                        timeout = 600;
                        on-timeout = "systemctl suspend";
                    }
                ];
            };
        };
        hyprpaper = {
            enable = true;
            settings = {
                ipc = false;
                splash = false;
                preload = [
                    "${./../.. + "/assets/images/wallpaper/sky.png"}"
                ];
                wallpaper = [
                    ",${./../.. + "/assets/images/wallpaper/sky.png"}"
                ];
            };
        };
        hyprsunset = {
            enable = true;
        };
        polkit-gnome = {
            enable = true;
        };
    };
    programs = {
        hyprlock = {
            enable = true;
            settings = {
                general = {
                    disable_loading_bar = true;
                    hide_cursor = true;
                    grace = 3;
                    ignore_empty_input = true;
                    fail_timeout = "3000";
                };
                background = [
                    {
                        monitor = "";
                        path = "${./../.. + "/assets/images/wallpaper/sky.png"}";
                        blur_passes = 2;
                        blur_size = 7;
                    }
                ];
                label = [
                    {
                        monitor = "";
                        position = "0, 300";
                        halign = "center";
                        valign = "center";
                        font_family = "SeriousShanns Nerd Font Mono Bold";
                        font_size = 130;
                        text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
                        color = "rgb(8caaee)";
                    }
                    {
                        monitor = "";
                        position = "0, 200";
                        halign = "center";
                        valign = "center";
                        font_family = "SeriousShanns Nerd Font Mono Bold";
                        font_size = 20;
                        text = "cmd[update:60000] echo \"$(date +\"%A, %-d %B\")\"";
                        color = "rgb(8caaee)";
                    }
                ];
                input-field = [
                    {
                        monitor = "";
                        position = "0, -300";
                        halign = "center";
                        valign = "center";
                        size = "400, 60";
                        outline_thickness = 3;
                        rounding = -1;
                        outer_color = "rgb(51576d)";
                        inner_color = "rgb(303446)";
                        dots_center = true;
                        dots_size = 0.3;
                        dots_spacing = 0.3;
                        font_family = "SeriousShanns Nerd Font Mono Bold";
                        font_color = "rgb(c6d0f5)";
                        check_color = "rgb(e5c890)";
                        fail_color = "rgb(e78284)";
                        placeholder_text = "";
                        fail_text = "";
                        fade_on_empty = true;
                    }
                ];
                animations = {
                    enabled = true;
                    bezier = [
                        "almostLinear, 0.5, 0.5, 0.75, 1.0"
                        "linear, 0, 0, 1, 1"
                    ];
                    animation = [
                        "fadeIn, 1, 3, almostLinear"
                        "fadeOut, 1, 3, almostLinear"
                        "inputFieldColors, 1, 3, almostLinear"
                        "inputFieldFade, 1, 3, linear"
                        "inputFieldWidth, 1, 3, almostLinear"
                        "inputFieldDots, 1, 1, almostLinear"
                    ];
                };
            };
        };
        ags = {
            enable = true;
            extraPackages = with inputs.ags.packages.${pkgs.system}; [
                apps
                auth
                battery
                bluetooth
                hyprland
                mpris
                network
                notifd
                powerprofiles
                tray
                wireplumber
            ];
        };
    }; 
    gtk = {
        enable = true;
        theme = {
            name = "catppuccin-frappe-blue-standard+rimless";
            package = pkgs.catppuccin-gtk.override {
                accents = [
                    "blue"
                ];
                size = "standard";
                tweaks = [
                    "rimless"
                ];
                variant = "frappe";
            };
        };
        iconTheme = {
            name = "Colloid-Catppuccin-Dark";
            package = pkgs.colloid-icon-theme.override {
                schemeVariants = [
                    "catppuccin"
                ];
                colorVariants = [
                    "default"
                ];
            };
        };
        cursorTheme = {
            name = "WinSur-white-cursors";
            size = 40;
            package = pkgs.winsur-white-cursors;
        };
        font = {
            name = "SeriousShanns Nerd Font Mono";
            size = 15;
            package = pkgs.serious-shanns-nerd-font;
        };
    };
    qt = {
        enable = true;
        platformTheme = {
            name = "qtct";
        };
        style = {
            name = "kvantum";
        };
    };
    home = {
        pointerCursor = {
            name = "WinSur-white-cursors";
            size = 40;
            package = pkgs.winsur-white-cursors;
            gtk = {
                enable = true;
            };
        };
        sessionVariables = {
            PAGER = "ov";
        };
    };
    dconf = {
        settings = {
            "org/gnome/desktop/privacy" = {
                remember-recent-files = false;
            };
            "org/gnome/desktop/interface" = {    
                color-scheme = "prefer-dark";
            };
            "org/virt-manager/virt-manager/connections" = {
                autoconnect = ["qemu:///system"];
                uris = ["qemu:///system"];
            };
        };
    };
    xdg = { 
        userDirs = {
            enable = true;
            createDirectories = true;
            desktop = null;
        };
        mimeApps = {
            enable = true;
            defaultApplications = lib.utils.xdg.mkDefaultApplication [
                {
                    name = "yazi.desktop";
                    mimes = [
                        "inode/directory"
                    ];
                }
                {
                    name = "zen-beta.desktop";
                    mimes = [
                        "x-scheme-handler/http"
                        "x-scheme-handler/https"
                        "text/html"
                    ];
                } 
            ];
        };
        configFile = let
            qtConfig = (pkgs.formats.ini { }).generate "qt.conf" {
                Appearance = {
                    style = "kvantum";
                    icon_theme = "Colloid-Catppuccin-Dark";
                };
            };
        in {
            "Kvantum/catppuccin-frappe-blue" = {
                source = "${pkgs.catppuccin-kvantum}/share/Kvantum/catppuccin-frappe-blue";
            };
            "Kvantum/kvantum.kvconfig" = {
                source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
                    General = {
                        theme = "catppuccin-frappe-blue";
                    };
                };
            };
            "qt5ct/qt5ct.conf" = {
                source = qtConfig;
            };
            "qt6ct/qt6ct.conf" = {
                source = qtConfig;
            };
        };
    };
}
