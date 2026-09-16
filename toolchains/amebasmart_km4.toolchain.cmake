set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

# Define the toolchain directory and SDK toolchain path
set(ToolChainVerMajor asdk-10.3.1)
set(ToolChainVerMinor 4602)
set(TOOLCHAIN_DIR /opt/rtk-toolchain/${ToolChainVerMajor}-${ToolChainVerMinor})
set(SDK_TOOLCHAIN ${TOOLCHAIN_DIR}/linux/newlib)


set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(TOOL_PREFIX arm-none-eabi-)
set(CMAKE_C_COMPILER    ${SDK_TOOLCHAIN}/bin/${TOOL_PREFIX}gcc)
set(CMAKE_CXX_COMPILER  ${SDK_TOOLCHAIN}/bin/${TOOL_PREFIX}g++)
set(CMAKE_RANLIB        ${SDK_TOOLCHAIN}/bin/${TOOL_PREFIX}ranlib)
set(CMAKE_AR            ${SDK_TOOLCHAIN}/bin/${TOOL_PREFIX}ar)

# AMEBASMART (RTL8730E) supports MVE (Helium) extension
set(ARCH_FLAGS          "-O2 -march=armv8.1-m.main+mve -mthumb -mcmse -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__FPU_PRESENT=1 -flax-vector-conversions -fno-tree-loop-distribute-patterns")
set(CMAKE_C_FLAGS       "${ARCH_FLAGS}" CACHE STRING "" FORCE )
set(CMAKE_CXX_FLAGS     "${ARCH_FLAGS}" CACHE STRING "" FORCE )
set(CMAKE_ASM_FLAGS     ${CMAKE_C_FLAGS} CACHE STRING "" FORCE )
set(CMAKE_LD_FLAGS      ${CMAKE_C_FLAGS} CACHE STRING "" FORCE )

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY )

set(CMAKE_C_ARCHIVE_CREATE "<CMAKE_AR> qcD <TARGET> <LINK_FLAGS> <OBJECTS>")
set(CMAKE_C_ARCHIVE_FINISH "<CMAKE_RANLIB> -D <TARGET>")
set(CMAKE_CXX_ARCHIVE_CREATE "<CMAKE_AR> qcD <TARGET> <LINK_FLAGS> <OBJECTS>")
set(CMAKE_CXX_ARCHIVE_FINISH "<CMAKE_RANLIB> -D <TARGET>")
