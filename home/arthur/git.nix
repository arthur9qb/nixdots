{
    ...
}: {
    programs = {
        git = {
            enable = true;
            userName = "arthur9qb";
            userEmail = "arthur9qb@gmail.com";
            extraConfig = {
                push = {
                    autoSetupRemote = true;
                };
            };
        };
        lazygit = {
            enable = true;
            settings = {
                gui = {
                    theme = {
                        activeBorderColor = [
                            "blue"
                            "bold"
                        ];
                        inactiveBorderColor = [
                            "black"
                        ];
                        selectedLineBgColor = [
                            "black"
                        ];
                    };
                };
            };
        };
    };
}

