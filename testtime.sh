#!/bin/bash

set -e

start_time=`date +%s`
sleep 3s
end_time=`date +%s`

aa=`expr 420 / 3600`
echo $aa

time_spend=$(expr ${end_time} - ${start_time}) 
hour_spend=`expr ${time_spend} / 3600`
hour_remain=$(expr ${time_spend} % 3600)
min_spend=$(expr ${hour_remain} / 60)
min_remain=$(expr ${hour_remain} % 60)
sec_spend=$min_remain

echo "耗时：$hour_spend小时$min_spend分$sec_spend秒"
