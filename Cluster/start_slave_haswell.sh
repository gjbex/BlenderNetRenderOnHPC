#!/bin/bash

BLENDER_DIR=/apps/leuven/K40c/source/blender/blender-2.77a/
PATH="${BLENDER_DIR}:${PATH}"

qsub "$@" ${BLENDER_DIR}/start_slave_haswell.pbs
