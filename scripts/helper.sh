# Ensures passed in version values are supported.
function check-version-numbers() {
  CHECK_VERSION_MAJOR=$1
  CHECK_VERSION_MINOR=$2

  if [[ $CHECK_VERSION_MAJOR -lt $LEOPAYS_MIN_VERSION_MAJOR ]]; then
    exit 1
  fi
  if [[ $CHECK_VERSION_MAJOR -gt $LEOPAYS_MAX_VERSION_MAJOR ]]; then
    exit 1
  fi
  if [[ $CHECK_VERSION_MAJOR -eq $LEOPAYS_MIN_VERSION_MAJOR ]]; then
    if [[ $CHECK_VERSION_MINOR -lt $LEOPAYS_MIN_VERSION_MINOR ]]; then
      exit 1
    fi
  fi
  if [[ $CHECK_VERSION_MAJOR -eq $LEOPAYS_MAX_VERSION_MAJOR ]]; then
    if [[ $CHECK_VERSION_MINOR -gt $LEOPAYS_MAX_VERSION_MINOR ]]; then
      exit 1
    fi
  fi
  exit 0
}


# Handles choosing which LeoPays directory to select when the default location is used.
function default-leopays-directories() {
  REGEX='^[0-9]+([.][0-9]+)?$'
  ALL_LEOPAYS_SUBDIRS=()
  if [[ -d ${HOME}/leopays ]]; then
    ALL_LEOPAYS_SUBDIRS=($(ls ${HOME}/leopays | sort -V))
  fi
  for ITEM in "${ALL_LEOPAYS_SUBDIRS[@]}"; do
    if [[ "$ITEM" =~ $REGEX ]]; then
      DIR_MAJOR=$(echo $ITEM | cut -f1 -d '.')
      DIR_MINOR=$(echo $ITEM | cut -f2 -d '.')
      if $(check-version-numbers $DIR_MAJOR $DIR_MINOR); then
        PROMPT_LEOPAYS_DIRS+=($ITEM)
      fi
    fi
  done
  for ITEM in "${PROMPT_LEOPAYS_DIRS[@]}"; do
    if [[ "$ITEM" =~ $REGEX ]]; then
      LEOPAYS_VERSION=$ITEM
    fi
  done
}


# Prompts or sets default behavior for choosing LeoPays directory.
function leopays-directory-prompt() {
  if [[ -z $LEOPAYS_DIR_PROMPT ]]; then
    default-leopays-directories;
    echo 'No LeoPays location was specified.'
    while true; do
      if [[ $NONINTERACTIVE != true ]]; then
        if [[ -z $LEOPAYS_VERSION ]]; then
          echo "No default LeoPays installations detected..."
          PROCEED=n
        else
          printf "Is LeoPays installed in the default location: $CDT_INSTALL_DIR_DEFAULT (y/n)" && read -p " " PROCEED
        fi
      fi
      echo ""
      case $PROCEED in
        "" )
          echo "Is LeoPays installed in the default location?";;
        0 | true | [Yy]* )
          break;;
        1 | false | [Nn]* )
          if [[ $PROMPT_LEOPAYS_DIRS ]]; then
            echo "Found these compatible LeoPays versions in the default location."
            printf "$HOME/leopays/%s\n" "${PROMPT_LEOPAYS_DIRS[@]}"
          fi
          printf "Enter the installation location of LeoPays:" && read -e -p " " LEOPAYS_DIR_PROMPT;
          LEOPAYS_DIR_PROMPT="${LEOPAYS_DIR_PROMPT/#\~/$HOME}"
          break;;
        * )
          echo "Please type 'y' for yes or 'n' for no.";;
      esac
    done
  fi
  export CDT_INSTALL_DIR="${CDT_DIR_PROMPT:-$CDT_INSTALL_DIR_DEFAULT}"
}


# Prompts or default behavior for choosing LeoPays.CDT directory.
function cdt-directory-prompt() {
  if [[ -z $CDT_DIR_PROMPT ]]; then
    echo 'No LeoPays.CDT location was specified.'
    while true; do
      if [[ $NONINTERACTIVE != true ]]; then
        printf "Is LeoPays.CDT installed in the default location? /usr/local/leopays.cdt (y/n)" && read -p " " PROCEED
      fi
      echo ""
      case $PROCEED in
        "" )
          echo "Is LeoPays.CDT installed in the default location?";;
        0 | true | [Yy]* )
          break;;
        1 | false | [Nn]* )
          printf "Enter the installation location of LeoPays.CDT:" && read -e -p " " CDT_DIR_PROMPT;
          CDT_DIR_PROMPT="${CDT_DIR_PROMPT/#\~/$HOME}"
          break;;
        * )
          echo "Please type 'y' for yes or 'n' for no.";;
      esac
    done
  fi
  export CDT_INSTALL_DIR="${CDT_DIR_PROMPT:-/usr/local/leopays.cdt}"
}


# Ensures LeoPays is installed and compatible via version listed in tests/CMakeLists.txt.
function node-version-check() {
  INSTALLED_VERSION=$(echo $($LEOPAYS_INSTALL_DIR/bin/node --version))
  INSTALLED_VERSION_MAJOR=$(echo $INSTALLED_VERSION | cut -f1 -d '.' | sed 's/v//g')
  INSTALLED_VERSION_MINOR=$(echo $INSTALLED_VERSION | cut -f2 -d '.' | sed 's/v//g')

  if [[ -z $INSTALLED_VERSION_MAJOR || -z $INSTALLED_VERSION_MINOR ]]; then
    echo "Could not determine LeoPays version. Exiting..."
    exit 1;
  fi

  if $(check-version-numbers $INSTALLED_VERSION_MAJOR $INSTALLED_VERSION_MINOR); then
    if [[ $INSTALLED_VERSION_MAJOR -gt $LEOPAYS_SOFT_MAX_MAJOR ]]; then
      echo "Detected LeoPays version is greater than recommended soft max: $LEOPAYS_SOFT_MAX_MAJOR.$LEOPAYS_SOFT_MAX_MINOR. Proceed with caution."
    fi
    if [[ $INSTALLED_VERSION_MAJOR -eq $LEOPAYS_SOFT_MAX_MAJOR && $INSTALLED_VERSION_MINOR -gt $LEOPAYS_SOFT_MAX_MINOR ]]; then
      echo "Detected LeoPays version is greater than recommended soft max: $LEOPAYS_SOFT_MAX_MAJOR.$LEOPAYS_SOFT_MAX_MINOR. Proceed with caution."
    fi
  else
    echo "Supported versions are: $LEOPAYS_MIN_VERSION_MAJOR.$LEOPAYS_MIN_VERSION_MINOR - $LEOPAYS_MAX_VERSION_MAJOR.$LEOPAYS_MAX_VERSION_MINOR"
    echo "Invalid LeoPays installation. Exiting..."
    exit 1;
  fi
}
