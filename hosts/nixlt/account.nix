{
    pkgs,
    ...
}: {
    users = {
        groups = {
            users = {};
            administrators = {};
        };
        users = {
            root = {
                hashedPassword = "$6$YVEwgFcovmHg88J7$uYhMSDNui1R6r1vk.Dx8QW3pu668wpsjui/nw7vq6GvfqaIhw5yyYoOQIh/aIvmSe8vp9ngDTOQlWfZnTdcgG1";
                shell = pkgs.shadow;
            };
            arthur = {
                isNormalUser = true;
                group = "administrators";
                hashedPassword = "$6$EycJs.ymYlZ.E30t$GhW8cV5WQ6nrcWEoQ611ujtTEgLP0wiAU620q7ObIDrXGj7y29PJiJoohRpJiBbyU6kk/9dYD30kb2wbcLulp1";
                extraGroups = [
                    "networkmanager"
                    "video"
                    "audio"
                    "libvirtd"
                    "transmission"
                ];
                shell = pkgs.fish;
            };
        };
        mutableUsers = false;
    };
}

