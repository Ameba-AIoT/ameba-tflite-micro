# MNIST Example

## Description

The *MNIST* database (Modified National Institute of Standards and Technology database) is a large collection of handwritten digits. 

More detailed documentation: [ameba-tflite-micro](https://aiot.realmcu.com/docs/en/latest/rst_ai/tflm/1_ai_tflm_toprst.html#)

## Supported IC
1. AmebaSmart CA32 (SDK: ameba-rtos)
2. AmebaLite KM4 (SDK: ameba-rtos)
3. AmebaDplus KM4 (SDK: ameba-rtos)
4. AmebaLite DSP (SDK: ameba-dsp)

## Build Example

### Using SDK ameba-rtos

- **Enable tflite_micro configurations**:

  cd amebaxxx_gcc_project and run```./menuconfig.py```

  < MENUCONFIG FOR XXXX CONFIG  --->

  < AI Config  --->
   [*]  Enable TFLITE MICRO

- **Build and Download**:
  * Refer to the SDK Examples section of the online documentation to generate images.
  * `Download` images to board by Ameba Image Tool.

### Using SDK ameba-dsp

#### Using SDK ameba-dsp with Xplorer

0. **build libtensorflow-microlite.a**

    ```
    cd lib/tflite_micro
    ./build/build_amebalite_dsp.sh
    ```

1. **import example_tflm_mnist in project_dsp/example**

2. **amend Build Properties for project dsp**

    *2.1 Add Include Paths*
    ```
    ${workspace_loc}/../example/tflite_micro/tflm_mnist
    ${workspace_loc}/../lib/tflite_micro
    ${workspace_loc}/../lib/tflite_micro/third_party
    ${workspace_loc}/../lib/tflite_micro/third_party/gemmlowp
    ${workspace_loc}/../lib/tflite_micro/third_party/flatbuffers/include
    ```
    *2.2 Add Symbols*
    ```TF_LITE_STATIC_MEMORY```

    *2.3 Update Language*
    ```
    language dialect: C++17 (only for tflm_mnist, but app_example.c excepted)
    Use new LLVM C++ library: libc++-re (only for tflm_mnist, but app_example.c excepted)
    ```

    *2.4 Libraries*

    2.4.1 Library Search Paths (-L)
    ```
    ${workspace_loc}/../lib/tflite_micro/amebalite_dsp-out/$(TARGET_CONFIG)
    ${workspace_loc}/../lib/xa_nnlib/v2.3.0/bin/$(TARGET_CONFIG)/Release
    ```
    2.4.2 Libraries(-l)
    ```
    tflite_micro
    xa_nnlib
    ```

#### Using SDK ameba-dsp with Command Line

0. **build libtensorflow-microlite.a**

    ```
    cd lib/tflite_micro
     ./build/build_amebalite_dsp.sh
    ```

1. **add all tflm dependencies and linked resources into project**

    ```
    ./examples/build_utils/ameba_dsp/add_all_settings_to_project.sh /path/to/project_dsp/ tflm_mnist
    ```
    this shell script inserts every dependencies and linked resources into `Release.bts` and `.project`.

2. **build dsp_all.bin**

    ```
    cd /path/to/ameba-dsp/project/auto_build/
    ./auto_build.sh
    ```
    
    binary image `dsp_all.bin` will be automatically generated under `/path/to/ameba-dsp/project/image/`.

    **NOTE: To build another example, please remove all added dependencies and linked resources from `Release.bts` and `.project`.**

### Expected Results

```
[TFLITE-MICRO] ~~~TESTS START~~~
[TFLITE-MICRO] model arena size = 16204
[TFLITE-MICRO] Accuracy: 100/100

"Unique Tag","Total ticks across all events with that tag."
CONV_2D, 29763
MAX_POOL_2D, 3422
RESHAPE, 339
FULLY_CONNECTED, 28897
"total number of ticks", 62421

[RecordingMicroAllocator] Arena allocation total 16204 bytes
[RecordingMicroAllocator] Arena allocation head 13968 bytes
[RecordingMicroAllocator] Arena allocation tail 2236 bytes
[RecordingMicroAllocator] 'TfLiteEvalTensor data' used 204 bytes with alignment overhead (requested 204 bytes for 17 allocations)
[RecordingMicroAllocator] 'Persistent TfLiteTensor data' used 80 bytes with alignment overhead (requested 80 bytes for 2 tensors)
[RecordingMicroAllocator] 'Persistent TfLiteTensor quantization data' used 40 bytes with alignment overhead (requested 40 bytes for 4 allocations)
[RecordingMicroAllocator] 'Persistent buffer data' used 1232 bytes with alignment overhead (requested 1148 bytes for 14 allocations)
[RecordingMicroAllocator] 'NodeAndRegistration struct' used 224 bytes with alignment overhead (requested 224 bytes for 7 NodeAndRegistration structs)

[TFLITE-MICRO] Total Time: 72.184998 ms

[TFLITE-MICRO] ~~~ALL TESTS PASSED~~~

```
Note: 

1. results of arena size, ProfileMemoryAndLatency are platform dependent.
2. in ameba-aiot, ticks in profile result actually represent as microseconds
