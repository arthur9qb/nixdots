{
    pkgs,
    ...
}: {
    boot = {
        loader = {
            efi = {
                canTouchEfiVariables = true;
            };
            systemd-boot = {
                enable = true;
            };
            timeout = 0;
        };
        initrd = {
            verbose = false;
        };
        kernelParams = [
            "quiet"
            "splash"
            "rd.systemd.show_status=false"
            "rd.udev.log_level=3"
            "udev.log_priority=3"
        ];
        consoleLogLevel = 0;
        tmp = {
            cleanOnBoot = true;
        };
        plymouth = {
            enable = true;
            theme = "nixos-bgrt";
            themePackages = with pkgs; [
                nixos-bgrt-plymouth
            ];
        }; 
    };
}

