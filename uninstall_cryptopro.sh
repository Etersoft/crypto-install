#!/bin/sh

# TODO: only if not root
SUDO=sudo

fatal()
{
    echo "FATAL: $*" >&2
    exit 1
}


INSTALL32=''
INSTALL64=''
case "$1" in
    32)
        INSTALL32="$1"
        ;;
    64)
        INSTALL64="$1"
        ;;
    both)
        INSTALL32="$1"
        INSTALL64="$1"
        ;;
    *)
        fatal "Run with 32|64|both param"
esac



if [ -n "$INSTALL64" ] ; then

    # ruToken support
    epme pcsc-lite-rutokens pcsc-lite-ccid librtpkcs11ecp
    epme cprocsp-rdr-rutoken-64 cprocsp-rdr-pcsc-64

    if cd linux-amd64 ; then
        $SUDO bash ./uninstall.sh
    fi

    # TODO: GUI
    # epme i586-libgtk+2 i586-libSM
    # epme cprocsp-cptools-gtk-64
fi

if [ -n "$INSTALL32" ] ; then

    # ruToken support
    epme i586-pcsc-lite-rutokens i586-pcsc-lite-ccid i586-librtpkcs11ecp
    epme cprocsp-rdr-rutoken cprocsp-rdr-pcsc

    if cd linux-ia32 ; then
        $SUDO i586 bash ./uninstall.sh
    fi

    # TODO: GUI
    # epme i586-libgtk+2 i586-libSM
    # epme cprocsp-cptools-gtk
fi
