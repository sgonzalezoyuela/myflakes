{
  description = "Script utils flake!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        buildScript = my-name: my-src: (pkgs.writeScriptBin my-name (builtins.readFile my-src)).overrideAttrs (old: {
          buildCommand = "${old.buildCommand}\n patchShebangs $out";
        });

        pkgs = import nixpkgs { inherit system; };

        scripts = [
          rec {
            my-name = "find-in-jar";
            my-src = ./scripts/find-in-jar.sh;
            my-script = buildScript my-name my-src;
            my-buildInputs = with pkgs; [ openjdk8_headless ];
          }

          rec {
            my-name = "t";
            my-src = ./scripts/t.sh;
            my-script = buildScript my-name my-src;
            my-buildInputs = with pkgs; [ tldr less tmux ];
          }

          rec {
            my-name = "ch";
            my-src = ./scripts/ch.sh;
            my-script = buildScript my-name my-src;
            my-buildInputs = with pkgs; [ curl less tmux ];
          }

          rec {
            my-name = "xclipf";
            my-src = ./scripts/xclipf.sh;
            my-script = buildScript my-name my-src;
            my-buildInputs = with pkgs; [ coreutils xclip ];
          }

          rec {
            my-name = "vf";
            my-src = ./scripts/vf.sh;
            my-script = buildScript my-name my-src;
            my-buildInputs = with pkgs; [ fzf ];
          }

          rec {
            my-name = "catf";
            my-src = ./scripts/catf.sh;
            my-script = buildScript my-name my-src;
            my-buildInputs = with pkgs; [ fzf ];
          }

        ];

        myPackages = builtins.listToAttrs (map
          (script: {
            name = script.my-name;
            value = pkgs.symlinkJoin {
              name = script.my-name;
              paths = [
                script.my-script
              ] ++ script.my-buildInputs;
              buildInputs = [ pkgs.makeWrapper ];
              postBuild = "wrapProgram $out/bin/${script.my-name} --prefix PATH : $out/bin";
            };
          })
          scripts);

      in
      {
        defaultPackage = myPackages."find-in-jar"; # You can change this to another default package
        packages = myPackages;
      }
    );
}
