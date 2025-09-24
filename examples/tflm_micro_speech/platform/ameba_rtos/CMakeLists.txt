ameba_internal_library(example_tflm_micro_speech)

set(example_dir
  ${CMAKE_CURRENT_SOURCE_DIR}/../..
)

target_sources(
    ${CURRENT_LIB_NAME} PRIVATE

    ${example_dir}/testdata/no_1000ms_audio_data.cc
    ${example_dir}/testdata/yes_1000ms_audio_data.cc
    ${example_dir}/testdata/silence_1000ms_audio_data.cc
    ${example_dir}/testdata/no_30ms_audio_data.cc
    ${example_dir}/testdata/yes_30ms_audio_data.cc
    ${example_dir}/testdata/noise_1000ms_audio_data.cc
    ${example_dir}/example_tflm_micro_speech.cc
    ${example_dir}/models/audio_preprocessor_int8_model_data.cc
    ${example_dir}/models/micro_speech_quantized_model_data.cc

    app_example.c
)

target_include_directories(
    ${CURRENT_LIB_NAME} PRIVATE
    ${example_dir}
)

target_compile_options(
    ${CURRENT_LIB_NAME} PRIVATE
    -Wno-undef
    -Wno-unused-parameter
)

target_compile_definitions(
    ${CURRENT_LIB_NAME} PRIVATE
    TF_LITE_STATIC_MEMORY
)
