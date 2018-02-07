FROM scratch

COPY cross-build/resin-xbuild /usr/bin/resin-xbuild
COPY cross-build/resin-xbuild /usr/bin/cross-build-start
COPY cross-build/resin-xbuild /usr/bin/cross-build-end
COPY cross-build/__QEMU__ /usr/bin/__QEMU__
