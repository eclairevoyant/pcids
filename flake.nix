{
  description = "Get PCI IDs for video cards";
  inputs.nixpkgs.url = "flake:nixpkgs";

  outputs = {nixpkgs, ...}: let
    platforms = [
      "x86_64-linux"
    ];
    forSystems = f: nixpkgs.lib.attrsets.genAttrs platforms (system: f nixpkgs.legacyPackages.${system});
  in {
    formatter = forSystems (pkgs: pkgs.alejandra);
    packages = forSystems (pkgs: {
      default = pkgs.callPackage ./package.nix {inherit platforms;};
    });
  };
}
