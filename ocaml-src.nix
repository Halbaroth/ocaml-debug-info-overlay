{ stdenv, ocaml }:

stdenv.mkDerivation {
  name = "ocaml-src";
  inherit (ocaml) src version patches;

  phases = [
    "unpackPhase"
    "patchPhase"
    "installPhase"
  ];

  installPhase = ''
    cp -r . $out
  '';
}
