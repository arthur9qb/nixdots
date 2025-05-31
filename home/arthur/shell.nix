{
    pkgs,
    lib,
    ...
}: {
    programs = {
        fish = {
            enable = true;
            functions = {
                fish_user_key_bindings = ''
                    fish_vi_key_bindings default
                '';
                fish_command_not_found = ''
                    __fish_default_command_not_found_handler $argv[1]
                '';
            };
            loginShellInit = ''
                if test (tty) = "/dev/tty1"
                    if uwsm check may-start
                        exec uwsm start hyprland-uwsm.desktop
                    end
                end
            '';
            interactiveShellInit = ''
                set -U fish_greeting ""
            '';
            plugins = with pkgs; [
                {
                    name = "autopair";
                    src = fetchFromGitHub {
                        owner = "jorgebucaran";
                        repo = "autopair.fish";
                        rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
                        sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
                    };
                }
                {
                    name = "sponge";
                    src = fetchFromGitHub {
                        owner = "meaningful-ooo";
                        repo = "sponge";
                        rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
                        sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
                    };
                }
            ];
        };
        starship = {
            enable = true;
            enableTransience = true;
            settings = {
                add_newline = false;
                format = lib.concatStrings [
                    "[╭─](dimmed white) "
                    "$username"
                    "$hostname"
                    "$directory"
                    "$git_branch"
                    "$line_break"
                    "[╰─](dimmed white) "
                    "$character"
                ];
                scan_timeout = 10;
                username = {
                    disabled = false;
                    show_always = true;
                    format = "[$user]($style) ";
                    style_root = "bold red";
                    style_user = "bold green";
                };
                hostname = {
                    disabled = false;
                    ssh_only = false;
                    format = "[on](dimmed white) [$hostname]($style) ";
                    style = "bold blue";
                };
                directory = {
                    disabled = false;
                    format = "[in](dimmed white) [$path]($style) ";
                    style = "bold blue";
                    truncation_length = 3;
                    truncation_symbol = ".../";
                };
                git_branch = {
                    format = "[on](dimmed white) [$symbol $branch(:$remote_branch)]($style) ";
                    symbol = "";
                    style = "bold white";
                };
                character = {
                    disabled = false;
                    format = "$symbol ";
                    success_symbol = "[❯](bold green)";
                    error_symbol = "[❯](bold red)";
                    vimcmd_symbol = "[❮](bold blue)";
                    vimcmd_replace_one_symbol = "[❮](bold yellow)";
                    vimcmd_replace_symbol = "[❮](bold yellow)";
                    vimcmd_visual_symbol = "[❮](bold purple)";
                };
            };
        };
    };
}

