if (NOT DEFINED FFMPEG_CORE_NAME)
	set(FFMPEG_CORE_NAME ffmpeg)
endif()

add_library(${FFMPEG_CORE_NAME} INTERFACE)

target_include_directories(${FFMPEG_CORE_NAME} INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include")
if (WIN32)
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
	target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavformat.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavcodec.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libswscale.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavutil.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libavfilter.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/linux/x86_64/libswresample.a"
		"z")
endif()
