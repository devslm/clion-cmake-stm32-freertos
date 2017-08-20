project(Skeleton C CXX ASM)
cmake_minimum_required(VERSION 3.5.0)

add_definitions(-DSTM32L100xC)

set(FREERTOS_DIR Middlewares/Third_Party/FreeRTOS/Source/)

file(GLOB_RECURSE USER_SOURCES "Src/*.c")
file(GLOB_RECURSE HAL_SOURCES "Drivers/STM32L1xx_HAL_Driver/Src/*.c")
file(
    GLOB_RECURSE
    FREERTOS_SOURCES
    "${FREERTOS_DIR}/*.c"
    "${FREERTOS_DIR}/CMSIS_RTOS/*.c"
    "${FREERTOS_DIR}/portable/GCC/ARM_CM3/*.c"
)

add_library(
    CMSIS
    Src/system_stm32l1xx.c
    startup/startup_stm32l100xc.s
)

include_directories(Inc)
include_directories(Src/gps/parser/nmea)
include_directories(Drivers/STM32L1xx_HAL_Driver/Inc)
include_directories(Drivers/CMSIS/Include)
include_directories(Drivers/CMSIS/Device/ST/STM32L1xx/Include)

include_directories(${FREERTOS_DIR})
include_directories(${FREERTOS_DIR}/CMSIS_RTOS)
include_directories(${FREERTOS_DIR}/include)
include_directories(${FREERTOS_DIR}/portable/GCC/ARM_CM3/)
include_directories(${FREERTOS_DIR}/portable/GCC/MemMang)

add_executable(${PROJECT_NAME}.elf ${USER_SOURCES} ${HAL_SOURCES} ${LINKER_SCRIPT} ${FREERTOS_SOURCES} Src/gps/parser/nmea/NmeaParser.cpp)

target_link_libraries(${PROJECT_NAME}.elf CMSIS)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Map=${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.map")
set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin)
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")