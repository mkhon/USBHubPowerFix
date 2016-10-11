KEXT=	USBHubPowerFix.kext
SUDO=	sudo
DESTDIR=/Library/Extensions

all:

install:
	${SUDO} cp -R ${KEXT} ${DESTDIR}
	${SUDO} chown -R root:wheel ${DESTDIR}/${KEXT}
	${SUDO} chmod -R og-w ${DESTDIR}/${KEXT}

load:
	${SUDO} kextload ${DESTDIR}/${KEXT}
