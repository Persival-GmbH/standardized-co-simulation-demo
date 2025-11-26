# Standardized Co-Simulation Demo

Coming soon...

- Setting up a co-simulation with OpenMCx
- Using esmini in a co-simulation
- Utilizing ASAM OpenDRIVE, OpenSCENARIO XML, OpenMATERIAL 3D and OSI data
- Physical perception sensor simulation with standardized interfaces


## Build

This demo repository has only been tested on Ubuntu >= 20.04.
Follow these steps to build all components:

1. Clone the repository

    ```bash
    git clone https://github.com/github.com/Persival-GmbH/standardized-co-simulation-demo.git --recurse-submodules
    cd standardized-co-simulation-demo
    ```

2. Install dependencies

  - Protobuf with static linking

    ```bash
    wget https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protobuf-all-21.12.tar.gz
    tar -xzf protobuf-all-21.12.tar.gz
    cd protobuf-21.12/
    ./configure --disable-shared CXXFLAGS="-fPIC"
    make
    sudo make install
    sudo ldconfig
    ```
  
  - When using a sensor model: Nvidia driver (Nvidia RTX GPU required) >= 535 is required
    
    ```bash
    sudo apt install nvidia-driver-575
    sudo reboot
    ```

3. Build all components with build script

    ```bash
    ./build.sh
    ```

## Usage

Run a co-simulation with the co-simulation framework OpenMCx.
Choose one of the pre-defined system structure definitions in the `ssds` folder.

As a minimal example, run the `esmini-tracefilewriter` example.
It will load the German Highway Demo scenario from the ASAM OpenX Assets and store the simulation result as an ASAM OSI SensorView trace file.
This trace file will contain the ground truth moving objects including model references to ASAM OpenMATERIAL 3D asset files.

```bash
./tools/openmcx/install/openmcx ./ssds/esmini-tracefilewriter.ssd
```

For a more advanced example including a physical lidar model, run the `esmini-lidar_model-tracefilewriter` system structure definition.

```bash
./tools/openmcx/install/openmcx ./ssds/esmini-lidar_model-tracefilewriter.ssd
```
