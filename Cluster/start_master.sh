#!/bin/bash

BLENDER_DIR=/apps/leuven/K40c/source/blender/blender-2.77a/
PATH="${BLENDER_DIR}:${PATH}"

nohup blender -b ~/Blender/master.blend -a \
              --addons netrender -noaudio -nojoystick &
