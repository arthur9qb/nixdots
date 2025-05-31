{
    pkgs,
    ...
}: {
    programs = {
        imv = {
            enable = true;
            settings = {
                options = {
                    background = "303446";
                    overlay_background_color = "232634";
                    overlay_text_color = "c6d0f5";
                    scaling_mode = "full";
                };
            };
        };
        mpv = {
            enable = true;
            config = {
                gpu-api = "vulkan";
                hwdec = "auto-copy";
                vo = "gpu-next";
                glsl-shaders-append = [
                    "~~/shaders/SSimSuperRes.glsl"
                    "~~/shaders/SSimDownscaler.glsl"
                    "~~/shaders/KrigBilateral.glsl"
                ];
                dither-depth = "auto";
                deband = true;
                deband-iterations = 4;
                deband-threshold = 55;
                deband-range = 20;
                deband-grain = 5;
                video-sync = "display-resample";
                interpolation = true;
                tscale = "sphinx";
                tscale-blur = 0.6991556596428412;
                tscale-radius = 1.05;
                tscale-clamp = 0.0;
                tone-mapping = "bt.2446a";
                target-colorspace-hint = true;
                linear-downscaling= false;
                scale = "ewa_lanczossharp";
                dscale = "lanczos";
                cscale = "lanczos";
                volume-max = 200;
                border = false;
                background-color = "#303446";
                osc = false;
                osd-font = "SeriousShanns Nerd Font Mono";
                osd-bar = true;
                osd-level = 0;
                osd-back-color = "#232634";
                osd-border-color = "#232634";
                osd-color = "#c6d0f5";
                osd-shadow-color = "#303446";
                hr-seek-framedrop = false;
                autofit = "85%x85%";
                cursor-autohide = 1000;
            };
            defaultProfiles = [
                "gpu-hq"
            ];
            profiles = {
                "protocol.http" = {
                    hls-bitrate = "max";
                    cache = true;
                };
                "protocol.https" = {
                    profile = "protocol.http";
                };
                "protocol.ytdl" = {
                    profile = "protocol.http";
                };
            };
            scripts = with pkgs.mpvScripts; [
                autoload
                modernx
                thumbfast
                quack
                reload
            ];
        };
        obs-studio = {
            enable = true;
        };
    };
    xdg = {
        configFile = {
            "mpv/shaders/SSimSuperRes.glsl" = {
                source = pkgs.fetchurl {
                    url = "https://gist.githubusercontent.com/igv/2364ffa6e81540f29cb7ab4c9bc05b6b/raw/15d93440d0a24fc4b8770070be6a9fa2af6f200b/SSimSuperRes.glsl";
                    sha256 = "sha256-qLJxFYQMYARSUEEbN14BiAACFyWK13butRckyXgVRg8=";
                };
            };
            "mpv/shaders/SSimDownscaler.glsl" = {
                source = pkgs.fetchurl {
                    url = "https://gist.githubusercontent.com/igv/36508af3ffc84410fe39761d6969be10/raw/38992bce7f9ff844f800820df0908692b65bb74a/SSimDownscaler.glsl";
                    sha256 = "sha256-9G9HEKFi0XBYudgu2GEFiLDATXvgfO9r8qjEB3go+AQ=";
                };
            };
            "mpv/shaders/KrigBilateral.glsl" = {
                source = pkgs.fetchurl {
                    url = "https://gist.githubusercontent.com/igv/a015fc885d5c22e6891820ad89555637/raw/038064821c5f768dfc6c00261535018d5932cdd5/KrigBilateral.glsl";
                    sha256 = "sha256-ikeYq7d7g2Rvzg1xmF3f0UyYBuO+SG6Px/WlqL2UDLA=";
                };
            }; 
        };
    };
}

