#!/bin/bash

PID=$(ps -ef | grep blender | grep ${USER} | grep -v grep | awk '{print $2}')
kill -9 ${PID}
