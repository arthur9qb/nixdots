{
    pkgs,
    ...
}: {
    hardware = {
        enableRedistributableFirmware = true;
        cpu = {
            amd = {
                updateMicrocode = true;
            };
        };
        amdgpu = {
            initrd = {
                enable = true;
            };
        };
        graphics = {
            enable = true;
            enable32Bit = true;
        };
        nvidia = {
            open = false;
            modesetting = {
                enable = true;
            };
            nvidiaSettings = false;
            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
                amdgpuBusId = "PCI:5:0:0";
                nvidiaBusId = "PCI:1:0:0";
            };
        };
    };
    boot = {
        kernelPackages = pkgs.linuxPackages;
        initrd = {
            availableKernelModules = [
                "nvme"
                "xhci_pci"
                "usbhid"
                "usb_storage"
            ];
        };
        kernelModules = [
            "kvm-amd"
        ];
        kernelParams = [
            "amd_pstate=active"
        ];
    };
    services = {
        xserver = {
            videoDrivers = [
                "amdgpu"
                "nvidia"
            ];
        };
    };
}

