{
  lib,
  pciutils,
  platforms,
  buildNimPackage,
}:
buildNimPackage {
  pname = "pcids";
  version = "0-unstable-2023-11-14";

  src = ./.;

  postPatch = ''
    substituteInPlace src/pcids.nim \
      --replace-fail lspci "${lib.meta.getExe' pciutils "lspci"}"
  '';

  hardeningEnable = [ "pie" ];

  meta = {
    description = "Get PCI IDs for video cards";
    homepage = "https://github.com/eclairevoyant/pcids";
    #license = lib.licenses.cc-by-nc-sa-40;
    mainProgram = "pcids";
    maintainers = with lib.maintainers; [ eclairevoyant ];
    inherit platforms;
  };
}
