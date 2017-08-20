INCLUDE(CMakeForceCompiler)

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
CMAKE_FORCE_C_COMPILER(D:/arm/bin/arm-none-eabi-gcc.exe GNU)
CMAKE_FORCE_CXX_COMPILER(D:/arm/bin/arm-none-eabi-g++.exe GNU)

SET(LINKER_SCRIPT ${PROJECT_SOURCE_DIR}/STM32L100RCTx_FLASH.ld)
SET(COMMON_FLAGS "-mcpu=cortex-m3 -O2 -mthumb -ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0")
SET(CMAKE_CXX_FLAGS_INIT "${COMMON_FLAGS} -std=c++11")
SET(CMAKE_C_FLAGS_INIT "${COMMON_FLAGS} -std=gnu99")
SET(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,-gc-sections -T ${LINKER_SCRIPT}")