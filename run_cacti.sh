#!/bin/bash

associativity=""
cache_size=""

# Parsing the parameters passed to script
while [ $# -gt 0 ]; do
  case "$1" in
    --associativity=*)
      associativity="${1#*=}"
      ;;
    --cache_size=*)
      cache_size="${1#*=}"
      ;;
    *)
      echo "Invalid parameter: $1"
      exit 1
  esac
  shift
done

# Checking if both parameters are provided
if [ -z "$associativity" ] || [ -z "$cache_size" ]; then
  echo "Error: Both --associativity and --cache_size parameters are required."
  echo "Usage: ./run_cacti.sh --associativity=<value> --cache_size=<value>"
  exit 1
fi

# Ensuring that the output directory exists
output_dir="$HOME/simulation_output_files"
mkdir -p "$output_dir"

# Output file name
output_file="${output_dir}/op_${associativity}_${cache_size}.txt"

# Running the cacti command and put the corresponding output to the specified file
cacti -infile ./config_files/cache_${associativity}_${cache_size}.cfg > "$output_file"

echo "Cacti output saved to $output_file"