#!/bin/bash

set -x
set -e

THIS_SCRIPT="$(readlink -f "$0")"
BASE_DIR="$(dirname "$THIS_SCRIPT")"

DATA_DIR="${BASE_DIR}/compose"
YAML_FILE="${DATA_DIR}/docker-compose.yaml"

"${BASE_DIR}/scripts/docker_run_docker-compose.sh" \
	"$DATA_DIR" \
	"$YAML_FILE" \
	run --rm aosp
