cmake_minimum_required(VERSION 3.16)
project(dso)

IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release)
ENDIF()

MESSAGE("Build type: " ${CMAKE_BUILD_TYPE})

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3 -march=native")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -O3 -march=native")
set(CMAKE_CXX_STANDARD 17)

set(SRCS_DSO
  src/FullSystem/FullSystem.cpp
  src/FullSystem/FullSystemOptimize.cpp
  src/FullSystem/FullSystemOptPoint.cpp
  src/FullSystem/FullSystemDebugStuff.cpp
  src/FullSystem/FullSystemMarginalize.cpp
  src/FullSystem/Residuals.cpp
  src/FullSystem/CoarseTracker.cpp
  src/FullSystem/CoarseInitializer.cpp
  src/FullSystem/ImmaturePoint.cpp
  src/FullSystem/HessianBlocks.cpp
  src/FullSystem/PixelSelector2.cpp
  src/OptimizationBackend/EnergyFunctional.cpp
  src/OptimizationBackend/AccumulatedTopHessian.cpp
  src/OptimizationBackend/AccumulatedSCHessian.cpp
  src/OptimizationBackend/EnergyFunctionalStructs.cpp
  src/util/settings.cpp
  src/util/Undistort.cpp
  src/util/globalCalib.cpp
  src/IOWrapper/Pangolin/KeyFrameDisplay.cpp
  src/IOWrapper/Pangolin/PangolinDSOViewer.cpp
  src/IOWrapper/OpenCV/ImageDisplay_OpenCV.cpp
  src/IOWrapper/OpenCV/ImageRW_OpenCV.cpp
)

find_package(OpenCV REQUIRED )
find_package(Eigen3  REQUIRED NO_MODULE)
find_package(Pangolin REQUIRED)
find_package(Boost COMPONENTS system thread)

# flags
add_definitions("-DENABLE_SSE")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SSE_FLAGS} -g")

if (MSVC)
	set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc")
endif (MSVC)


set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/lib)
add_library(${PROJECT_NAME} SHARED ${SRCS_DSO})

target_include_directories(${PROJECT_NAME} PUBLIC
        ${PROJECT_SOURCE_DIR}
        ${PROJECT_SOURCE_DIR}/src
        ${PROJECT_SOURCE_DIR}/src/FullSystem
        ${PROJECT_SOURCE_DIR}/src/util
        ${PROJECT_SOURCE_DIR}/src/OptimizationBackend
        ${PROJECT_SOURCE_DIR}/src/IOWrapper/OutputWrapper
        ${PROJECT_SOURCE_DIR}/src/IOWrapper/Pangolin
        ${PROJECT_SOURCE_DIR}/thirdparty/Sophus
        ${PROJECT_SOURCE_DIR}/thirdparty/sse2neon
)

target_link_libraries(${PROJECT_NAME}
        ${OpenCV_LIBRARIES}
        Eigen3::Eigen
	${Boost_LIBRARIES}
        pango_core
        pango_display
        pango_geometry
        pango_glgeometry
        pango_image
        pango_opengl
        pango_packetstream
        pango_plot
        pango_python
        pango_scene
        pango_tools
        pango_vars
        pango_video
        pango_windowing
)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

add_executable(mono src/main_dso_pangolin.cpp)
target_link_libraries(mono ${PROJECT_NAME})
