{
  description = "LaTeX flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    alias = pkgs.writeShellScriptBin;
  in {
    devShells.${system}.default = pkgs.mkShell rec {
      nativeBuildInputs = [
        (alias "compile" "biber main && xelatex -shell-escape main.tex")
        (alias "first-compile" ''
          xelatex -shell-escape main.tex \
            && biber main \
            && xelatex -shell-escape main.tex \
            && xelatex -shell-escape main.tex
        '')
      ];

      buildInputs = with pkgs; [
        texliveFull
        texlivePackages.latexindent
        python3
        python312Packages.pygments
      ];
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
    };
  };
}
