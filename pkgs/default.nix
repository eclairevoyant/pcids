{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];

  perSystem = {
    final,
    lib,
    pkgs,
    self',
    system,
    ...
  }: let
    packages = {
      pcids = final.callPackage ./package.nix {};
    };
  in {
    devShells.default = final.mkShell {
      packages = [final.pciutils];
    };

    overlayAttrs = packages;

    packages = packages // {default = packages.pcids;};
  };
}
