cmake_minimum_required (VERSION 2.6)

# make sure that the default is a RELEASE
if (NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE Release CACHE STRING
      "Choose the type of build, options are: Debug Release."
      FORCE)
endif (NOT CMAKE_BUILD_TYPE)

set(TGT "mc_LJ" CACHE STRING "The executable name.")

project(${TGT} C)

# list of include folders with .h files
include_directories(
include
dSFMT
/usr/local/include/luajit-2.0
#/home/hedin/bin/luajit_last/include/luajit-2.0
)

# list all source files
set(
SRCS
src/ener.c
src/io.c
src/logger.c
src/main.c
src/MCclassic.c
src/MCspav.c
src/memory.c
src/minim.c
src/parsing.c
src/plugins_lua.c
src/rand.c
src/tools.c
dSFMT/dSFMT.c
)

set(CMAKE_C_FLAGS_RELEASE "-std=c99 -Wall -Wextra -msse2 -fno-strict-aliasing -O2")
set(CMAKE_C_FLAGS_DEBUG   "-std=c99 -Wall -Wextra -msse2 -fno-strict-aliasing -O0 -g")

add_definitions(-DHAVE_SSE2 -DDSFMT_MEXP=19937 -DLUA_PLUGINS)
link_libraries(m rt dl luajit-5.1)
add_executable(${TGT} ${SRCS})

#target_link_libraries(${TGT} /home/hedin/bin/luajit_last/lib/libluajit-5.1.so)
#target_link_libraries(${TGT} /usr/local/include/luajit-2.0/libluajit-5.1.so)

