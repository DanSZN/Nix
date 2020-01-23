{ config, pkgs, ... }:
let home = builtins.getEnv "HOME";
in rec {
    nixpkgs = {
        config = {
            allowUnfree = true;
            allowBroken = false;
            allowUnsupportedSystem = false;
        };
    };

    home = {
        packages = with pkgs; [
            coreutils
            gotop
            discord-ptb
            neofetch
            speedtest-cli
            nitrogen
        ];
    };
    
    programs = {
        home-manager = {
            enable = true;
        };

        rofi = {
            enable = true;
            theme = "~/.cache/wal/colors-rofi-dark.rasi";
        };

        zsh = rec {
            enable = true;

            initExtra = ''
                eval "$(starship init zsh)"
            '';

            shellAliases = {
                sysrebuild  = "sudo ${pkgs.system}/bin/nixos-rebuild";
                homerebuild = "${pkgs.home-manager}/bin/home-manager switch";
                
                edithome = "${pkgs.neovim}/bin/nvim ~/.config/nixpkgs/home.nix";
                editsys  = "sudo ${pkgs.neovim}/bin/nvim /etc/nixos/configuration.nix";

                cargob = "${pkgs.nix}/bin/nix-shell --command 'cargo build'";
                cargor = "${pkgs.nix}/bin/nix-shell --command 'cargo run'";
                cargow = "${pkgs.nix}/bin/nix-shell --command 'cargo watch'";
            };
        };

        command-not-found = {
            enable = true;
        };

        vscode = {
            enable = true;

               userSettings = {
                   "window.menuBarVisibility" = "toggle";
                   "workbench.colorTheme" = "Wal";
                   "editor.fontFamily" = "Hack";
                   "editor.fontLigatures" = true;
                   "editor.fontSize" = 16;
                   "rust-client.rlsPath" = "${pkgs.rls}/bin/rls";
               };

               extensions = with pkgs.vscode-extensions; [
                   vscodevim.vim
                   bbenoist.Nix
               ];

           };
    };
}
