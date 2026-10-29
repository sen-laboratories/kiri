#!/bin/sh
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 SEN Labs e.U.
#
# Builds qpdf (https://github.com/qpdf/qpdf, Apache-2.0) from its source and makes the packages `qpdf` (the library and the programs) and `qpdf_devel`
# (headers, pkg-config file) for the Kiri repository, as it is done for mupdf1.28. Run it on Haiku; needs cmake, zlib_devel, libjpeg_turbo_devel
# and openssl3_devel.
#
#   ./package.sh [<folder of the qpdf source>]       # default: $QPDF_SRC or /Develop/3rd-party/qpdf
#
# Environment: OUT_DIR (where the packages go, default ./out), BUILD_DIR (the build tree, several 100 MB: default /tmp/qpdf-build), REVISION (default 1),
# JOBS (default 4). The version is that of the source (CMakeLists.txt); the version of the library (SONAME) is read from what was built.
set -e

here=$(cd "$(dirname "$0")" && pwd)
SRC=${1:-${QPDF_SRC:-/Develop/3rd-party/qpdf}}
OUT=${OUT_DIR:-$here/out}
BUILD=${BUILD_DIR:-/tmp/qpdf-build}
REVISION=${REVISION:-1}
JOBS=${JOBS:-4}
ARCH=$(getarch)

[ -f "$SRC/CMakeLists.txt" ] || { echo "no qpdf source in $SRC" >&2; exit 1; }
VERSION=$(sed -n '/^project(qpdf/,/)/s/.*VERSION[[:space:]]\{1,\}\([0-9][0-9.]*\).*/\1/p' "$SRC/CMakeLists.txt" | head -n1)
[ -n "$VERSION" ] || { echo "no version in $SRC/CMakeLists.txt" >&2; exit 1; }
echo "qpdf $VERSION from $SRC, build in $BUILD, packages in $OUT"

STAGE=$BUILD/stage
rm -rf "$STAGE"
mkdir -p "$OUT"

# /boot/system is where the files end up; the headers go to develop/headers as on Haiku. No static library, no documentation, no cmake package files
# (their relative paths do not survive the move of the library into the development folder; programs use -lqpdf and the pkg-config file).
cmake -S "$SRC" -B "$BUILD" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/boot/system -DCMAKE_INSTALL_INCLUDEDIR=develop/headers \
	-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF -DUSE_IMPLICIT_CRYPTO=OFF -DREQUIRE_CRYPTO_OPENSSL=ON \
	-DBUILD_DOC=OFF -DINSTALL_MANUAL=OFF -DINSTALL_EXAMPLES=OFF -DINSTALL_CMAKE_PACKAGE=OFF
cmake --build "$BUILD" -j"$JOBS"
DESTDIR="$STAGE" cmake --install "$BUILD"
root=$STAGE/boot/system

# the library: version of the SONAME from what was built (libqpdf.so.30.4.2: 30 is the compatible one)
lib=$(ls "$root"/lib/libqpdf.so.*.*.* | head -n1)
[ -f "$lib" ] || { echo "libqpdf was not built" >&2; exit 1; }
SOVERSION=${lib##*/libqpdf.so.}
SOMAJOR=${SOVERSION%%.*}
echo "library version $SOVERSION (compatible with $SOMAJOR)"

# runtime package: the library, the programs, the licenses
RT=$BUILD/package-qpdf
rm -rf "$RT"
mkdir -p "$RT/lib" "$RT/bin" "$RT/documentation/packages/qpdf"
cp -a "$root"/lib/libqpdf.so.* "$RT/lib/"
for program in qpdf fix-qdf zlib-flate; do
	cp "$root/bin/$program" "$RT/bin/"
done
strip --strip-unneeded "$RT"/lib/libqpdf.so.*.*.* "$RT"/bin/* 2>/dev/null || true
[ -d "$root/share/man" ] && cp -a "$root/share/man" "$RT/documentation/man"
cp "$SRC/LICENSE.txt" "$SRC/NOTICE.md" "$SRC/Artistic-2.0" "$RT/documentation/packages/qpdf/"

# development package: headers, the pkg-config file, the name of the library for the linker (it points to the library of the runtime package)
DV=$BUILD/package-qpdf_devel
rm -rf "$DV"
mkdir -p "$DV/develop/lib/pkgconfig"
cp -a "$root/develop/headers" "$DV/develop/"
cp "$root"/lib/pkgconfig/libqpdf.pc "$DV/develop/lib/pkgconfig/"
ln -s "../../lib/libqpdf.so.$SOMAJOR" "$DV/develop/lib/libqpdf.so"

# what the programs need: check it against `requires` of the template
echo "needed by the library:"; readelf -d "$RT"/lib/libqpdf.so.*.*.* | grep NEEDED
echo "needed by the program qpdf:"; readelf -d "$RT/bin/qpdf" | grep NEEDED

pkgversion="$VERSION-$REVISION"
for name in qpdf qpdf_devel; do
	dir=$BUILD/package-$name
	sed -e "s|@VERSION@|$pkgversion|g" -e "s|@ARCH@|$ARCH|g" -e "s|@SOVERSION@|$SOVERSION|g" -e "s|@SOMAJOR@|$SOMAJOR|g" \
		"$here/PackageInfo.$name.in" > "$dir/.PackageInfo"
	package create -C "$dir" "$OUT/$name-$pkgversion-$ARCH.hpkg"
	echo "created $OUT/$name-$pkgversion-$ARCH.hpkg"
done
