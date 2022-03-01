function(get_all_targets var)
  set(targets)
  get_all_targets_recursive(targets ${CMAKE_CURRENT_SOURCE_DIR})
  set(${var} ${targets} PARENT_SCOPE)
endfunction()

macro(get_all_targets_recursive targets dir)
  get_property(subdirectories DIRECTORY ${dir} PROPERTY SUBDIRECTORIES)
  foreach(subdir ${subdirectories})
    get_all_targets_recursive(${targets} ${subdir})
  endforeach()

  get_property(current_targets DIRECTORY ${dir} PROPERTY BUILDSYSTEM_TARGETS)
  list(APPEND ${targets} ${current_targets})
endmacro()


function(configure_target_folders prefix)
  get_all_targets(all_targets)

  foreach(tgt ${all_targets})
    get_target_property(tgtsrc ${tgt} SOURCE_DIR)
    cmake_path(RELATIVE_PATH tgtsrc OUTPUT_VARIABLE tgtsrcrel)
    if(${tgtsrcrel} MATCHES "^${tgtsrc_re}.*")
      set_target_properties(${tgt} PROPERTIES
        FOLDER "external/${tgtsrcrel}"
	    )
    endif()
  endforeach()
endfunction()
