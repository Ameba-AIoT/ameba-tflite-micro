# TensorFlow Lite Micro for Ameba SoCs

## Overview

TensorFlow Lite for Microcontrollers is a port of TensorFlow Lite designed to run machine learning models on DSPs, microcontrollers and other devices with limited memory.

This repository is a version of the [TensorFlow Lite Micro library](https://www.tensorflow.org/lite/microcontrollers) for Realtek Ameba SoCs. 

Note that this repository is not recommended for standalone use. Please use it with SDK ([ameba-rtos](https://github.com/Ameba-AIoT/ameba-rtos) or [ameba-dsp](https://github.com/Ameba-AIoT/ameba-dsp)) based on the chosen SoC.

Documentation: [ameba-tflite-micro](https://aiot.realmcu.com/docs/cn/latest/rst_ai/tflm/1_ai_tflm_toprst.html)

### Supported SoCs

| Chip       | OS   | Processor |         master         | SDK link                                               |
| :--------- | ---- | --------- | :--------------------: | ------------------------------------------------------ |
| AmebaSmart | RTOS | CA32      | ![alt text][supported] | [ameba-rtos](https://github.com/Ameba-AIoT/ameba-rtos) |
| AmebaLite  | RTOS | HiFi5 DSP | ![alt text][supported] | [ameba-dsp](https://github.com/Ameba-AIoT/ameba-dsp)   |
| AmebaLite  | RTOS | KM4       | ![alt text][supported] | [ameba-rtos](https://github.com/Ameba-AIoT/ameba-rtos) |
| AmebaDplus | RTOS | KM4       | ![alt text][supported] | [ameba-rtos](https://github.com/Ameba-AIoT/ameba-rtos) |

[supported]: https://img.shields.io/badge/-supported-green "supported"

## Getting Started

### Build Tensorflow Lite Micro Library and Example

- ameba-rtos

  - Step 1. Enable tflite_micro by menuconfig.py in gcc_project directory

  - Step 2. Build library with example

    Run script ./build.py -a {example_name}

- ameba-dsp

  - Step 1. Build library

    Run script build/build_amebalite_dsp.sh

  - Step 2. Build example (support both Xplorer and command line)

    Refer to examples/{example_name}/README.md for details.

## Version Sync

This repository has been automatically generated from the master TensorFlow Lite for Microcontrollers repository at https://github.com/tensorflow/tflite-micro.

To sync to the latest tflite-micro and create a ameba SoCs compatible project, you can run the script:

```
sync/sync_from_tflite_micro.sh
```

## License

This repository is provided under Apache 2.0 license, see [LICENSE](LICENSE) file for details.

TensorFlow library source code and third_party code contain their own licenses specified under respective repos.
