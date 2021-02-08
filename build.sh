#!/usr/bin/env bash
set -eo pipefail

# Source helper functions and variables.
. ./scripts/.environment
. ./scripts/helper.sh

function usage() {
   printf "Usage: $0 OPTION...
  -e DIR      Directory where LeoPays is installed. (Default: $HOME/leopays/X.Y)
  -c DIR      Directory where LeoPays.CDT is installed. (Default: $CDT_INSTALL_DIR_DEFAULT)
  -t          Build unit tests.
  -y          Noninteractive mode (Uses defaults for each prompt.)
  -h          Print this help menu.
   \\n" "$0" 1>&2
   exit 1
}

BUILD_TESTS=false

if [ $# -ne 0 ]; then
  while getopts "e:c:tyh" opt; do
    case "${opt}" in
      e )
        LEOPAYS_DIR_PROMPT=$OPTARG
      ;;
      c )
        CDT_DIR_PROMPT=$OPTARG
      ;;
      t )
        BUILD_TESTS=true
      ;;
      y )
        NONINTERACTIVE=true
        PROCEED=true
      ;;
      h )
        usage
      ;;
      ? )
        echo "Invalid Option!" 1>&2
        usage
      ;;
      : )
        echo "Invalid Option: -${OPTARG} requires an argument." 1>&2
        usage
      ;;
      * )
        usage
      ;;
    esac
  done
fi


if [[ ${BUILD_TESTS} == true ]]; then
   # Prompt user for location of LeoPays.
   leopays-directory-prompt
fi

# Prompt user for location of LeoPays.CDT.
cdt-directory-prompt

# Include CDT_INSTALL_DIR in CMAKE_FRAMEWORK_PATH
echo "Using LeoPays.CDT installation at: $CDT_INSTALL_DIR"
export CMAKE_FRAMEWORK_PATH="${CDT_INSTALL_DIR}:${CMAKE_FRAMEWORK_PATH}"

if [[ ${BUILD_TESTS} == true ]]; then
   # Ensure LeoPays version is appropriate.
   node-version-check

   # Include LEOPAYS_INSTALL_DIR in CMAKE_FRAMEWORK_PATH
   echo "Using LeoPays installation at: $LEOPAYS_INSTALL_DIR"
   export CMAKE_FRAMEWORK_PATH="${LEOPAYS_INSTALL_DIR}:${CMAKE_FRAMEWORK_PATH}"
fi

printf "\n========================== Building LeoPays.Contracts ==========================\n\n"
RED='\033[0;31m'
NC='\033[0m'
CPU_CORES=$(getconf _NPROCESSORS_ONLN)
mkdir -p build
pushd build &> /dev/null
cmake -DBUILD_TESTS=${BUILD_TESTS} ../
make -j $CPU_CORES
popd &> /dev/null
