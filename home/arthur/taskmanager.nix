{
    pkgs,
    ...
}: {
    programs = {
        btop = {
            enable = true;
            package = pkgs.btop.override {
                cudaSupport = true;
            };
            themes = {
                catppuccin-frappe = pkgs.fetchurl {
                    url = "https://raw.githubusercontent.com/catppuccin/btop/refs/heads/main/themes/catppuccin_frappe.theme";
                    sha256 = "sha256-Fom2fBxs4vSYWgBH+tZTWs7PeHLCGWN4X6dJhooBosk=";
                };
            };
            settings = {
                color_theme = "catppuccin-frappe";
                theme_background = true;
                truecolor = true;
                force_tty = false;
                presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
                vim_keys = false;
                rounded_corners = true;
                graph_symbol = "block";
                graph_symbol_cpu = "default";
                graph_symbol_gpu = "default";
                graph_symbol_mem = "default";
                graph_symbol_net = "default";
                graph_symbol_proc = "default";
                shown_boxes = "cpu mem net proc";
                update_ms = 1000;
                proc_sorting = "cpu lazy";
                proc_reversed = false;
                proc_tree = true;
                proc_colors = true;
                proc_gradient = true;
                proc_per_core = false;
                proc_mem_bytes = true;
                proc_cpu_graphs = true;
                proc_info_smaps = false;
                proc_left = true;
                proc_filter_kernel = true;
                proc_aggregate = false;
                cpu_graph_upper = "Auto";
                cpu_graph_lower = "Auto";
                show_gpu_info = "Auto";
                cpu_invert_lower = true;
                cpu_single_graph = false;
                cpu_bottom = false;
                show_uptime = false;
                check_temp = true;
                cpu_sensor = "Auto";
                show_coretemp = true;
                cpu_core_map = "";
                temp_scale = "celsius";
                base_10_sizes = false;
                show_cpu_freq = false;
                clock_format = "";
                background_update = true;
                custom_cpu_name = "";
                disks_filter = "exclude=/boot /nix /etc /home";
                mem_graphs = true;
                mem_below_net = false;
                zfs_arc_cached = true;
                show_swap = true;
                swap_disk = true;
                show_disks = true;
                only_physical = true;
                use_fstab = true;
                zfs_hide_datasets = false;
                disk_free_priv = false;
                show_io_stat = true;
                io_mode = false;
                io_graph_combined = false;
                io_graph_speeds = "";
                net_download = 100;
                net_upload = 100;
                net_auto = true;
                net_sync = true;
                net_iface = "";
                show_battery = false;
                selected_battery = "Auto";
                show_battery_watts = true;
                log_level = "WARNING";
                nvml_measure_pcie_speeds = true;
                gpu_mirror_graph = true;
                custom_gpu_name0 = "";
                custom_gpu_name1 = "";
                custom_gpu_name2 = "";
                custom_gpu_name3 = "";
                custom_gpu_name4 = "";
                custom_gpu_name5 = "";
            };
        };
    };
}

