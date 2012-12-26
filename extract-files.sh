#!/bin/sh

VENDOR=lge
DEVICE=msm7x27-common

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

echo "Pulling common files...!"
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
done

./setup-makefiles.sh
