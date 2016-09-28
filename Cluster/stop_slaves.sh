#!/bin/bash

for job_id in $(qstat | grep -e '^[0-9]' | perl -i -p -e 's/^(\d+).*$/$1/');
do
    echo "deleting job ${job_id}"
    qdel ${job_id}
done
