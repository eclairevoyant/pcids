{
  self,
  lib,
  pciutils,
  buildNimPackage,
}:
buildNimPackage {
  pname = "pcids";
  version = "0.1.1";

  src = self;

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
  };
}
