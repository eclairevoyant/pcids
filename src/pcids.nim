import std/[osproc,parseutils,strformat,strscans,strutils]

when isMainModule:
  # class 03xx refers to video cards
  let devices = execCmdEx("lspci -nnmm -d '*:*:03xx'").output
  for line in devices.split('\n'):
    var busid1, busid2, busid3, classid: int
    var class, vendor, device: string
    if line.scanf("$h:$h.$h \"$+\" \"$+\" \"$+\"", busid1, busid2, busid3, class, vendor, device):
      echo &"PCI:{busid1}:{busid2}:{busid3}\t{vendor}\t{device}"
