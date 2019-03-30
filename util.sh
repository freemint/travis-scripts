# use as: . util.sh

copy_auto() {
	local AUTODIR="$1"
	local TARGET="$2"
	local CUR="$3"
	mkdir -p "$AUTODIR"
	cp "$SRC/tools/mintload/.compile_$TARGET/mintload.prg" "$AUTODIR/mint-$CUR.prg"
}

copy_kernel() {
	local MINTDIR="$1"
	mkdir -p "$MINTDIR"
	shift
	for TARGET in $*
	do
		cp "$SRC/sys/.compile_$TARGET"/mint*.prg "$MINTDIR"
	done
}

copy_kernel_docs() {
	local MINTDIR="$1"
	local BOOTABLE="$2"
	mkdir -p "$MINTDIR"
	if [ "$BOOTABLE" = "yes" ]
	then
	cp "$SRC/doc/examples/mint.cnf" "$MINTDIR"/mint.cnf
	sed -e "s/#sln e:\/bin      u:\/bin/sln c:\/mint\/$VER\/sysroot\/bin      u:\/bin/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#sln e:\/etc      u:\/etc/sln c:\/mint\/$VER\/sysroot\/etc      u:\/etc/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#sln e:\/root     u:\/root/sln c:\/mint\/$VER\/sysroot\/root     u:\/root/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#sln e:\/tmp      u:\/tmp/sln c:\/mint\/$VER\/sysroot\/tmp      u:\/tmp/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#sln e:\/var      u:\/var/sln c:\/mint\/$VER\/sysroot\/var      u:\/var/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#setenv LOGNAME root/setenv LOGNAME root/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#setenv USER    root/setenv USER    root/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#setenv HOME    \/root/setenv HOME    \/root/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#setenv SHELL   \/bin\/bash/setenv SHELL   \/bin\/bash/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	sed -e "s/#GEM=u:\/c\/mint\/xaaes\/xaloader.prg/GEM=u:\/c\/mint\/$VER\/xaaes\/xaloader.prg/;" "$MINTDIR/mint.cnf" > "$MINTDIR/mint.cnf.tmp" && mv "$MINTDIR/mint.cnf.tmp" "$MINTDIR/mint.cnf"
	fi
	mkdir -p "$MINTDIR/doc"
	cp "$SRC/COPYING" "$MINTDIR/doc"
	cp "$SRC/COPYING.GPL" "$MINTDIR/doc"
	cp "$SRC/COPYING.LGPL" "$MINTDIR/doc"
	cp "$SRC/COPYING.MiNT" "$MINTDIR/doc"
}

copy_modules() {
	local MINTDIR="$1"
	local TARGET="$2"
	mkdir -p "$MINTDIR"
	mkdir -p "$MINTDIR/doc"
	cp "$SRC/sys/sockets/.compile_$TARGET/inet4.xdd" "$MINTDIR"
	mkdir -p "$MINTDIR/doc/inet4"
	cp "$SRC/sys/sockets/inet4/BUGS" "$MINTDIR/doc/inet4"
	cp "$SRC/sys/sockets/COPYING" "$MINTDIR/doc/inet4"
	cp "$SRC/sys/sockets/README" "$MINTDIR/doc/inet4"
	cp "$SRC/sys/sockets/README.1ST" "$MINTDIR/doc/inet4"
	cp "$SRC/sys/sockets/README.masquerade" "$MINTDIR/doc/inet4/README.mas"
	cp "$SRC/sys/sockets/README.masquerade.TL" "$MINTDIR/doc/inet4/README.mtl"
	cp "$SRC/sys/xdd/lp/.compile_$TARGET/lp.xdd" "$MINTDIR"
	cp "$SRC/sys/xdd/xconout2/.compile_$TARGET/xconout2.xdd" "$MINTDIR"
	cp "$SRC/sys/xdd/xconout2/README" "$MINTDIR/doc/xconout2.txt"
	cp "$SRC/sys/xfs/ext2fs/.compile_$TARGET/ext2.xfs" "$MINTDIR"
	cp "$SRC/sys/xfs/ext2fs/Readme" "$MINTDIR/doc/ext2fs.txt"
	cp "$SRC/sys/xfs/minixfs/.compile_$TARGET/minix.xfs" "$MINTDIR/minix.xfx"
	cp "$SRC/sys/xfs/minixfs/README" "$MINTDIR/doc/minix.txt"
	cp "$SRC/sys/xfs/nfs/.compile_$TARGET/nfs.xfs" "$MINTDIR"
	cp "$SRC/sys/xfs/nfs/README" "$MINTDIR/doc/nfs.txt"
}

