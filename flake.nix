{
  description = "Flake overlay to keep debug info in OCaml programs";

  outputs =
    { ... }:
    {
      overlays.default = import ./overlay.nix;

      templates.default = {
        path = ./template;
        description = "A basic flake using ocaml-debug-info-overlay";
      };
    };
}
