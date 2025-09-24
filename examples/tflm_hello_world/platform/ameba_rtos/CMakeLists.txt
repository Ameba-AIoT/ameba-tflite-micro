ameba_internal_library(example_tflm_hello_world)

set(example_dir
  ${CMAKE_CURRENT_SOURCE_DIR}/../..
)

target_sources(
    ${CURRENT_LIB_NAME} PRIVATE

    ${example_dir}/example_tflm_hello_world.cc
    ${example_dir}/models/hello_world_int8_model_data.cc
    ${example_dir}/models/hello_world_float_model_data.cc
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
