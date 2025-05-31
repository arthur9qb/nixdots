{
    pkgs,
    ...
}: {
    programs = {
        yazi = {
            enable = true;
            shellWrapperName = "yz";
            theme = let
                theme = pkgs.fetchurl {
                    url = "https://raw.githubusercontent.com/catppuccin/yazi/refs/heads/main/themes/frappe/catppuccin-frappe-blue.toml";
                    sha256 = "sha256-tfeEqi0JboBGN7HiEhfxBuTMFIxPHdNLm7zCd7q4Dnc=";
                };
            in
                builtins.fromTOML (builtins.readFile theme);
            settings = {
                manager = {
                    sort_by = "natural";
                    sort_sensitive = true;
                    sort_dir_first = true;
                    show_symlink = true;
                    show_hidden = true;
                };
                opener = {
                    pager = [
                        {
                            run = ''
                                ''${PAGER:-less} "$@"
                            '';
                            block = true;
                            desc = "Open the file in a pager";
                        }
                    ];
                    editor = [
                        {
                            run = ''
                                ''${EDITOR:-vim} "$@"
                            '';
                            block = true;
                            desc = "Edit the file";
                        }
                    ];
                    tar = [
                        {
                            run = ''
                                tar vvtf "$1" | ''${PAGER:-less}
                            '';
                            block = true;
                            desc = "Open the archive";
                        }
                    ];
                    "untar-here" = [
                        {
                            run = ''
                                for file in "$@"; do
                                    tar vvxf "$file"
                                done
                            '';
                            desc = "Extract the archive here";
                        }
                    ];
                    "untar-subdirectory" = [
                        {
                            run = ''
                                dst="''${1%.*}"
                                mkdir "$dst"
                                for file in "$@"; do
                                    tar vvxf "$file" -C "$dst/"
                                done
                            '';
                            desc = "Extract the archive to a subdirectory";
                        }
                    ];
                    zip = [
                        {
                            run = ''
                                unzip -l "$1" | ''${PAGER:-less}
                            '';
                            block = true;
                            desc = "Open the archive";
                        }
                    ];
                    "unzip-here" = [
                        {
                            run = ''
                                for file in "$@"; do
                                    unzip "$file"
                                done
                            '';
                            desc = "Extract the archive here";
                        }
                    ];
                    "unzip-subdirectory" = [
                        {
                            run = ''
                                dst="''${1%.*}"
                                for file in "$@"; do
                                    unzip "$file" -d "$dst/"
                                done
                            '';
                            desc = "Extract the archive to a subdirectory";
                        }
                    ];
                    "7z" = [
                        {
                            run = ''
                                7z l "$1" | ''${PAGER:-less}
                            '';
                            block = true;
                            desc = "Open the archive";
                        }
                    ];
                    "un7z-here" = [
                        {
                            run = ''
                                for file in "$@"; do
                                    7z x "$file"
                                done
                            '';
                            desc = "Extract the archive here";
                        }
                    ];
                    "un7z-subdirectory" = [
                        {
                            run = ''
                                dst="''${1%.*}"
                                mkdir "$dst"
                                for file in "$@"; do
                                    7z x "$file" -o"$dst/"
                                done
                            '';
                            desc = "Extract the archive to a subdirectory";
                        }
                    ];
                    rar = [
                        {
                            run = ''
                                unrar l "$1" | ''${PAGER:-less}
                            '';
                            block = true;
                            desc = "Open the archive";
                        }
                    ];
                    "unrar-here" = [
                        {
                            run = ''
                                for file in "$@"; do
                                    unrar x "$file"
                                done
                            '';
                            desc = "Extract the archive here";
                        }
                    ];
                    "unrar-subdirectory" = [
                        {
                            run = ''
                                dst="''${1%.*}"
                                mkdir "$dst"
                                for file in "$@"; do
                                    unrar x "$file" "$dst/"
                                done
                            '';
                            desc = "Extract the archive to a subdirectory";
                        }
                    ];
                    "gzip-decompress" = [
                        {
                            run = ''
                                gzip -dk "$@"
                            '';
                            desc = "Decompress the file";
                        }
                    ];
                    "bzip2-decompress" = [
                        {
                            run = ''
                                bzip2 -dk "$@"
                            '';
                            desc = "Decompress the file";
                        }
                    ];
                    "zstd-decompress" = [
                        {
                            run = ''
                                zstd -d "$@"
                            '';
                            desc = "Decompress the file";
                        }
                    ];
                    "lz4-decompress" = [
                        {
                            run = ''
                                lz4 -d "$@"
                            '';
                            desc = "Decompress the file";
                        }
                    ];
                    "xz-decompress" = [
                        {
                            run = ''
                                xz -dk "$@"
                            '';
                            desc = "Decompress the file";
                        }
                    ];
                    "lzma-decompress" = [
                        {
                            run = ''
                                lzma -dk "$@"
                            '';
                            desc = "Decompress the file";
                        }
                    ];
                    image = [
                        {
                            run = ''
                                imv -- "$@"
                            '';
                            orphan = true;
                            desc = "Open the image";
                        }
                    ];
                    audio = [
                        {
                            run = ''
                                mpv --force-window -- "$@"
                            '';
                            orphan = true;
                            desc = "Open the audio";
                        }
                    ];
                    video = [
                        {
                            run = ''
                                mpv -- "$@"
                            '';
                            orphan = true;
                            desc = "Open the video";
                        }
                    ];
                    pdf = [
                        {
                            run = ''
                                zathura -- "$@"
                            '';
                            orphan = true;
                            desc = "Open the document";
                        }
                    ];
                    office = [
                        {
                            run = ''
                                onlyoffice-desktopeditors "$@"
                            '';
                            orphan = true;
                            desc = "Open the office document";
                        }
                    ];
                };
                open = {
                    rules = [
                        {
                            mime = "inode/empty";
                            use = "editor";
                        }
                        {
                            mime = "text/*";
                            use = [
                                "pager"
                                "editor"
                            ];
                        }
                        {
                            mime = "application/tar";
                            name = "*.tar";
                            use = [
                                "tar"
                                "untar-here"
                                "untar-subdirectory"
                            ];
                        }
                        {
                            mime = "application/zip";
                            name = "*.zip";
                            use = [
                                "zip"
                                "unzip-here"
                                "unzip-subdirectory"
                            ];
                        }
                        {
                            mime = "application/7z*";
                            name = "*.7z";
                            use = [
                                "7z"
                                "un7z-here"
                                "un7z-subdirectory"
                            ];
                        }
                        {
                            mime = "application/rar";
                            name = "*.rar";
                            use = [
                                "rar"
                                "unrar-here"
                                "unrar-subdirectory"
                            ];
                        }
                        {
                            mime = "application/gzip";
                            name = "*.gz";
                            use = "gzip-decompress";
                        }
                        {
                            mime = "application/bzip2";
                            name = "*.bz2";
                            use = "bzip2-decompress";
                        }
                        {
                            mime = "application/zstd";
                            name = "*.zst";
                            use = "zstd-decompress";
                        }
                        {
                            mime = "application/lz4";
                            name = "*.lz4";
                            use = "lz4-decompress";
                        }
                        {
                            mime = "application/xz";
                            name = "*.xz";
                            use = "xz-decompress";
                        }
                        {
                            mime = "application/lzma";
                            name = "*.lzma";
                            use = "lzma-decompress";
                        }
                        {
                            mime = "image/*";
                            use = "image";
                        }
                        {
                            mime = "audio/*";
                            use = "audio";
                        }
                        {
                            mime = "video/*";
                            use = "video";
                        }
                        {
                            mime = "application/pdf";
                            use = "pdf";
                        }
                        {
                            mime = "application/openxmlformats-officedocument*";
                            use = "office";
                        }
                    ];
                };
            };
            keymap = {
                manager = {
                    prepend_keymap = [
                        {
                            on = "<c-m>";
                            run = "plugin mount";
                        }
                    ];
                };
            };
            initLua = ''
                local catppuccin = require("yatline-catppuccin"):setup("frappe")
                require("no-status"):setup()
                require("yatline"):setup({  
                    header_line = {
                        left = {
                            section_a = {
                                {
                                    type = "line",
                                    custom = false,
                                    name = "tabs",
                                    params = {
                                        "left"
                                    }
                                },
                            },
                            section_b = { },
                            section_c = { }
                        },
                        right = {
                            section_a = {
                                {
                                    type = "string",
                                    custom = false,
                                    name = "tab_path",
                                    params = {
                                        {
                                            trimed = true,
                                            trim_length=20
                                        }
                                    }
                                }
                            },
                            section_b = { },
                            section_c = { }
                        }
                    },
                    status_line = {
                        left = {
                            section_a = { },
                            section_b = { },
                            section_c = { }
                        },
                        right = {
                            section_a = { },
                            section_b = { },
                            section_c = { }
                        }
                    },
                    theme = catppuccin,
                    show_background = true,
                    section_separator = {
                        open = "",
                        close = ""
                    },
                    part_separator = {
                        open = "",
                        close = ""
                    },
                    inverse_separator = {
                        open = "",
                        close = ""
                    },
                })
                require("full-border"):setup {
                    type = ui.Border.ROUNDED
                }
            '';
            plugins = with pkgs.yaziPlugins; {
                yatline = yatline;
                yatline-catppuccin = yatline-catppuccin;
                "full-border" = full-border;
                "no-status" = no-status;
                mount = mount;
            }; 
        }; 
    };
}

