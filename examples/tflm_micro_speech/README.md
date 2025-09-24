# Micro Speech Example

## Description

This example shows how to run inference using TensorFlow Lite Micro (TFLM) on two models for wake-word recognition. The first model is an audio preprocessor that generates spectrogram data from raw audio samples. The second is the Micro Speech model, a less than 20 kB model that can recognize 2 keywords, "yes" and "no", from speech data. The Micro Speech model takes the spectrogram data as input and produces category probabilities.
For more details, please refer to [TensorFlow Lite for Microcontrollers](https://github.com/tensorflow/tflite-micro/blob/main/tensorflow/lite/micro/examples/micro_speech/README.md)

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

1. **import example_micro_speech in project_dsp/example**

2. **amend Build Properties for project dsp**

    *2.1 Add Include Paths*
    ```
    ${workspace_loc}/../example/tflite_micro/tflm_micro_speech
    ${workspace_loc}/../lib/tflite_micro
    ${workspace_loc}/../lib/tflite_micro/third_party/gemmlowp
    ${workspace_loc}/../lib/tflite_micro/third_party/flatbuffers/include
    ```

    *2.2 Add Symbols*
    ```TF_LITE_STATIC_MEMORY```

    *2.3 Update Language*
    ```
    language dialect: C++17 (app_example.c excepted)
    Use new LLVM C++ library: libc++-re (app_example.c excepted)
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

    run ```./lib/tflite_micro/build/build_amebalite_dsp.sh```

1. **add all tflm dependencies and linked resources into project**

    ```sh
    ./add_all_settings_to_project.sh /path/to/project_dsp/ tflm_micro_speech
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

**tflm_micro_speech**

```
Testing NoFeatureTest
AudioPreprocessor model arena size = 8440
Testing YesFeatureTest
AudioPreprocessor model arena size = 8440
Testing NoTest
AudioPreprocessor model arena size = 8440
MicroSpeech model arena size = 6812
MicroSpeech category predictions for <no>
  0.0000 silence
  0.0547 unknown
  0.0000 yes
  0.9453 no
Testing YesTest
AudioPreprocessor model arena size = 8440
MicroSpeech model arena size = 6812
MicroSpeech category predictions for <yes>
  0.0000 silence
  0.0000 unknown
  0.9961 yes
  0.0000 no
Testing SilenceTest
AudioPreprocessor model arena size = 8440
MicroSpeech model arena size = 6812
MicroSpeech category predictions for <silence>
  0.3359 silence
  0.2344 unknown
  0.2344 yes
  0.1953 no
Testing NoiseTest
AudioPreprocessor model arena size = 8440
MicroSpeech model arena size = 6812
MicroSpeech category predictions for <silence>
  0.9688 silence
  0.0117 unknown
  0.0078 yes
  0.0117 no
6/6 tests passed
~~~ALL TESTS PASSED~~~
```