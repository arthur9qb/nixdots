{
    ...
}: {
    programs = {
        lsd = {
            enable = true;
            colors = {
                user = "#ca9ee6";
                group = "#babbf1";
                permission = {
                    read = "#a6d189";
                    write = "#e5c890";
                    exec = "#ea999c";
                    exec-sticky = "#ca9ee6";
                    no-access = "#a5adce";
                    octal = "#81c8be";
                    acl = "#81c8be";
                    context = "#99d1db";
                };
                date = {
                    hour-old = "#81c8be";
                    day-old = "#99d1db";
                    older = "#85c1dc";
                };
                size = {
                    none = "#a5adce";
                    small = "#a6d189";
                    medium = "#e5c890";
                    large = "#ef9f76";
                };
                inode = {
                    valid = "#f4b8e4";
                    invalid = "#a5adce";
                };
                links = {
                    valid = "#f4b8e4";
                    invalid = "#a5adce";
                };
                tree-edge = "#b5bfe2";
                git-status = {
                    default = "#c6d0f5";
                    unmodified = "#a5adce";
                    ignored = "#a5adce";
                    new-in-index = "#a6d189";
                    new-in-workdir = "#a6d189";
                    typechange = "#e5c890";
                    deleted = "#e78284";
                    renamed = "#a6d189";
                    modified = "#e5c890";
                    conflicted = "#e78284";
                };
            };
            settings = {
                date = "+%a, %d %b %y %-I:%M %p";
            };
        };
        fd = {
            enable = true;
        };
        ripgrep = {
            enable = true;
        };
        fzf = {
            enable = true;
            defaultOptions = [
                "--border"
            ];
            colors = {
                bg = "#303446";
                "bg+" = "#414559";
                "selected-bg" = "#51576d";
                fg = "#c6d0f5";
                "fg+" = "#c6d0f5";
                border = "#414559";
                hl = "#e78284";
                "hl+" = "#e78284";
                header = "#e78284";
                prompt = "#ca9ee6";
                marker = "#babbf1";
                pointer = "#f2d5cf";
                spinner = "#f2d5cf";
                label = "#c6d0f5";
                info = "#ca9ee6";
            };
        };
    };
}
