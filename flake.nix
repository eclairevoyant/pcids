{
  description = "Get PCI IDs for video cards";
  inputs.nixpkgs.url = "flake:nixpkgs";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nimPackages.c2nim
        nimPackages.nim
        nimPackages.nimble
        pciutils
      ];
    };
    formatter.${system} = pkgs.alejandra;
    packages.${system}.default = pkgs.callPackage ./. {};
  };
}
