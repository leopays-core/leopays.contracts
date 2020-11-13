add_contract(lpc.msig lpc.msig ${CMAKE_CURRENT_SOURCE_DIR}/src/lpc.msig.cpp)

target_include_directories(lpc.msig
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(lpc.msig
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/lpc.msig.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/lpc.msig.contracts.md @ONLY )

target_compile_options( lpc.msig PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )
