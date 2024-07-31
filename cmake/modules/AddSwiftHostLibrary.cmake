# This source file is part of the Swift.org open source project
#
# Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See http://swift.org/LICENSE.txt for license information
# See http://swift.org/CONTRIBUTORS.txt for Swift project authors

function(target_link_swift_syntax_libraries TARGET)
  cmake_parse_arguments(ARGS "PUBLIC;PRIVATE;INTERFACE" "" "" ${ARGN})
  set(link_type)
  if(ARGS_PUBLIC)
    set(link_type PUBLIC)
  elseif(ARGS_PRIVATE)
    set(link_type PRIVATE)
  elseif(ARGS_INTERFACE)
    set(link_type INTERFACE)
  endif()

  string(PREPEND TARGET ${SWIFTSYNTAX_TARGET_NAMESPACE})
  list(TRANSFORM ARGS_UNPARSED_ARGUMENTS PREPEND "${SWIFTSYNTAX_TARGET_NAMESPACE}" OUTPUT_VARIABLE dependencies)

  target_link_libraries(${TARGET} ${link_type} ${dependencies})

  # cmake generation for Swift adds an order only dependency, which matches how C-family languages
  # works. In that case, however, ninja (and presumably other generators) will rebuild on header
  # changes. That's not the case for Swift, and thus if A -> B, A is not being rebuilt when the
  # ABI/API of B changes.
  #
  # For now workaround this by touching a file whenever B is rebuilt and then compiling that file as
  # part of A. Ideally this file would be generated by each of the targets, but that dependency didn't
  # seem to be being tracked.
  #
  # Remove once rdar://102202478 is fixed.
  foreach(DEPENDENCY ${dependencies})
    string(REGEX REPLACE [<>:\"/\\|?*] _ sanitized ${DEPENDENCY})
    add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/forced-${sanitized}-dep.swift
      COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/forced-${sanitized}-dep.swift
      DEPENDS ${DEPENDENCY}
    )
    target_sources(${TARGET} PRIVATE
      ${CMAKE_CURRENT_BINARY_DIR}/forced-${sanitized}-dep.swift
    )
  endforeach()
endfunction()

# Add a new host library with the given name.
function(add_swift_syntax_library name)
  set(ASHL_SOURCES ${ARGN})

  set(target ${SWIFTSYNTAX_TARGET_NAMESPACE}${name})

  # Create the library target.
  add_library(${target} ${ASHL_SOURCES})

  if(SWIFTSYNTAX_EMIT_MODULE)
    # Determine where Swift modules will be built and installed.
    set(module_dir ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(module_base "${module_dir}/${name}.swiftmodule")
    set(module_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftmodule")
    set(module_interface_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftinterface")
    set(module_private_interface_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.private.swiftinterface")
    set(module_sourceinfo_file "${module_base}/${SWIFT_HOST_MODULE_TRIPLE}.swiftsourceinfo")

    # Add a custom target to create the module directory.
    add_custom_command(
      TARGET ${target}
      PRE_BUILD
      COMMAND "${CMAKE_COMMAND}" -E make_directory ${module_base}
      COMMENT "Generating module directory for ${target}")

    # Configure the emission of the Swift module files.
    target_compile_options("${target}" PRIVATE
      $<$<COMPILE_LANGUAGE:Swift>:
        -DRESILIENT_LIBRARIES;
        -enable-library-evolution;
        -emit-module-path;${module_file};
        -emit-module-source-info-path;${module_sourceinfo_file};
        -emit-module-interface-path;${module_interface_file};
        -emit-private-module-interface-path;${module_private_interface_file}
    >)

    # Enable package CMO if possible.
    if(SWIFT_PACKAGE_CMO_SUPPORT STREQUAL "IMPLEMENTED")
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-package-name ${SWIFT_MODULE_ABI_NAME_PREFIX}${PROJECT_NAME}"
          "SHELL:-Xfrontend -package-cmo"
          "SHELL:-Xfrontend -allow-non-resilient-access"
      >)
    elseif(SWIFT_PACKAGE_CMO_SUPPORT STREQUAL "EXPERIMENTAL")
      target_compile_options("${target}" PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:
          "SHELL:-package-name ${SWIFT_MODULE_ABI_NAME_PREFIX}${PROJECT_NAME}"
          "SHELL:-Xfrontend -experimental-package-cmo"
          "SHELL:-Xfrontend -experimental-allow-non-resilient-access"
          "SHELL:-Xfrontend -experimental-package-bypass-resilience"
      >)
    endif()

  else()
    set(module_dir ${CMAKE_CURRENT_BINARY_DIR})
    set(module_base "${module_dir}/${name}.swiftmodule")
    set(module_file "${module_file}")
  endif()

  # Touch the library and objects to workaround their mtime not being updated
  # when there are no real changes (eg. a file was updated with a comment).
  # Ideally this should be done in the driver, which could only update the
  # files that have changed.
  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND "${CMAKE_COMMAND}" -E touch_nocreate $<TARGET_FILE:${target}> "${module_base}"
    COMMAND_EXPAND_LISTS
    COMMENT "Update mtime of library outputs workaround")
  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND "${CMAKE_COMMAND}" -E touch_nocreate $<TARGET_OBJECTS:${target}>
    COMMAND_EXPAND_LISTS
    COMMENT "Update mtime of objcect files workaround")

  set_target_properties(${target} PROPERTIES
    Swift_MODULE_NAME ${name}
    Swift_MODULE_DIRECTORY ${module_dir}
    INTERFACE_INCLUDE_DIRECTORIES ${module_dir}
  )

  # Configure the emission of the Swift module files.
  target_compile_options("${target}" PRIVATE
    $<$<COMPILE_LANGUAGE:Swift>:
      "SHELL:-module-name ${name}"
      "SHELL:-Xfrontend -module-abi-name -Xfrontend ${SWIFT_MODULE_ABI_NAME_PREFIX}${name}"
    >)

  if(CMAKE_VERSION VERSION_LESS 3.26.0 AND SWIFT_SYNTAX_ENABLE_WMO_PRE_3_26)
    target_compile_options(${target} PRIVATE
        $<$<COMPILE_LANGUAGE:Swift>:-wmo>)
  endif()

  target_compile_options(${target} PRIVATE
    $<$<COMPILE_LANGUAGE:Swift>:-color-diagnostics>
  )

  if(LLVM_USE_LINKER)
    target_link_options(${target} PRIVATE
      "-use-ld=${LLVM_USE_LINKER}"
    )
  endif()

  # NOTE: workaround for CMake not setting up include flags yet
  set_target_properties(${target} PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES ${module_dir}
  )

  set_target_properties(${target} PROPERTIES
    BUILD_WITH_INSTALL_RPATH YES
  )

  if(SWIFT_HOST_LIBRARIES_RPATH)
    # Don't add builder's stdlib RPATH automatically.
    target_compile_options(${target} PRIVATE -no-toolchain-stdlib-rpath)
    set_property(TARGET ${target}
      PROPERTY INSTALL_RPATH "${SWIFT_HOST_LIBRARIES_RPATH}"
    )
  endif()

  get_target_property(lib_type ${target} TYPE)
  if(lib_type STREQUAL SHARED_LIBRARY)
    if (CMAKE_SYSTEM_NAME STREQUAL Darwin)
      # Allow install_name_tool to update paths (for rdar://109473564)
      set_property(TARGET ${target} APPEND_STRING PROPERTY
                   LINK_FLAGS " -Xlinker -headerpad_max_install_names")
    endif()
  endif()

  if(PROJECT_IS_TOP_LEVEL OR SWIFT_SYNTAX_INSTALL_TARGETS)
    # Install this target
    install(TARGETS ${target}
      EXPORT SwiftSyntaxTargets
      ARCHIVE DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
      LIBRARY DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
      RUNTIME DESTINATION bin
    )

    # Install the module files.
    install(
      DIRECTORY ${module_base}
      DESTINATION lib/${SWIFT_HOST_LIBRARIES_SUBDIRECTORY}
      FILES_MATCHING PATTERN "*.swiftinterface"
    )
  else()
    set_property(GLOBAL APPEND PROPERTY SWIFT_EXPORTS ${target})
  endif()
  add_library(SwiftSyntax::${target} ALIAS ${target})
endfunction()
