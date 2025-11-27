# Standardized Co-Simulation Demo

This repository demonstrates how to set up and run advanced co-simulation workflows for automotive and mobility applications using OpenMCx and esmini together with physical perception sensor models, while leveraging the ASAM OpenX standards for interoperability.

- **Co-Simulation Setup with OpenMCx**:
Learn how to configure and orchestrate multi-domain simulations using OpenMCx as the backbone for distributed simulation environments.

- **Integrating esmini**:
Explore how esmini, a lightweight OpenSCENARIO player, can be integrated into co-simulation setups for scenario execution and visualization using the FMI standard and ASAM OSI.

- **Showcasing ASAM OpenX Standards**
Understand how OpenDRIVE, OpenSCENARIO XML, OpenMATERIAL 3D, and OSI work together to create a consistent and standardized simulation ecosystem.
  - OpenDRIVE: Road network representation
  - OpenSCENARIO XML: Scenario definition and behavior modeling
  - OpenMATERIAL 3D: 3D geometries and material properties for realistic wavelength-dependent rendering
  - OSI (Open Simulation Interface): Sensor and environment data exchange

- **Physical Perception Sensor Simulation**:
Use sensor models (e.g., lidar, radar, camera) as functional mock-up units with standardized interfaces for perception testing and validation in virtual environments.

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
  
  - When using a sensor model: An Nvidia RTX GPU with an Nvidia driver >= 535 is required

3. Build all components with build script

    ```bash
    ./build.sh
    ```

4. Create a symlink to /opt. This will make file handling a lot easier, since absolute paths can be used instead of relative paths.

    ```bash
    ln -s $(pwd) /opt/standardized-co-simulation-demo
    ```
   
    Depending on your system configuration, you might need to use `sudo` for this command.

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
./tools/openmcx/install/openmcx ./ssds/esmini-lidar_32layer-tracefilewriter.ssd
```

The resulting ASAM OSI trace files will be written to the `./simulation_output` folder by default.
This can be changed by modifying the `trace_path` parameter of the sl-5-6-osi-trace-file-writer fmu in the respective ssd file.

## Visualize the Simulated Data

For visualizing the generated ASAM OSI trace files in combination with the entire 3D environment in ASAM OpenMATERIAL 3D format, we recommend to use the Persival Simspector.
You can download a free 30-day trial version from the Persival website: https://www.persival.de/simspector.

<img src="doc/images/Simspector.png" alt="Simspector" width="800">
