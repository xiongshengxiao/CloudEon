#!/bin/bash

KYLIN_WORK_DIR="${conf['kylin.hdfs.work.dir']}"

/bin/bash -c "hadoop fs -test -e  $KYLIN_WORK_DIR"
if [ $? -eq 0 ] ;then
    echo "$KYLIN_WORK_DIR already exists."
else
    echo "$KYLIN_WORK_DIR does not exist."
    /bin/bash -c "hadoop  fs  -mkdir -p $KYLIN_WORK_DIR"
    /bin/bash -c "hadoop  fs  -chmod  -R 777 $KYLIN_WORK_DIR"
    echo " create $KYLIN_WORK_DIR on hdfs successfully."
fi

