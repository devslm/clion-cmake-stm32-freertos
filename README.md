# clion-cmake-stm32
Set up Clion with Cmake and FreeRTOS for cortex-m3 Stm32.
In Clion add Cmake option (Settings -> Build, Execution, Deployment -> Cmake) -DCMAKE_TOOLCHAIN_FILE=STM32L1xx.cmake.

The sequence to build project:
 - doing 'Reset Cache And Reload Project'
 - doing 'Reload Cmake Project'
 - then a successful build
In general, it was just enough to check the 'Automaticaly Reload Cmake Project on Edit' (Settings -> Build, Execution, Deployment -> Cmake) option and only rebuilding project.
