{
    pkgs,
    ...
}: {
    virtualisation = {
        libvirtd = {
            enable = true;
            qemu = {
                ovmf = {
                    enable = true;
                    packages = with pkgs; [
                        OVMFFull.fd
                    ];
                };
                swtpm = {
                    enable = true;
                };
            };
        };
        spiceUSBRedirection = {
            enable = true;
        };
    };
    services = {
        spice-vdagentd = {
            enable = true;
        };
    };
    programs = {
        virt-manager = {
            enable = true;
        };
    }; 
}
