{
    pkgs,
    ...
}: {
    hardware = {
        brillo = {
            enable = true;
        };
    };
    services = {
        upower = {
            enable = true;
        };
        power-profiles-daemon = {
            enable = true;
        };
        udisks2 = {
            enable = true;
        };
        transmission = {
            enable = true;
            package = pkgs.transmission_4;
            openPeerPorts = true;
        };
    };
}
