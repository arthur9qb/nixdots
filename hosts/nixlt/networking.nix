{
    ...
}: {
    networking = {
        hostName = "nixlt";
        nameservers = [
            "127.0.0.1"
            "::1"
        ];
        networkmanager = {
            enable = true;
            dns = "none";
        };
        firewall = {
            enable = true;
        };
        nftables = {
            enable = true;
        };
        dhcpcd = {
            enable = false;
        };
    }; 
    services = {
        dnscrypt-proxy2 = {
            enable = true;
            settings = {
                ipv4_servers = true;
                doh_servers = true;
                require_dnssec = true;
                require_nolog = true;
                sources = {
                    public-resolvers = {
                        urls = [
                            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
                            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
                        ];
                        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
                        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
                    };
                };
                server_names = [
                    "quad9-doh-ip4-port443-filter-pri"
                    "mullvad-base-doh"
                ];
            };
        };
    }; 
}
