cmake_minimum_required(VERSION 3.13)
project(micro_speech)

set(EXECUTABLE_NAME "micro_speech_test")
set(example_dir "${CMAKE_CURRENT_SOURCE_DIR}/../..")

file(GLOB example_srcs
    "${example_dir}/*.cc"
    "${example_dir}/models/*.cc"
    "${example_dir}/testdata/*.cc"
    "${example_dir}/platform/${CMAKE_CHIP_TARGET}/*.c")

add_executable(${EXECUTABLE_NAME} ${example_srcs})

target_include_directories(
    ${EXECUTABLE_NAME}
    PUBLIC
    ${example_dir}/.)

target_link_libraries(
    ${EXECUTABLE_NAME}
    ${MICROLITE_LIB_NAME})
