{
  description = "nokazn/nokazn";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs =
    { nixpkgs
    , flake-utils
    , ...
    }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        shellHook = ''
          pnpm install
        '';

        packages = with pkgs; [
          nodejs
          nodePackages.pnpm
          esbuild
          biome
          nixpkgs-fmt
          dprint
          yamlfmt
          shfmt
          treefmt
        ];
      };
    });
}
