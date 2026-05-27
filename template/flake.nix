{
  description = "Basic template for ocaml-debug-info-overlay";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ocaml-debug-info-overlay.url = "github:Halbaroth/ocaml-debug-info-overlay";
  };

  outputs =
    { self, ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem =
        { system, pkgs, ... }:
        {
          _module.args.pkgs = import self.inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.ocaml-debug-info-overlay.overlays.default ];
          };

          devShells = pkgs.mkShell {
            packages = with ocamlPackages; [
              ocaml
            ];
          };
        };
    };
}
