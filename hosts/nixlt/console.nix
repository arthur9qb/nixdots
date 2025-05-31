{
    pkgs,
    ...
}: {
    services = {
        getty = {
            greetingLine = "\\n (\\l)";
            extraArgs = [
                "--nohostname"
            ];
        };
    };
    console = {
        enable = true;
        keyMap = "us";
        font = "ter-120n";
        packages = with pkgs; [
            terminus_font
        ];
    };
}
