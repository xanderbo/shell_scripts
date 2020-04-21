#!/bin/bash
# absolute path to the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function help() {
  cat <<EOF
Script description: what it does.
Parameters:
  -c    Config file (required)
  -d    Some other required arg (required)
  -o    Extra parameter (optional)
EOF
  exit 1
}

#Defaults
optional_param="default"

while getopts "c:d:oh" FLAG; do
  case $FLAG in
    c)
        config_file=${OPTARG}
        ;;
    d)
        some_arg=${OPTARG}
        ;;
    o)
        optional_param=${OPTARG}
        ;;
    h)
        help
        ;;
    *)
        help
        ;;
  esac
done

[[ -z ${config_file} || -z ${some_arg} ]] && {
  echo -e "\nRequired parameters not provided. Exiting.\n"
  help
}

if [[ -f "${config_file}" ]] ; then
  # absolute path to config file
  config_file="$(cd $(dirname ${config_file}); pwd)/$(basename ${config_file})"
  #shellcheck source=/dev/null
  source "${config_file}"
else
  echo "Config file not found. Exiting."
  exit 1
fi

## script starts here
