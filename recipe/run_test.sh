#! /bin/bash

git clone https://github.com/mcflugen/hydrotrend
cd hydrotrend && git checkout add-bmi-metadata

prefix=$(python -c 'import sys; print sys.prefix')
mkdir _build && pushd _build
  cmake .. -DCMAKE_INSTALL_PREFIX=$prefix
  make -j$CPU_COUNT all install
  export PKG_CONFIG_PATH=$prefix/lib/pkgconfig
popd

bmi babelize . --prefix=$prefix

mkdir _test && cd _test
python -c 'from pymt.components import Hydrotrend; Hydrotrend()'
