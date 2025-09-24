# Hello World Example

## Description

This example is designed to demonstrate the absolute basics of using [TensorFlow
Lite for Microcontrollers](https://www.tensorflow.org/lite/microcontrollers).
It includes a pre-trained model, and converting it for use with TensorFlow Lite
for Microcontrollers for running inference on a microcontroller.

## Supported IC <a name = "supported-ic"></a>

1. AmebaSmart CA32 (SDK: ameba-rtos)
2. AmebaLite KM4 (SDK: ameba-rtos)
3. AmebaDplus KM4 (SDK: ameba-rtos)
4. AmebaLite DSP (SDK: ameba-dsp)

## Build Example

### Using SDK ameba-rtos

1. **Enable tflite_micro configurations**:

    cd amebaxxx_gcc_project and run```./menuconfig.py```

    < MENUCONFIG FOR KM4 CONFIG  --->
    < Audio Config  --->
    [*]  Enable TFLITE MICRO

2. **Build and Download**:

   * Refer to the SDK Examples section of the online documentation to generate images.
   * `Download` images to board by Ameba Image Tool.

### Using SDK ameba-dsp

#### Using SDK ameba-dsp with Xplorer

0. **build libtensorflow-microlite.a**

    run ```./lib/tflite_micro/build/build_amebalite_dsp.sh```

1. **import example tflm_micro_speech in project_dsp/example**

2. **amend Build Properties for project dsp**

    *2.1 Add Include Paths*
    ```
    ${workspace_loc}/../example/tflite_micro/tflm_hello_world
    ${workspace_loc}/../lib/tflite_micro
    ${workspace_loc}/../lib/tflite_micro/third_party/gemmlowp
    ${workspace_loc}/../lib/tflite_micro/third_party/flatbuffers/include
    ```

    *2.2 Add Symbols*
    ```TF_LITE_STATIC_MEMORY```

    *2.3 Update Language*
    ```
    language dialect: C++17 (only for tflm_hello_world, but app_example.c excepted)
    Use new LLVM C++ library: libc++-re (only for tflm_hello_world, but app_example.c excepted)
    ```

    *2.4 Libraries*
    2.4.1 Library Search Paths (-L)
    ```
    ${workspace_loc}/../lib/tflite_micro/amebalite_dsp-out/$(TARGET_CONFIG)
    ```

    2.4.2 Libraries(-l)
    ```
    tflite_micro
    ```

#### Using SDK ameba-dsp with Command Line

0. **build libtensorflow-microlite.a**

    run ```./lib/tflite_micro/build/build_amebalite_dsp.sh```

1. **add all tflm dependencies and linked resources into project**

    ```sh
    ./add_all_settings_to_project.sh /path/to/project_dsp/ tflm_hello_world
    ```

    this shell script inserts every dependencies and linked resources into `Release.bts` and `.project`.

2. **build dsp_all.bin**

    ```sh
    cd dsp/source/project/auto_build/
    ./auto_build.sh
    ```

    binary image `dsp_all.bin` will be automatically generated under `dsp/source/project/image/`.

    **NOTE: To build another example, please remove all added dependencies and linked resources from `Release.bts` and `.project`.**

## Expected Result

**tflm_hello_world**

```
ProfileMemoryAndLatency
"Unique Tag","Total ticks across all events with that tag."
FULLY_CONNECTED, 103
"total number of ticks", 103

[RecordingMicroAllocator] Arena allocation total 1400 bytes
[RecordingMicroAllocator] Arena allocation head 136 bytes
[RecordingMicroAllocator] Arena allocation tail 1264 bytes
[RecordingMicroAllocator] 'TfLiteEvalTensor data' used 120 bytes with alignment overhead (requested 120 bytes for 10 allocations)
[RecordingMicroAllocator] 'Persistent TfLiteTensor data' used 64 bytes with alignment overhead (requested 64 bytes for 2 tensors)
[RecordingMicroAllocator] 'Persistent buffer data' used 733 bytes with alignment overhead (requested 692 bytes for 7 allocations)
[RecordingMicroAllocator] 'NodeAndRegistration struct' used 96 bytes with alignment overhead (requested 96 bytes for 3 NodeAndRegistration structs)

LoadFloatModelAndPerformInference
x: 0.000000, y: 0.026405
x: 1.000000, y: 0.863044
x: 3.000000, y: 0.127646
x: 5.000000, y: -0.956519

LoadQuantModelAndPerformInference
x: 0.770000, y: 0.696440
x: 1.570000, y: 0.994915
x: 2.300000, y: 0.729604
x: 3.140000, y: -0.008291

~~~ALL TESTS PASSED~~~
```

**Note:**

1. results of ProfileMemoryAndLatency are platform dependent.
2. in ameba-aiot, ticks in profile result actually represent as microseconds
