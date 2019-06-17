#!/bin/bash -ex
# -e: Exit immediately if a command exits with a non-zero status.
# -x: Display expanded script commands

HERE="$(dirname "$0")"
. "$HERE/commit.sh"

if [ -n "${VERSIONED+x}" ]
then
	sed -i -e "s/\"cur\"/\"${SHORT_ID}\"/;" sys/buildinfo/version.h
fi
gcc -I"sys" -o /tmp/version .travis/version.c

. "$HERE/kernel_targets.sh"
. "$HERE/xaaes_targets.sh"
. "$HERE/netusbee_targets.sh"

if [ "$CPU_TARGET" = "prg" ]
then
	PRG_TARGET="$CPU_TARGET"
	USB_TOOL_TARGET="000"
	CPU_TARGET=""
elif [ "$CPU_TARGET" = "ara" ]
then
	CPU_TARGET="040"
fi

if [ -n "$CPU_TARGET" ]
then
	COPS_TARGETS="english_${CPU_TARGET} france_${CPU_TARGET} german_${CPU_TARGET}"
fi

# limit building to selected CPU targets
sed -i -e "s/xaloadtargets = 000 02060 030 040 060 col/xaloadtargets = ${CPU_TARGET}/;" ./xaaes/src.km/xaloader/XALOADDEFS
sed -i -e "s/xaaestargets = deb 000 sto 030 040 060 col 02060/xaaestargets = ${XAAES_TARGETS}/;" ./xaaes/src.km/XAAESDEFS
sed -i -e "s/moosetargets = 02060 030 040 060 deb 000 col/moosetargets = ${CPU_TARGET}/;" ./xaaes/src.km/adi/whlmoose/MOOSEDEFS
sed -i -e "s/kerneltargets = 000 020 030 040 060 deb mil ara hat col/kerneltargets = ${KERNEL_TARGETS}/;" ./sys/KERNELDEFS
sed -i -e "s/ext2targets = 02060 030 040 060 deb 000 col/ext2targets = ${CPU_TARGET}/;" ./sys/xfs/ext2fs/EXT2DEFS
sed -i -e "s/nfstargets = 02060 030 040 060 deb 000 col/nfstargets = ${CPU_TARGET}/;" ./sys/xfs/nfs/NFSDEFS
sed -i -e "s/minixtargets = 02060 030 040 060 deb 000 col/minixtargets = ${CPU_TARGET}/;" ./sys/xfs/minixfs/MINIXDEFS
sed -i -e "s/xconout2targets = 02060 030 040 060 deb 000 col/xconout2targets = ${CPU_TARGET}/;" ./sys/xdd/xconout2/XCONOUT2DEFS
sed -i -e "s/lptargets = 02060 030 040 060 deb 000 col/lptargets = ${CPU_TARGET}/;" ./sys/xdd/lp/LPDEFS
sed -i -e "s/usbloadtargets = 000 02060 030 040 060 col/usbloadtargets = ${CPU_TARGET}/;" ./sys/usb/src.km/loader/USBLOADDEFS
sed -i -e "s/ethtargets = 02060 030 040 060 deb 000 col prg/ethtargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/udd/eth/ETHDEFS
sed -i -e "s/keyboardtargets = 02060 030 040 060 deb 000 col prg/keyboardtargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/udd/hid/keyboard/KEYBOARDDEFS
sed -i -e "s/mousetargets = 02060 030 040 060 deb 000 col prg/mousetargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/udd/hid/mouse/MOUSEDEFS
sed -i -e "s/printertargets = 02060 030 040 060 deb 000 col prg/printertargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/udd/printer/PRINTERDEFS
sed -i -e "s/storagetargets = 02060 030 040 060 deb 000 col prg/storagetargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/udd/storage/STORAGEDEFS
sed -i -e "s/usbtargets = 02060 030 040 060 deb 000 col prg/usbtargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/USBDEFS
sed -i -e "s/ehcitargets = 02060 030 040 060 deb 000 col #prg/ehcitargets = ${CPU_TARGET}/;" ./sys/usb/src.km/ucd/ehci/EHCIDEFS
sed -i -e "s/netusbeetargets = 02060 030 040 060 deb 000 prg prg_000 #col/netusbeetargets = ${NETUSBEE_TARGETS}/;" ./sys/usb/src.km/ucd/netusbee/NETUSBEEDEFS
sed -i -e "s/unicorntargets = 02060 030 040 060 deb 000 col prg/unicorntargets = ${CPU_TARGET}${PRG_TARGET}/;" ./sys/usb/src.km/ucd/unicorn/UNICORNDEFS
sed -i -e "s/inet4targets = 02060 030 040 060 deb 000 col/inet4targets = ${CPU_TARGET}/;" ./sys/sockets/INET4DEFS
sed -i -e "s/inet4targets = 02060 030 040 060 deb 000 col/inet4targets = ${CPU_TARGET}/;" ./sys/sockets/inet4/INET4DEFS
sed -i -e "s/copstargets = english_000 france_000 german_000 english_02060 france_02060 german_02060 english_030 france_030 german_030 english_040 france_040 german_040 english_060 france_060 german_060 english_col france_col german_col/copstargets = ${COPS_TARGETS}/;" ./tools/cops/COPSDEFS
sed -i -e "s/cryptotargets = 000 02060 030 040 060 col/cryptotargets = ${CPU_TARGET}/;" ./tools/crypto/CRYPTODEFS
sed -i -e "s/fdisktargets = 000 02060 030 040 060 col/fdisktargets = ${CPU_TARGET}/;" ./tools/fdisk/FDISKDEFS
sed -i -e "s/fsettertargets = 000 02060 030 040 060 col/fsettertargets = ${CPU_TARGET}/;" ./tools/fsetter/FSETTERDEFS
sed -i -e "s/gluestiktargets = 000 02060 030 040 060 col/gluestiktargets = ${CPU_TARGET}/;" ./tools/gluestik/GLUESTIKDEFS
sed -i -e "s/hypviewtargets = 000 02060 030 040 060 col/hypviewtargets = ${CPU_TARGET}/;" ./tools/hypview/HYPVIEWDEFS
sed -i -e "s/bubbletargets = 000 02060 030 040 060 col/bubbletargets = ${CPU_TARGET}/;" ./tools/hypview/bubble/BUBBLEDEFS
sed -i -e "s/dragdroptargets = 000 02060 030 040 060 col/dragdroptargets = ${CPU_TARGET}/;" ./tools/hypview/dragdrop/DRAGDROPDEFS
sed -i -e "s/hyptargets = 000 02060 030 040 060 col/hyptargets = ${CPU_TARGET}/;" ./tools/hypview/hyp/HYPDEFS
sed -i -e "s/plaintargets = 000 02060 030 040 060 col/plaintargets = ${CPU_TARGET}/;" ./tools/hypview/plain/PLAINDEFS
sed -i -e "s/iotargets = 000 02060 030 040 060 col/iotargets = ${CPU_TARGET}/;" ./tools/IO/IODEFS
sed -i -e "s/lpflushtargets = 000 02060 030 040 060 col/lpflushtargets = ${CPU_TARGET}/;" ./tools/lpflush/LPFLUSHDEFS
sed -i -e "s/mgwtargets = 000 02060 030 040 060 col/mgwtargets = ${CPU_TARGET}/;" ./tools/mgw/MGWDEFS
sed -i -e "s/fscktargets = 000 02060 030 040 060 col/fscktargets = ${CPU_TARGET}/;" ./tools/minix/fsck/FSCKDEFS
sed -i -e "s/minittargets = 000 02060 030 040 060 col/minittargets = ${CPU_TARGET}/;" ./tools/minix/minit/MINITDEFS
sed -i -e "s/toolstargets = 000 02060 030 040 060 col/toolstargets = ${CPU_TARGET}/;" ./tools/minix/tools/TOOLSDEFS
sed -i -e "s/mintloadtargets = 000 02060 030 040 060 col/mintloadtargets = ${CPU_TARGET}/;" ./tools/mintload/MINTLOADDEFS
sed -i -e "s/mkfatfstargets = 000 02060 030 040 060 col/mkfatfstargets = ${CPU_TARGET}/;" ./tools/mkfatfs/MKFATFSDEFS
sed -i -e "s/mktbltargets = 000 02060 030 040 060 col/mktbltargets = ${CPU_TARGET}/;" ./tools/mktbl/MKTBLDEFS
sed -i -e "s/nettoolstargets = 000 02060 030 040 060 col/nettoolstargets = ${CPU_TARGET}/;" ./tools/net-tools/NETTOOLSDEFS
sed -i -e "s/slinkctltargets = 000 02060 030 040 060 col/slinkctltargets = ${CPU_TARGET}/;" ./tools/net-tools/slinkctl/SLINKCTLDEFS
sed -i -e "s/teststargets = 000 02060 030 040 060 col/teststargets = ${CPU_TARGET}/;" ./tools/net-tools/tests/TESTSDEFS
sed -i -e "s/nfstargets = 000 02060 030 040 060 col/nfstargets = ${CPU_TARGET}/;" ./tools/nfs/NFSDEFS
sed -i -e "s/nohog2targets = 000 02060 030 040 060 col/nohog2targets = ${CPU_TARGET}/;" ./tools/nohog2/NOHOG2DEFS
sed -i -e "s/stracetargets = 000 02060 030 040 060 col/stracetargets = ${CPU_TARGET}/;" ./tools/strace/STRACEDEFS
sed -i -e "s/swkbdtbltargets = 000 02060 030 040 060 col/swkbdtbltargets = ${CPU_TARGET}/;" ./tools/swkbdtbl/SWKBDTBLDEFS
sed -i -e "s/sysctltargets = 000 02060 030 040 060 col/sysctltargets = ${CPU_TARGET}/;" ./tools/sysctl/SYSCTLDEFS
sed -i -e "s/toswin2targets = 000 02060 030 040 060 col/toswin2targets = ${CPU_TARGET}/;" ./tools/toswin2/TOSWIN2DEFS
sed -i -e "s/twcalltargets = 000 02060 030 040 060 col/twcalltargets = ${CPU_TARGET}/;" ./tools/toswin2/tw-call/TWCALLDEFS
sed -i -e "s/usbtooltargets = 000 02060 030 040 060 col/usbtooltargets = ${CPU_TARGET}${USB_TOOL_TARGET}/;" ./tools/usbtool/USBTOOLDEFS
