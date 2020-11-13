add_contract(lpc.token lpc.token ${CMAKE_CURRENT_SOURCE_DIR}/src/lpc.token.cpp)

target_include_directories(lpc.token
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(lpc.token
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/lpc.token.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/lpc.token.contracts.md @ONLY )

target_compile_options( lpc.token PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )
