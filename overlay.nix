self: super:
let
  mkOverride =
    ocamlPackages:
    let
      ocaml-src = super.callPackage ./ocaml-src.nix { ocaml = ocamlPackages.ocaml; };
    in
    ocamlPackages.overrideScope (
      final: prev: {
        ocaml = prev.ocaml.overrideAttrs (old: {
          dontStrip = true;
          separateDebugInfo = true;
          dontCheckForBrokenSymlinks = true;

          configureFlags = (old.configureFlags or [ ]) ++ [
            "CFLAGS=-fdebug-prefix-map=/build/ocaml-${prev.ocaml.version}=${ocaml-src}"
          ];
        });
      }
    );
in
{
  ocamlPackages = mkOverride super.ocamlPackages;

  ocaml-ng = super.ocaml-ng // {
    ocamlPackages_4_9 = mkOverride super.ocaml-ng.ocamlPackages_4_9;
    ocamlPackages_4_10 = mkOverride super.ocaml-ng.ocamlPackages_4_10;
    ocamlPackages_4_11 = mkOverride super.ocaml-ng.ocamlPackages_4_11;
    ocamlPackages_4_12 = mkOverride super.ocaml-ng.ocamlPackages_4_12;
    ocamlPackages_4_13 = mkOverride super.ocaml-ng.ocamlPackages_4_13;
    ocamlPackages_4_14 = mkOverride super.ocaml-ng.ocamlPackages_4_14;
    ocamlPackages_5_0 = mkOverride super.ocaml-ng.ocamlPackages_5_0;
    ocamlPackages_5_1 = mkOverride super.ocaml-ng.ocamlPackages_5_1;
    ocamlPackages_5_2 = mkOverride super.ocaml-ng.ocamlPackages_5_2;
    ocamlPackages_5_3 = mkOverride super.ocaml-ng.ocamlPackages_5_3;
    ocamlPackages_5_4 = mkOverride super.ocaml-ng.ocamlPackages_5_4;
  };
}
