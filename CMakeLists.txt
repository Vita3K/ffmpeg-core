if (NOT DEFINED FFMPEG_CORE_NAME)
	set(FFMPEG_CORE_NAME ffmpeg)
endif()

option(USE_SYSTEM_FFMPEG "Dynamically link against system ffmpeg" OFF)

add_library(${FFMPEG_CORE_NAME} INTERFACE)

target_include_directories(${FFMPEG_CORE_NAME} INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include")
if(NOT USE_SYSTEM_FFMPEG)
	if (WIN32 AND NOT MINGW)
		target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
			"${CMAKE_CURRENT_SOURCE_DIR}/windows/x86_64/avformat.lib"
			"${CMAKE_CURRENT_SOURCE_DIR}/windows/x86_64/avcodec.lib"
			"${CMAKE_CURRENT_SOURCE_DIR}/windows/x86_64/swscale.lib"
			"${CMAKE_CURRENT_SOURCE_DIR}/windows/x86_64/avutil.lib"
			"${CMAKE_CURRENT_SOURCE_DIR}/windows/x86_64/avfilter.lib"
			"${CMAKE_CURRENT_SOURCE_DIR}/windows/x86_64/swresample.lib"
			"Bcrypt.lib")
	elseif (APPLE)
		target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
			"${CMAKE_CURRENT_SOURCE_DIR}/macos/x86_64/libavformat.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/macos/x86_64/libavcodec.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/macos/x86_64/libswscale.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/macos/x86_64/libavutil.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/macos/x86_64/libavfilter.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/macos/x86_64/libswresample.a"
			"z")
        elseif (UNIX)
		if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "(amd64)|(AMD64)|(x86_64)")
			target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavformat.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavcodec.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libswscale.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavutil.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavfilter.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libswresample.a"
			"z")
                  
		elseif (${CMAKE_SYSTEM_PROCESSOR} MATCHES "(^aarch64)")
		target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/aarch64/libavformat.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/aarch64/libavcodec.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/aarch64/libswscale.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/aarch64/libavutil.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/aarch64/libavfilter.a"
			"${CMAKE_CURRENT_SOURCE_DIR}/linux/aarch64/libswresample.a"
			"z")
                endif ()
	else ()
		set(USE_SYSTEM_FFMPEG ON)
	endif ()
endif()

if (USE_SYSTEM_FFMPEG)
	find_package(PkgConfig REQUIRED)
	pkg_check_modules(FFMPEG REQUIRED IMPORTED_TARGET libavcodec libavfilter libavformat libavutil libswscale libswresample)
	target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE "${FFMPEG_LIBRARIES}")
	target_include_directories(${FFMPEG_CORE_NAME} INTERFACE "${FFMPEG_INCLUDE_DIRS}")
endif ()
