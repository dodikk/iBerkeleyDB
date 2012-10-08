LAUNCH_DIR=$PWD
BUILD_UNIX_PATH=$1
ARCH=$2

echo "-----Build Generic------"
echo LAUNCH_DIR - $LAUNCH_DIR
echo BUILD_UNIX_PATH - $BUILD_UNIX_PATH
echo ARCH - $ARCH

echo "===="


cd "$BUILD_UNIX_PATH"
pwd

make clean
make realclean



export XCODE_ROOT=$(xcode-select -print-path)


export SDK_iSimulator=$XCODE_ROOT/Toolchains/XcodeDefault.xctoolchain/
export COMPILER_iSimulator=${DEV_iSimulator}/usr/bin
export CC=${COMPILER_iSimulator}/clang
export CXX=${COMPILER_iSimulator}/clang++
export LDFLAGS="-arch ${ARCH} -pipe -Os -gdwarf-2 -no-cpp-precomp -mthumb -isysroot ${SDK_iSimulator}"
export CFLAGS=${LDFLAGS}
export CXXFLAGS=${LDFLAGS}
export CPP="/usr/bin/cpp ${CPPFLAGS}"
export LD=${COMPILER_iSimulator}/ld
export AR=${COMPILER_iSimulator}/ar
export AS=${COMPILER_iSimulator}/as
export NM=${COMPILER_iSimulator}/nm
export RANLIB=${COMPILER_iSimulator}/ranlib


echo "Configure..."
../dist/configure --host=i386-apple-darwin10 --enable-static=yes --enable-shared=no --enable-stl --enable-sql --enable-cxx --program-suffix=${ARCH}
echo "Configure done."


make
make install
cd "$LAUNCH_DIR"
echo "-----------"