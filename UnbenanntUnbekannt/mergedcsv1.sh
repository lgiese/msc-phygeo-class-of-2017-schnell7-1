#!/bin/bash
mkdir merged_csv

mkdir merged_csv/campbell
find sortiert/campbell/ -name '*Temp_RH_Radiation_5minRes*.csv' | sort | xargs -i cat {} > merged_csv/campbell/20110616_20110616_Campbell_Temp_RH_Radiation_5minRes.csv
find sortiert/campbell/ -name '*Temp_RH_Radiation_1minRes*.csv' | sort | xargs -i cat {} > merged_csv/campbell/20120319_20121029_Campbell_Temp_RH_Radiation_1minRes.csv
find sortiert/campbell/ -name '*CNR4_radiation_1minRes*.csv' | sort | xargs -i cat {} > merged_csv/campbell/20121111_20141111_Campbell_CNR4_radiation_1minRes.csv
find sortiert/campbell/ -name '*Temp_RH_1minRes*.csv' | sort | xargs -i cat {} > merged_csv/campbell/20121111_20141111_Campbell_Temp_RH_1minRes.csv

mkdir merged_csv/cl31
find sortiert/cl31/ -name '*preprocessed*.csv' | sort | xargs -i cat {} > merged_csv/cl31/20091206_20140307_cl31_preprocessed.csv
find sortiert/cl31/ -name '*backscatter*.csv' | sort | xargs -i cat {} > merged_csv/cl31/20091206_20141111_cl31_backscatter_1minRes.csv
find sortiert/cl31/ -name '*1mincldbase*.csv' | sort | xargs -i cat {} > merged_csv/cl31/20091206_20141111_cl31_1mincldbase.csv

mkdir merged_csv/cloudradar
find sortiert/cloudradar/ -name '*CloudInfo_1min*.csv' | sort | xargs -i cat {} > merged_csv/cloudradar/20091206_20140430_rcr002_mod_CloudInfo_1min.csv
find sortiert/cloudradar/ -name '*Zrangecorrected_1minRes*.csv' | sort | xargs -i cat {} > merged_csv/cloudradar/20091206_20140430_rcr002_mod_Zrangecorrected_1minRes.csv
find sortiert/cloudradar/ -name '*preprocessed*.csv' | sort | xargs -i cat {} > merged_csv/cloudradar/20091206_20140307_rcr002_mod_preprocessed.csv

mkdir merged_csv/gps_wv
find sortiert/gps_wv/ -name '*marb*.csv' | sort | xargs -i cat {} > merged_csv/gps_wv/20111021_20141111_gps_marb.csv

mkdir merged_csv/mrr
find sortiert/mrr/ -name '*RR_1minRes*.csv' | sort | xargs -i cat {} > merged_csv/mrr/20091206_2014111_mrr_RR_1minRes.csv

mkdir merged_csv/ott
find sortiert/ott/ -name '*Rain_1minRes*.csv' | sort | xargs -i cat {} > merged_csv/ott/20120229_20141001_Ott_Rain_1minRes.csv
find sortiert/ott/ -name '*Export_MengeNEZ*.csv' | sort | xargs -i cat {} > merged_csv/ott/20120229_20141001_Export_MengeNEZ.csv

mkdir merged_csv/usa
find sortiert/usa/ -name '*1minRes*.csv' | sort | xargs -i cat {} > merged_csv/usa/20091206_usa_1minRes.csv

mkdir merged_csv/vpf710
find sortiert/vpf710/ -name '*20Sek*.csv' | sort | xargs -i cat {} > merged_csv/vpf710/20091206_20141111_VPF710_20Sek.csv

mkdir merged_csv/vpf730
find sortiert/vpf730/ -name '*20Sek*.csv' | sort | xargs -i cat {} > merged_csv/vpf730/20091206_20141111_VPF730_20Sek.csv