# modules compatible with all m68k machines (except the FireBee...)
copy_m68k_modules() {
	local SYSDIR="$1"
	mkdir -p "$SYSDIR"
	mkdir -p "$SYSDIR/doc"
	cp "$SRC/sys/sockets/xif/asix.xif" "$SYSDIR/asix.xix"
	cp "$SRC/sys/sockets/xif/plip.xif" "$SYSDIR"
	cp "$SRC/sys/sockets/xif/PLIP.txt" "$SYSDIR/doc/plip.txt"
	cp "$SRC/sys/xdd/audio/audiodev.xdd" "$SYSDIR"
	mkdir -p "$SYSDIR/doc/audiodev"
	cp "$SRC/sys/xdd/audio/README" "$SYSDIR/doc/audiodev"
	cp "$SRC/sys/xdd/audio/README.v0.9" "$SYSDIR/doc/audiodev"
	cp "$SRC/sys/xdd/audio/F030.TODO" "$SYSDIR/doc/audiodev"
	cp "$SRC/sys/xdd/flop-raw/flop_raw.xdd" "$SYSDIR"
	cp "$SRC/sys/xdd/flop-raw/README" "$SYSDIR/doc/flop-raw.txt"
}

copy_st_modules() {
	local MCHDIR="$1/st"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	# TODO: perhaps these four are compatible also with other machines
	#       but they are awfully old and obsolete so let's keep them here
	cp "$SRC/sys/sockets/xif/biodma.xif" "$MCHDIR/biodma.xix"
	cp "$SRC/sys/sockets/xif/BIODMA.txt" "$MCHDIR/doc/biodma.txt"
	cp "$SRC/sys/sockets/xif/de600.xif" "$MCHDIR/de600.xix"
	cp "$SRC/sys/sockets/xif/DE600.txt" "$MCHDIR/doc/de600.txt"
	cp "$SRC/sys/sockets/xif/dial.xif" "$MCHDIR/dial.xix"
	cp "$SRC/sys/sockets/xif/DIAL.txt" "$MCHDIR/doc/dial.txt"
	cp "$SRC/sys/sockets/xif/pamsdma.xif" "$MCHDIR/pamsdma.xix"
	cp "$SRC/sys/sockets/xif/PAMs_DMA.txt" "$MCHDIR/doc/pamsdma.txt"

	cp "$SRC/sys/sockets/xif/rtl8012st.xif" "$MCHDIR/rtl8012st.xix"
	cp "$SRC/sys/xdd/mfp/mfp.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
}
copy_megast_modules() {
	local MCHDIR="$1/megast"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/lance.xif" "$MCHDIR/lance.xix"
	cp "$SRC/sys/sockets/xif/rieblmst.xif" "$MCHDIR/rieblmst.xix"
	cp "$SRC/sys/sockets/xif/rieblmst_fast.xif" "$MCHDIR/rieblmst_fast.xix"
	cp "$SRC/sys/sockets/xif/rieblspc.xif" "$MCHDIR/rieblspc.xix"
	cp "$SRC/sys/sockets/xif/rieblspc_fast.xif" "$MCHDIR/rieblspc_fast.xix"
	cp "$SRC/sys/sockets/xif/LANCE.txt" "$MCHDIR/doc/riebl.txt"
	cp "$SRC/sys/sockets/xif/rtl8012st.xif" "$MCHDIR/rtl8012st.xix"
	cp "$SRC/sys/xdd/mfp/mfp.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
}
copy_ste_modules() {
	local MCHDIR="$1/ste"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/rtl8012st.xif" "$MCHDIR/rtl8012st.xix"
	cp "$SRC/sys/xdd/mfp/mfp.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
}
copy_megaste_modules() {
	local MCHDIR="$1/megaste"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/rieblste.xif" "$MCHDIR/rieblste.xix"
	cp "$SRC/sys/sockets/xif/LANCE.txt" "$MCHDIR/doc/riebl.txt"
	cp "$SRC/sys/sockets/xif/rtl8012st.xif" "$MCHDIR/rtl8012st.xix"
	cp "$SRC/sys/xdd/mfp/mfp.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/scc/scc.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/LIESMICH" "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/README" "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/ports.txt" "$MCHDIR/doc/scc"
}
copy_tt_modules() {
	local MCHDIR="$1/tt"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/daynaport/scsilink.xif" "$MCHDIR/scsilink.xix"
	mkdir -p "$MCHDIR/doc/scsilink"
	cp "$SRC/sys/sockets/xif/daynaport/README" "$MCHDIR/doc/scsilink"
	cp "$SRC/sys/sockets/xif/daynaport/scsi_commands.txt" "$MCHDIR/doc/scsilink"
	cp "$SRC/sys/sockets/xif/lance.xif" "$MCHDIR/lance.xix"
	cp "$SRC/sys/sockets/xif/riebltt.xif" "$MCHDIR/riebltt.xix"
	cp "$SRC/sys/sockets/xif/LANCE.txt" "$MCHDIR/doc/riebl.txt"
	cp "$SRC/sys/sockets/xif/rtl8012.xif" "$MCHDIR/rtl8012.xix"
	cp "$SRC/sys/xdd/mfp/mfp.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/scc/scc.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/LIESMICH" "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/README" "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/ports.txt" "$MCHDIR/doc/scc"
}
copy_falcon_modules() {
	local MCHDIR="$1/falcon"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/rtl8012.xif" "$MCHDIR/rtl8012.xix"
	cp "$SRC/sys/sockets/xif/daynaport/scsilink.xif" "$MCHDIR/scsilink.xix"
	mkdir -p "$MCHDIR/doc/scsilink"
	cp "$SRC/sys/sockets/xif/daynaport/README" "$MCHDIR/doc/scsilink"
	cp "$SRC/sys/sockets/xif/daynaport/scsi_commands.txt" "$MCHDIR/doc/scsilink"
	cp "$SRC/sys/xdd/dsp56k/dsp56k.xdd" "$MCHDIR"
	cp "$SRC/sys/xdd/dsp56k/README_MiNT" "$MCHDIR/doc/dsp56k.txt"
	cp "$SRC/sys/xdd/scc/scc.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/LIESMICH" "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/README" "$MCHDIR/doc/scc"
	cp "$SRC/sys/xdd/scc/ports.txt" "$MCHDIR/doc/scc"
}
copy_milan_modules() {
	local MCHDIR="$1/milan"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/xdd/uart/uart.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/uart"
	cp "$SRC/sys/xdd/uart/LIESMICH" "$MCHDIR/doc/uart"
	cp "$SRC/sys/xdd/uart/README" "$MCHDIR/doc/uart"
	cp "$SRC/sys/xdd/uart/ports.txt" "$MCHDIR/doc/uart"
	cp "$SRC/sys/xdd/mfp/mfp_mil.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
}
copy_hades_modules() {
	local MCHDIR="$1/hades"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/xdd/mfp/mfp.xdd" "$MCHDIR"
	mkdir -p "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/LIESMICH" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/README" "$MCHDIR/doc/mfp"
	cp "$SRC/sys/xdd/mfp/ports.txt" "$MCHDIR/doc/mfp"
}
copy_ct60_modules() {
	local MCHDIR="$1/ct60"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"

	cp -r "$1/falcon"/* "$MCHDIR"

	# we don't need plain st/falcon version
	rm "$MCHDIR/rtl8012.xix"
	cp "$SRC/sys/sockets/xif/rtl8012ct60.xif" "$MCHDIR/rtl8012ct60.xix"
	cp "$SRC/sys/sockets/xif/rtl8139.xif" "$MCHDIR/rtl8139.xix"

	cp "$SRC/sys/sockets/xif/ethernat/ethernat.xif" "$MCHDIR/ethernat.xix"
	cp "$SRC/sys/sockets/xif/ethernat/README" "$MCHDIR/doc/ethernat.txt"
	cp "$SRC/sys/sockets/xif/svethlana/svethlan.xif" "$MCHDIR/svethlan.xix"
	cp "$SRC/sys/sockets/xif/svethlana/README" "$MCHDIR/doc/svethlan.txt"
}
copy_firebee_modules() {
	local MCHDIR="$1/firebee"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/fec/fec.xif" "$MCHDIR/fec.xif"
	cp "$SRC/sys/sockets/xif/fec/README" "$MCHDIR/doc/fec.txt"
}
copy_aranym_modules() {
	local MCHDIR="$1/aranym"
	mkdir -p "$MCHDIR"
	mkdir -p "$MCHDIR/doc"
	cp "$SRC/sys/sockets/xif/nfeth/nfeth.xif" "$MCHDIR"
	cp "$SRC/sys/sockets/xif/nfeth/README" "$MCHDIR/doc/nfeth.txt"
	cp "$SRC/sys/xdd/nfstderr/nfstderr.xdd" "$MCHDIR"
	cp "$SRC/sys/xdd/nfstderr/README" "$MCHDIR/doc/nfstderr.txt"
	cp "$SRC/sys/xdd/nfexec/nfexec.xdd" "$MCHDIR"
	cp "$SRC/sys/xdd/nfexec/README" "$MCHDIR/doc/nfexec.txt"
	cp "$SRC/sys/xfs/aranym/aranym.xfs" "$MCHDIR"
	cp "$SRC/sys/xfs/aranym/README" "$MCHDIR/doc/aranym.txt"
	# not really needed
	cp "$SRC/sys/xfs/hostfs/hostfs.xfs" "$MCHDIR/hostfs.xfx"
	cp "$SRC/sys/xfs/hostfs/README" "$MCHDIR/doc/hostfs.txt"
}

copy_xaloader() {
	local XAAESDIR="$1"
	local TARGET="$2"
	mkdir -p "$XAAESDIR"
	cp "$SRC/xaaes/src.km/xaloader/.compile_$TARGET/xaloader.prg" "$XAAESDIR"
}

copy_xaaes() {
	local XAAESDIR="$1"
	local TARGET="$2"
	local BOOTABLE="$3"
	mkdir -p "$XAAESDIR"
	if [ "$TARGET" = "col" ]
	then
	cp "$SRC/xaaes/src.km/xaaesv4e.km" "$XAAESDIR/xaaes.km"
	elif [ "$TARGET" = "000" ]
	then
	cp "$SRC/xaaes/src.km/xaaesst.km" "$XAAESDIR/xaaesst.km"
	cp "$SRC/xaaes/src.km/xaaes$TARGET.km" "$XAAESDIR/xaaes.km"
	else
	cp "$SRC/xaaes/src.km/xaaes$TARGET.km" "$XAAESDIR/xaaes.km"
	fi
	cp "$SRC/xaaes/src.km/adi/whlmoose/.compile_$TARGET/moose.adi" "$XAAESDIR"
	cp "$SRC/xaaes/src.km/adi/whlmoose/.compile_$TARGET/moose_w.adi" "$XAAESDIR"
	mkdir -p "$XAAESDIR/gradient"
	cp "$SRC/xaaes/src.km/gradient"/*.grd "$XAAESDIR/gradient"
	cp -r "$SRC/xaaes/src.km/img" "$XAAESDIR"
	cp -r "$SRC/xaaes/src.km/pal" "$XAAESDIR"
	mkdir -p "$XAAESDIR/widgets"
	cp "$SRC/xaaes/src.km/widgets"/*.rsc "$XAAESDIR/widgets"
	mkdir -p "$XAAESDIR/xobj"
	cp "$SRC/xaaes/src.km/xobj"/*.rsc "$XAAESDIR/xobj"
	if [ "$BOOTABLE" = "yes" ]
	then
	cp "$SRC/xaaes/src.km/example.cnf" "$XAAESDIR/xaaes.cnf"
	sed -e "s/^setenv TOSRUN		u:\\\\usr\\\\gem\\\\toswin2\\\\tw-call.app/setenv TOSRUN		u:\\\\c\\\\mint\\\\$VER\\\\sysroot\\\\GEM\\\\toswin2\\\\tw-call.app/;" "$XAAESDIR/xaaes.cnf" > "$XAAESDIR/xaaes.cnf.tmp" && mv "$XAAESDIR/xaaes.cnf.tmp" "$XAAESDIR/xaaes.cnf"
	sed -e "s/^run c:\\\\tools\\\\toswin2.app/run u:\\\\c\\\\mint\\\\$VER\\\\sysroot\\\\GEM\\\\toswin2\\\\toswin2.app/;" "$XAAESDIR/xaaes.cnf" > "$XAAESDIR/xaaes.cnf.tmp" && mv "$XAAESDIR/xaaes.cnf.tmp" "$XAAESDIR/xaaes.cnf"
	sed -e "s/^#setenv AVSERVER   \"DESKTOP \"/setenv AVSERVER   \"DESKTOP \"/;" "$XAAESDIR/xaaes.cnf" > "$XAAESDIR/xaaes.cnf.tmp" && mv "$XAAESDIR/xaaes.cnf.tmp" "$XAAESDIR/xaaes.cnf"
	sed -e "s/^#setenv FONTSELECT \"DESKTOP \"/setenv FONTSELECT \"DESKTOP \"/;" "$XAAESDIR/xaaes.cnf" > "$XAAESDIR/xaaes.cnf.tmp" && mv "$XAAESDIR/xaaes.cnf.tmp" "$XAAESDIR/xaaes.cnf"
	if [ "$TARGET" = "col" ]
	then
	sed -e "s/^#shell = c:\\\\teradesk\\\\desktop.prg/shell = u:\\\\c\\\\mint\\\\$VER\\\\sysroot\\\\GEM\\\\teradesk\\\\desk_cf.prg/;" "$XAAESDIR/xaaes.cnf" > "$XAAESDIR/xaaes.cnf.tmp" &&
	mv "$XAAESDIR/xaaes.cnf.tmp" "$XAAESDIR/xaaes.cnf"
	else
	sed -e "s/^#shell = c:\\\\teradesk\\\\desktop.prg/shell = u:\\\\c\\\\mint\\\\$VER\\\\sysroot\\\\GEM\\\\teradesk\\\\desktop.prg/;" "$XAAESDIR/xaaes.cnf" > "$XAAESDIR/xaaes.cnf.tmp" &&
	mv "$XAAESDIR/xaaes.cnf.tmp" "$XAAESDIR/xaaes.cnf"
	fi
	fi
	cp "$SRC/xaaes/src.km"/xa_help.* "$XAAESDIR"
	cp "$SRC/xaaes/src.km"/*.rsc "$XAAESDIR"
	cp "$SRC/xaaes/src.km"/*.rsl "$XAAESDIR"
}

copy_usbloader() {
	local USBDIR="$1"
	local TARGET="$2"
	mkdir -p "$USBDIR"
	cp "$SRC/sys/usb/src.km/loader/.compile_$TARGET/loader.prg" "$USBDIR"
}

copy_usb() {
	local USBDIR="$1"
	local TARGET="$2"
	mkdir -p "$USBDIR"
	cp "$SRC/sys/usb/src.km/.compile_$TARGET"/*.km "$USBDIR/usb.km"
	cp "$SRC/sys/usb/src.km/udd/eth/.compile_$TARGET/eth.udd" "$USBDIR"
	cp "$SRC/sys/usb/src.km/udd/keyboard/.compile_$TARGET/keyboard.udd" "$USBDIR"
	cp "$SRC/sys/usb/src.km/udd/mouse/.compile_$TARGET/mouse.udd" "$USBDIR"
	cp "$SRC/sys/usb/src.km/udd/printer/.compile_$TARGET/printer.udd" "$USBDIR"
	cp "$SRC/sys/usb/src.km/udd/storage/.compile_$TARGET/storage.udd" "$USBDIR"
}

copy_atari_usb_modules() {
	local USBDIR="$1"
	local TARGET="$2"
	mkdir -p "$USBDIR"
	cp "$SRC/sys/usb/src.km/ucd/netusbee/.compile_$TARGET/netusbee.ucd" "$USBDIR"
	cp "$SRC/sys/usb/src.km/ucd/unicorn/.compile_$TARGET/unicorn.ucd" "$USBDIR"
}

copy_ehci_usb_modules() {
	local USBDIR="$1"
	local TARGET="$2"
	mkdir -p "$USBDIR"
	cp "$SRC/sys/usb/src.km/ucd/ehci/.compile_$TARGET/ehci.ucd" "$USBDIR"
}

copy_ct60_usb_modules() {
	local USBDIR="$1"
	mkdir -p "$USBDIR"
	cp "$SRC/sys/usb/src.km/ucd/ethernat/ethernat.ucd" "$USBDIR"
}

copy_aranym_usb_modules() {
	local USBDIR="$1"
	mkdir -p "$USBDIR"
	cp "$SRC/sys/usb/src.km/ucd/aranym/aranym.ucd" "$USBDIR"
}

copy_usb4tos() {
	local USB4TOSDIR="$1"
	mkdir -p "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/.compile_prg/usb.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/ucd/unicorn/.compile_prg/unicorn.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/ucd/netusbee/.compile_prg/netusbee.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/ucd/netusbee/.compile_prg_000/netusbee.prg" "$USB4TOSDIR/netus000.prg"
	cp "$SRC/sys/usb/src.km/udd/eth/.compile_prg/eth.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/udd/keyboard/.compile_prg/keyboard.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/udd/mouse/.compile_prg/mouse.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/udd/printer/.compile_prg/printer.prg" "$USB4TOSDIR"
	cp "$SRC/sys/usb/src.km/udd/storage/.compile_prg/storage.prg" "$USB4TOSDIR"
	# TODO: multiple CPU variants?
	cp "$SRC/tools/usbtool/.compile_000/usbtool.acc" "$USB4TOSDIR"
}

copy_fonts() {
	local FONTSDIR="$1"
	mkdir -p "$FONTSDIR"
	cp -r "$SRC/fonts"/* "$FONTSDIR"
}

copy_tbl() {
	local TBLDIR="$1"
	mkdir -p "$TBLDIR"
	cp -r "$SRC/sys/tbl"/* "$TBLDIR"
}

copy_sysroot() {
	local SYSROOT="$1"
	local TARGET="$2"
	mkdir -p "$SYSROOT/GEM"

	mkdir -p "$SYSROOT/GEM/cops"
	cp "$SRC/tools/cops/.compile_english_$TARGET/cops.app" "$SYSROOT/GEM/cops"
	cp "$SRC/tools/cops/.compile_german_$TARGET/cops_de.app" "$SYSROOT/GEM/cops"
	cp "$SRC/tools/cops/.compile_france_$TARGET/cops_fr.app" "$SYSROOT/GEM/cops"

	mkdir -p "$SYSROOT/GEM/fsetter"
	cp "$SRC/tools/fsetter/.compile_$TARGET/fsetter.app" "$SYSROOT/GEM/fsetter"
	cp "$SRC/tools/fsetter/COPYING" "$SYSROOT/GEM/fsetter"
	cp "$SRC/tools/fsetter/liesmich" "$SYSROOT/GEM/fsetter"
	cp "$SRC/tools/fsetter/readme" "$SYSROOT/GEM/fsetter"
	cp "$SRC/tools/fsetter/history.txt" "$SYSROOT/GEM/fsetter"
	cp "$SRC/tools/fsetter/fsetter_e.rsc" "$SYSROOT/GEM/fsetter/fsetter.rsc"
	mkdir -p "$SYSROOT/GEM/fsetter/de"
	cp "$SRC/tools/fsetter/fsetter.rsc" "$SYSROOT/GEM/fsetter/de/fsetter.rsc"

	mkdir -p "$SYSROOT/GEM/gemkfat"
	cp "$SRC/tools/mkfatfs/COPYING" "$SYSROOT/GEM/gemkfat"
	cp "$SRC/tools/mkfatfs/.compile_$TARGET/gemkfatfs.app" "$SYSROOT/GEM/gemkfat/gemkfatfs.app"
	cp "$SRC/tools/mkfatfs/gemkfatfs.rsc" "$SYSROOT/GEM/gemkfat/gemkfatfs.rsc"

	mkdir -p "$SYSROOT/GEM/gluestik"
	cp "$SRC/tools/gluestik/.compile_$TARGET/gluestik.prg" "$SYSROOT/GEM/gluestik"
	cp "$SRC/tools/gluestik/COPYING" "$SYSROOT/GEM/gluestik"
	cp "$SRC/tools/gluestik/LIESMICH" "$SYSROOT/GEM/gluestik"
	cp "$SRC/tools/gluestik/README" "$SYSROOT/GEM/gluestik"

	mkdir -p "$SYSROOT/GEM/hyp_view"
	cp "$SRC/tools/hypview/.compile_$TARGET/hyp_view.app" "$SYSROOT/GEM/hyp_view"
	cp -r "$SRC/tools/hypview/doc" "$SYSROOT/GEM/hyp_view"
	mkdir -p "$SYSROOT/GEM/hyp_view/de"
	cp -r "$SRC/tools/hypview/hyp_view/de.rsc" "$SYSROOT/GEM/hyp_view/de/hyp_view.rsc"
	mkdir -p "$SYSROOT/GEM/hyp_view/cs"
	cp -r "$SRC/tools/hypview/hyp_view/cs.rsc" "$SYSROOT/GEM/hyp_view/cs/hyp_view.rsc"
	cp "$SRC/tools/hypview/release"/* "$SYSROOT/GEM/hyp_view"
	cp -r "$SRC/tools/hypview/skins" "$SYSROOT/GEM/hyp_view"
	cp "$SRC/tools/hypview/hyp_view.bgh" "$SYSROOT/GEM/hyp_view"
	cp "$SRC/tools/hypview/hyp_view/en.rsc" "$SYSROOT/GEM/hyp_view/hyp_view.rsc"

	mkdir -p "$SYSROOT/GEM/mgw"
	cp "$SRC/tools/mgw/.compile_$TARGET/mgw.prg" "$SYSROOT/GEM/mgw"
	cp -r "$SRC/tools/mgw/examples" "$SYSROOT/GEM/mgw"
	cp "$SRC/tools/mgw/COPYING" "$SYSROOT/GEM/mgw"
	cp "$SRC/tools/mgw/LIESMICH" "$SYSROOT/GEM/mgw"
	cp "$SRC/tools/mgw/README" "$SYSROOT/GEM/mgw"

	mkdir -p "$SYSROOT/GEM/nohog2"
	cp "$SRC/tools/nohog2/.compile_$TARGET/nohog2.acc" "$SYSROOT/GEM/nohog2"
	cp "$SRC/tools/nohog2/COPYING" "$SYSROOT/GEM/nohog2"
	cp "$SRC/tools/nohog2/README" "$SYSROOT/GEM/nohog2"

	mkdir -p "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/.compile_$TARGET/toswin2.app" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/tw-call/.compile_$TARGET/tw-call.app" "$SYSROOT/GEM/toswin2"
	# TODO: 'doc' need to be compiled as a HYP
	cp -r "$SRC/tools/toswin2/doc" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/english/toswin2.rsc" "$SYSROOT/GEM/toswin2"
	cp -r "$SRC/tools/toswin2/screenshots" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/BUGS" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/FAQ" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/NEWS" "$SYSROOT/GEM/toswin2"
	mkdir -p "$SYSROOT/GEM/toswin2/de"
	cp "$SRC/tools/toswin2/toswin2.rsc" "$SYSROOT/GEM/toswin2/de"
	cp "$SRC/tools/toswin2/allcolors.sh" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/twterm.src" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/README.terminfo" "$SYSROOT/GEM/toswin2"
	cp "$SRC/tools/toswin2/vttest.txt" "$SYSROOT/GEM/toswin2"

	mkdir -p "$SYSROOT/bin"
	cp "$SRC/tools/crypto/.compile_$TARGET/crypto" "$SYSROOT/bin/crypto.ttp"
	cp "$SRC/tools/fdisk/.compile_$TARGET/fdisk" "$SYSROOT/bin/fdisk.ttp"
	cp "$SRC/tools/fdisk/.compile_$TARGET/sfdisk" "$SYSROOT/bin/sfdisk.ttp"
	cp "$SRC/tools/lpflush/.compile_$TARGET/lpflush" "$SYSROOT/bin/lpflush.ttp"
	cp "$SRC/tools/minix/fsck/.compile_$TARGET/fsck.minix" "$SYSROOT/bin/mfsck.ttp"
	cp "$SRC/tools/minix/minit/.compile_$TARGET/minit" "$SYSROOT/bin/minit.ttp"
	cp "$SRC/tools/minix/tools/.compile_$TARGET/flist" "$SYSROOT/bin/mflist.ttp"
	cp "$SRC/tools/minix/tools/.compile_$TARGET/mfsconf" "$SYSROOT/bin/mfsconf.ttp"
	cp "$SRC/tools/mkfatfs/.compile_$TARGET/mkfatfs" "$SYSROOT/bin/mkfatfs.ttp"
	cp "$SRC/tools/mktbl/.compile_$TARGET/mktbl" "$SYSROOT/bin/mktbl.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/arp" "$SYSROOT/bin/arp.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/diald" "$SYSROOT/bin/diald.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/ifconfig" "$SYSROOT/bin/ifconfig.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/iflink" "$SYSROOT/bin/iflink.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/ifstats" "$SYSROOT/bin/ifstats.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/masqconf" "$SYSROOT/bin/masqconf.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/netstat" "$SYSROOT/bin/netstat.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/pppconf" "$SYSROOT/bin/pppconf.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/route" "$SYSROOT/bin/route.ttp"
	cp "$SRC/tools/net-tools/.compile_$TARGET/slattach" "$SYSROOT/bin/slattach.ttp"
	cp "$SRC/tools/net-tools/slinkctl/.compile_$TARGET/slinkctl" "$SYSROOT/bin/slinkctl.ttp"
	cp "$SRC/tools/nfs/.compile_$TARGET/mount_nfs" "$SYSROOT/bin/nfsmount.ttp"
	cp "$SRC/tools/strace/.compile_$TARGET/strace" "$SYSROOT/bin/strace.ttp"
	cp "$SRC/tools/swkbdtbl/.compile_$TARGET/swkbdtbl" "$SYSROOT/bin/swkbdtbl.ttp"
	cp "$SRC/tools/sysctl/.compile_$TARGET/sysctl" "$SYSROOT/bin/sysctl.ttp"

	mkdir -p "$SYSROOT/share/man/man8"
	cp "$SRC/tools/fdisk/sfdisk.8" "$SYSROOT/share/man/man8/sfdisk"
	mkdir -p "$SYSROOT/share/doc/sfdisk"
	cp "$SRC/tools/fdisk/sfdisk.examples" "$SYSROOT/share/doc/sfdisk"

	mkdir -p "$SYSROOT/share/man/man1"
	cp "$SRC/tools/lpflush/lpflush.1" "$SYSROOT/share/man/man1/lpflush"
	mkdir -p "$SYSROOT/share/doc/lpflush"
	cp "$SRC/tools/lpflush/COPYING" "$SYSROOT/share/doc/lpflush"

	mkdir -p "$SYSROOT/share/doc/minix-tools"
	cp "$SRC/tools/minix/COPYING" "$SYSROOT/share/doc/minix-tools"
	cp "$SRC/tools/minix/docs"/*.doc "$SYSROOT/share/doc/minix-tools"

	mkdir -p "$SYSROOT/share/doc/mkfatfs"
	cp "$SRC/tools/mkfatfs/COPYING" "$SYSROOT/share/doc/mkfatfs"
	cp "$SRC/tools/mkfatfs/README" "$SYSROOT/share/doc/mkfatfs"

	mkdir -p "$SYSROOT/share/doc/mktbl"
	cp "$SRC/tools/mktbl/COPYING" "$SYSROOT/share/doc/mktbl"

	mkdir -p "$SYSROOT/share/man/man8"
	cp "$SRC/tools/net-tools/ifconfig.8" "$SYSROOT/share/man/man8/ifconfig"
	cp "$SRC/tools/net-tools/netstat.8" "$SYSROOT/share/man/man8/netstat"
	cp "$SRC/tools/net-tools/route.8" "$SYSROOT/share/man/man8/route"
	mkdir -p "$SYSROOT/share/doc/net-tools"
	cp "$SRC/tools/net-tools/slinkctl/README" "$SYSROOT/share/doc/net-tools/slinkctl.txt"
	cp "$SRC/tools/net-tools/COPYING" "$SYSROOT/share/doc/net-tools"

	mkdir -p "$SYSROOT/share/man/man5"
	cp "$SRC/tools/nfs/mtab.5" "$SYSROOT/share/man/man5/mtab"
	mkdir -p "$SYSROOT/share/man/man8"
	cp "$SRC/tools/nfs/mount.8" "$SYSROOT/share/man/man8/mount"
	mkdir -p "$SYSROOT/share/doc/nfs"
	cp "$SRC/tools/nfs/COPYING" "$SYSROOT/share/doc/nfs"
	cp "$SRC/tools/nfs/README" "$SYSROOT/share/doc/nfs"
}

create_filesystem() {
	mkdir -p "$SYSROOT"/{bin,etc,root,tmp,var/run}

	if [ "$CPU_TARGET" = "000" ]
	then
		cp "$BASH_DIR/bash000.ttp" "$SYSROOT/bin/bash"
	elif [ "$CPU_TARGET" = "col" ]
	then
		cp "$BASH_DIR/bashv4e.ttp" "$SYSROOT/bin/bash"
	else
		# 02060, 030, 040, 060
		cp "$BASH_DIR/bash020.ttp" "$SYSROOT/bin/bash"
	fi

	echo "root:x:0:0::/root:/bin/bash" > "$SYSROOT/etc/passwd"

	echo "PS1='[\\[\\e[31m\\]\\u\\[\\e[m\\]@\\[\\e[32m\\]\\h\\[\\e[m\\] \\W]\\$ '" > "$SYSROOT/etc/profile"
	echo "export PS1" >> "$SYSROOT/etc/profile"

	touch "$SYSROOT/var/run/utmp"

	cp -r "$TERADESK_DIR" "$SYSROOT/GEM"
}
