ameba_internal_library(example_tflm_mnist)

set(example_dir
  ${CMAKE_CURRENT_SOURCE_DIR}/../..
)

target_sources(
    ${CURRENT_LIB_NAME} PRIVATE

    ${example_dir}/testdata/input_int8_test_data.cc
    ${example_dir}/testdata/label_int8_test_data.cc
    ${example_dir}/example_tflm_mnist.cc
    ${example_dir}/models/model_int8_tflm_optimized_model_data.cc

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
