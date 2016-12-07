KEXT=		USBHubPowerFix.kext

CODESIGN=	codesign
KEXTUTIL=	kextutil
SUDO=		sudo
TAR=		tar

DESTDIR=	/Library/Extensions
IDENTITY=	E1E40BB5B7277129FCA48576BBC1625463B13386

all:

sign:
	${CODESIGN} -s ${IDENTITY} ${KEXT}

check:
	${SUDO} ${KEXTUTIL} -t ${KEXT}

package:
	${TAR} cvf ${KEXT}.zip --format zip ${KEXT}

clean:
	${RM} -r ${KEXT}/Contents/_CodeSignature ${KEXT}.zip

install:
	${SUDO} cp -R ${KEXT} ${DESTDIR}
	${SUDO} chown -R root:wheel ${DESTDIR}/${KEXT}
	${SUDO} chmod -R og-w ${DESTDIR}/${KEXT}

load:
	${SUDO} kextload ${DESTDIR}/${KEXT}
