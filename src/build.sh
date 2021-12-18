#!/usr/bin/env bash

#make bin/undionly.kpxe DEBUG=multiboot:2,image:2,multibootv2:2 EMBED=myscript.ipxe
#make bin/ipxe.hd DEBUG=multiboot:2,image:2,multibootv2:2 EMBED=myscript.ipxe
#make bin/ipxe.raw DEBUG=multiboot:2,image:2,multibootv2:2 EMBED=myscript.ipxe
#make bin/ipxe.pxe DEBUG=multiboot:2,image:3,multibootv2:2 EMBED=myscript.ipxe

find "." -iname "*.c" | entr -r -n sh -c "
    make bin/ipxe.dsk DEBUG=multiboot:3,image:3,multibootv2:3 EMBED=myscript.ipxe
"