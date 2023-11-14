import std/[osproc,parseutils,strformat,strscans,strutils]

when isMainModule:
  let devices = execCmdEx("lspci -nnmm").output
  for line in devices.split('\n'):
    var busid1, busid2, busid3, classid: int
    var class, vendor, device: string
    if line.scanf("$h:$h.$h \"$+\" \"$+\" \"$+\"", busid1, busid2, busid3, class, vendor, device):
      if (class.substr(class.len - 5, class.len - 2).parseHex(classid) > 0):
        if (classid div 256 == 3):
          echo &"PCI:{busid1}:{busid2}:{busid3}\t{vendor}\t{device}"
