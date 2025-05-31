{
    ...
}: {
    disko = {
        devices = {
            disk = {
                nvme = {
                    type = "disk";
                    device = "/dev/nvme0n1";
                    content = {
                        type = "gpt";
                        partitions = {
                            ESP = {
                                size = "500M";
                                type = "EF00";
                                content = {
                                    type = "filesystem";
                                    format = "vfat";
                                    mountpoint = "/boot";
                                    mountOptions = [
                                        "umask=0077"
                                    ];
                                };
                            };
                            root = {
                                size = "100%";
                                content = {
                                    type = "btrfs";
                                    subvolumes = {
                                        "@" = {
                                            mountpoint = "/";
                                            mountOptions = [
                                                "ssd"
                                                "discard=async"
                                                "noatime"
                                                "space_cache=v2"
                                            ];
                                        };
                                        "@nix" = { 
                                            mountpoint = "/nix";
                                            mountOptions = [
                                                "noatime"
                                                "space_cache=v2"
                                                "autodefrag"
                                                "compress=zstd:1"
                                            ];
                                        };
                                        "@etc" = { 
                                            mountpoint = "/etc";
                                            mountOptions = [
                                                "noatime"
                                                "space_cache=v2"
                                                "compress=zstd:1"
                                            ];
                                        };
                                        "@home" = {
                                            mountpoint = "/home";
                                            mountOptions = [
                                                "noatime"
                                                "space_cache=v2"
                                                "autodefrag"
                                                "compress=zstd:1"
                                            ];
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };
    zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 20;
    };
    boot = {
        supportedFilesystems = [
            "btrfs"
        ];
        tmp = {
            useTmpfs = true;
            tmpfsSize = "10%";
        };
    };
    services = {
        btrfs = {
            autoScrub = {
                enable = true;
                interval = "weekly";
                fileSystems = [
                    "/"
                ];
            };
        };
    };
}
