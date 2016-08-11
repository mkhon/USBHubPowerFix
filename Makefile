KEXT=	USBHubPowerFix.kext
DESTDIR=/Library/Extensions

all:

install:
	cp -R ${KEXT} ${DESTDIR}
	chown -R root:wheel ${DESTDIR}/${KEXT}
	chmod -R og-w ${DESTDIR}/${KEXT}

load:
	kextload ${DESTDIR}/${KEXT}
