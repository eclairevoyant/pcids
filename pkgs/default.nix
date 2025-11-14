{ inputs, self, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem =
    {
      final,
      lib,
      self',
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowlistedLicenses = with lib.licenses; [ cc-by-nc-sa-40 ];
      };

      devShells.default = final.mkShell {
        inputsFrom = [ self'.packages.default ];
        packages = [ final.nimble ];
      };

      overlayAttrs = {
        pcids = final.callPackage ./package.nix { inherit self; };
      };

      packages = {
        inherit (final) pcids;
        default = final.pcids;
      };
    };
}
