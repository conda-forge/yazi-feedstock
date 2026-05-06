#!/usr/bin/env bash

set -euxo pipefail
export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat

if [[ "${HOST:-}" == "powerpc64le-conda-linux-gnu" ]]; then
  export CC_powerpc64le_unknown_linux_gnu="${BUILD_PREFIX}/bin/powerpc64le-conda-linux-gnu-cc"
  export CXX_powerpc64le_unknown_linux_gnu="${BUILD_PREFIX}/bin/powerpc64le-conda-linux-gnu-c++"
fi

cargo install --path "${SRC_DIR}/yazi-build" --no-track --locked --bins yazi-build
cargo install --path "${SRC_DIR}/yazi-fm" --no-track --locked --bins --root "${PREFIX}" yazi-fm
cargo install --path "${SRC_DIR}/yazi-cli" --no-track --locked --bins --root "${PREFIX}" yazi-cli
cargo-bundle-licenses --format yaml --output "${SRC_DIR}/THIRDPARTY.yml"
