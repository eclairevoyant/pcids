{ inputs, self, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem =
    {
      final,
      lib,
      pkgs,
      self',
      system,
      ...
    }:
    {
      devShells.default = final.mkShell { packages = [ final.pciutils ]; };

      overlayAttrs = {
        pcids = final.callPackage ./package.nix { inherit self; };
      };

      packages = {
        inherit (final) pcids;
        default = final.pcids;
      };
    };
}
