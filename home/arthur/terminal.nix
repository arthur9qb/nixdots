{
    ...
}: {
    programs = {
        ghostty = {
            enable = true;
            themes = {
                catppuccin-frappe = {
                    background = "303446";
                    foreground = "c6d0f5";
                    cursor-color = "f2d5cf";
                    cursor-text = "303446";
                    selection-background = "44495d";
                    selection-foreground = "c6d0f5";
                    palette = [
                        "0=#51576d"
                        "1=#e78284"
                        "2=#a6d189"
                        "3=#e5c890"
                        "4=#8caaee"
                        "5=#f4b8e4"
                        "6=#81c8be"
                        "7=#b5bfe2"
                        "8=#626880"
                        "9=#e78284"
                        "10=#a6d189"
                        "11=#e5c890"
                        "12=#8caaee"
                        "13=#f4b8e4"
                        "14=#81c8be"
                        "15=#a5adce"
                    ];
                };
            };
            clearDefaultKeybinds = true;
            settings = {
                window-padding-x = 10;
                window-padding-y = 10;
                theme = "catppuccin-frappe";
                font-family = [
                    "SeriousShanns Nerd Font Mono"
                    "Mali"
                    "Comic Jens Free Pro"
                    "HanyiSentyBubbleTea"
                    "HuiFontP"
                    "Nanum Pen"
                    "Noto Color Emoji"
                ];
                font-size = 15;
                keybind = [
                    "ctrl+t=new_tab"
                    "ctrl+backspace=previous_tab"
                    "ctrl+tab=next_tab"
                    "ctrl+w=close_tab"
                    "ctrl+right_bracket=new_split:right"
                    "ctrl+left_bracket=new_split:down"
                    "ctrl+alt+left=goto_split:left"
                    "ctrl+alt+right=goto_split:right"
                    "ctrl+alt+up=goto_split:up"
                    "ctrl+alt+down=goto_split:down"
                    "ctrl+shift+left=resize_split:left,10"
                    "ctrl+shift+right=resize_split:right,10"
                    "ctrl+shift+up=resize_split:up,10"
                    "ctrl+shift+down=resize_split:down,10"
                    "ctrl+shift+0=equalize_splits"
                    "ctrl+shift+enter=toggle_split_zoom"
                    "ctrl+page_up=scroll_page_up"
                    "ctrl+page_down=scroll_page_down"
                    "ctrl+shift+page_up=scroll_to_top"
                    "ctrl+shift+page_down=scroll_to_bottom"
                    "ctrl+shift+c=copy_to_clipboard"
                    "ctrl+shift+v=paste_from_clipboard"
                    "ctrl+equal=increase_font_size:1"
                    "ctrl+minus=decrease_font_size:1"
                    "ctrl+zero=reset_font_size"
                ];
            };
        };
    };
}

