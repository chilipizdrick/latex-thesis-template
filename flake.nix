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
        (alias "compile" "latexmk -pvc -pdf -e '$pdflatex=q/xelatex -shell-escape %O %S/' main.tex")
      ];

      buildInputs = with pkgs; [
        texliveFull
        python3
        python312Packages.pygments
      ];
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
    };
  };
}
