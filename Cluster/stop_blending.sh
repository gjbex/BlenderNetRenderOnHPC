#!/bin/bash

echo 'stopping slaves...'
${VSC_HOME}/Blender/stop_slaves.sh
sleep 5

echo 'stopping master...'
${VSC_HOME}/Blender/stop_master.sh
