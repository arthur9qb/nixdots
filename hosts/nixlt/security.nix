{
    ...
}: {
    security = {
        sudo = {
            enable = false;
        };
        doas = {
            enable = true;
            extraRules = [
                {
                    groups = [
                        "administrators"
                    ];
                }
            ];
        };
        polkit = {
            enable = true;
            adminIdentities = [
                "unix-group:administrators"
            ];
        };
    };
}

