add_contract(lpc.wrap lpc.wrap ${CMAKE_CURRENT_SOURCE_DIR}/src/lpc.wrap.cpp)

target_include_directories(lpc.wrap
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(lpc.wrap
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/lpc.wrap.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/lpc.wrap.contracts.md @ONLY )

target_compile_options( lpc.wrap PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )
