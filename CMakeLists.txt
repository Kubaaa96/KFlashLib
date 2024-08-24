cmake_minimum_required(VERSION 3.20)

include(FetchContent)
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

# Add project_options from https://github.com/aminya/project_options
# Change the version in the following URL to update the package (watch the releases of the repository for future updates)
set(PROJECT_OPTIONS_VERSION "v0.36.1")
FetchContent_Declare(
        _project_options
        URL https://github.com/aminya/project_options/archive/refs/tags/${PROJECT_OPTIONS_VERSION}.zip)
FetchContent_MakeAvailable(_project_options)
include(${_project_options_SOURCE_DIR}/Index.cmake)

run_conan(
        HOST_PROFILE default auto-cmake
        BUILD_PROFILE default
        INSTALL_ARGS --build=missing
)

project(cpp-template VERSION 0.0.3 DESCRIPTION "Basic template project for C++ language" LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 20)

set(ENABLE_CLANG_TIDY "ENABLE_CLANG_TIDY")
set(ENABLE_CPPCHECK "ENABLE_CPPCHECK")

project_options(
        PREFIX "cpptemplate"
        ENABLE_CACHE
        ${ENABLE_CPPCHECK}
        ${ENABLE_CLANG_TIDY}
         WARNINGS_AS_ERRORS
)

add_executable(${PROJECT_NAME} src/Example.cpp src/main.cpp)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(${PROJECT_NAME}
        PRIVATE cpptemplate_project_options cpptemplate_project_warnings
)

target_find_dependencies(${PROJECT_NAME}
        PRIVATE_CONFIG
        fmt
)

target_link_system_libraries(${PROJECT_NAME}
        PRIVATE
        fmt::fmt
)

if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    message(STATUS "Testing enabled")
    enable_testing()
    include(GoogleTest)
    add_subdirectory(test)
endif ()