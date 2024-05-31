import std/[osproc,parseutils,strformat,strscans,strutils]

when isMainModule:
  # class 03xx refers to video cards
  let devices = execCmdEx("lspci -Dnnmmd '*:*:03xx'").output
  for line in devices.split('\n'):
    var domainid, busid, deviceid, functionid, classid: int
    var class, vendor, device: string
    if line.scanf("$h:$h:$h.$h \"$+\" \"$+\" \"$+\"", domainid, busid, deviceid, functionid, class, vendor, device):
      if (domainid == 0):
        echo &"PCI:{busid}:{deviceid}:{functionid}\n\t{vendor}\n\t{device}"
      else:
        echo &"PCI:{busid}@{domainid}:{deviceid}:{functionid}\n\t{vendor}\n\t{device}"
