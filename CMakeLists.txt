if (NOT DEFINED FFMPEG_CORE_NAME)
	set(FFMPEG_CORE_NAME ffmpeg)
endif()

add_library(${FFMPEG_CORE_NAME} INTERFACE)

target_include_directories(${FFMPEG_CORE_NAME} INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include")
if (WIN32 AND NOT MINGW)
	target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/windows/x86_64/avformat.lib"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/windows/x86_64/avcodec.lib"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/windows/x86_64/swscale.lib"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/windows/x86_64/avutil.lib"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/windows/x86_64/avfilter.lib"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/windows/x86_64/swresample.lib"
		"psapi;strmiids;uuid;oleaut32;shlwapi;ws2_32;ole32;user32;bcrypt")
elseif (APPLE)
	target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/macos/libavformat.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/macos/libavcodec.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/macos/libswscale.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/macos/libavutil.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/macos/libavfilter.a"
		"${CMAKE_CURRENT_SOURCE_DIR}/lib/macos/libswresample.a"
		"-framework CoreServices" "-framework CoreFoundation" "-framework AudioUnit"
		"-framework AudioToolbox" "-framework CoreAudio" "-framework CoreMedia"
		"-framework VideoToolbox" "-framework CoreVideo" "-framework Security")
elseif (UNIX)
	if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
		# Find the libavformat library
		find_library(LIBAVFORMAT_LIBRARY avformat)
		if(NOT LIBAVFORMAT_LIBRARY)
			message(FATAL_ERROR "libavformat library not found")
		endif()

		# Find the libavcodec library
		find_library(LIBAVCODEC_LIBRARY avcodec)
		if(NOT LIBAVCODEC_LIBRARY)
			message(FATAL_ERROR "libavcodec library not found")
		endif()

		# Find the libswscale library
		find_library(LIBSWSCALE_LIBRARY swscale)
		if(NOT LIBSWSCALE_LIBRARY)
			message(FATAL_ERROR "libswscale library not found")
		endif()

		# Find the libavutil library
		find_library(LIBAVUTIL_LIBRARY avutil)
		if(NOT LIBAVUTIL_LIBRARY)
			message(FATAL_ERROR "libavutil library not found")
		endif()

		# Find the libavfilter library
		find_library(LIBAVFILTER_LIBRARY avfilter)
		if(NOT LIBAVFILTER_LIBRARY)
			message(FATAL_ERROR "libavfilter library not found")
		endif()

		# Find the libswresample library
		find_library(LIBSWRESAMPLE_LIBRARY swresample)
		if(NOT LIBSWRESAMPLE_LIBRARY)
			message(FATAL_ERROR "libswresample library not found")
		endif()

		# Add specific settings for ARM architecture here
		target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
			${LIBAVFORMAT_LIBRARY}
			${LIBAVCODEC_LIBRARY}
			${LIBSWSCALE_LIBRARY}
			${LIBAVUTIL_LIBRARY}
			${LIBAVFILTER_LIBRARY}
			${LIBSWRESAMPLE_LIBRARY}
		)
	else()
	    target_link_libraries(${FFMPEG_CORE_NAME} INTERFACE
                "${CMAKE_CURRENT_SOURCE_DIR}/lib/linux/x86_64/libavformat.a"
                "${CMAKE_CURRENT_SOURCE_DIR}/lib/linux/x86_64/libavcodec.a"
                "${CMAKE_CURRENT_SOURCE_DIR}/lib/linux/x86_64/libswscale.a"
                "${CMAKE_CURRENT_SOURCE_DIR}/lib/linux/x86_64/libavutil.a"
                "${CMAKE_CURRENT_SOURCE_DIR}/lib/linux/x86_64/libavfilter.a"
                "${CMAKE_CURRENT_SOURCE_DIR}/lib/linux/x86_64/libswresample.a")
	endif()
else ()
	message(FATAL_ERROR "No prebuilt was found for ffmpeg")
endif ()
