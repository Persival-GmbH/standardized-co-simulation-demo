#!/usr/bin/env bash
set -e
set -o pipefail

# Determine project root
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

FMU_TARGET_DIR="$ROOT_DIR/fmus"
mkdir -p "$FMU_TARGET_DIR"

#######################################
# Function: copy_fmu <source_path>
#######################################
copy_fmu() {
    local src="$1"

    if [[ -f "$src" ]]; then
        echo "Copying $(basename "$src") to fmus/"
        cp "$src" "$FMU_TARGET_DIR/"
    else
        echo "ERROR: FMU not found: $src"
        exit 1
    fi
}

echo "Project root: $ROOT_DIR"


#######################################
# Build esmini
#######################################
echo "=== Building esmini ==="
cd "$ROOT_DIR/tools/esmini"

mkdir -p build
cd build
cmake ..
cmake --build . --config Release --target install -j12

echo "=== esmini build complete ==="

echo "=== Building esmini FMU ==="
cd "$ROOT_DIR/tools/esmini/OSMP_FMU"

mkdir -p build
cd build
cmake ..
cmake --build . -j12

echo "=== esmini FMU build complete ==="

# Copy esmini FMU
copy_fmu "$ROOT_DIR/tools/esmini/OSMP_FMU/build/esmini.fmu"


#######################################
# Build openmcx
#######################################
echo "=== Building openmcx ==="
cd "$ROOT_DIR/tools/openmcx"

chmod +x build.sh
./build.sh

echo "=== openmcx build complete ==="


#######################################
# Build sl-5-6-osi-trace-file-writer
#######################################
echo "=== Building sl-5-6-osi-trace-file-writer ==="
cd "$ROOT_DIR/tools/sl-5-6-osi-trace-file-writer"

mkdir -p build
cd build
cmake ..
cmake --build . -j12

echo "=== sl-5-6-osi-trace-file-writer build complete ==="

# Copy OSI trace writer FMU
copy_fmu "$ROOT_DIR/tools/sl-5-6-osi-trace-file-writer/build/sl-5-6-osi-trace-file-writer.fmu"


echo "=== All builds completed successfully ==="
