pkgs: with pkgs; {
    nixos = {
        mkModulesFromDirectory = { directory, exclude ? [] }: builtins.attrValues (builtins.mapAttrs (name: type: directory + "/${name}")
            (lib.filterAttrs (name: type:
                type == "regular" &&
                lib.hasSuffix ".nix" name &&
                !(lib.elem name exclude)
            ) (builtins.readDir directory))
        );
    };
    neovim = {
        mkPluginFromGitHub = { owner, repo, rev, sha256 }: vimUtils.buildVimPlugin {
            name = "${lib.strings.sanitizeDerivationName repo}";
            src = fetchFromGitHub {
                inherit owner repo rev sha256;
            };
            doCheck = false;
        };
        mkPluginFromLuaPackage = { package }: vimUtils.buildVimPlugin {
            inherit (luaPackages.${package}) name src;
            doCheck = false;
        };
        mkLuaConfig = configs: builtins.map (config:
            config // {
                type = "lua";
            }
        ) configs;
    };
    hyprland = {
        mkBind = binds: builtins.concatMap (bind: let
            modifier = "${bind.modifier}, ";
            command = bind.command;
            isExecute = bind ? execute && bind.execute;
            execute = lib.optionalString isExecute "exec, ";
        in
            builtins.map (entry: let
                key = "${entry.key}, ";
                hasArgument = entry ? argument && entry.argument != "";
                argument = lib.optionalString hasArgument ", ${entry.argument}";
            in
                "${modifier}${key}${execute}${command}${argument}"
            ) bind.trigger
        ) binds;
    };
    xdg = {
        mkDefaultApplication = applications: builtins.foldl' (accumulator: application: accumulator // builtins.listToAttrs (builtins.map (mime: {
            name = mime;
            value = [ application.name ];
        }) application.mimes)) {} applications;
    };
}
