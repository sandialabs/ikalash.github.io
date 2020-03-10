#!/bin/bash

if [[ $# -eq 0 ]]; then 
  echo "No arguments provided to process_tests.sh!"
  exit 1 
fi 

machineName=$1 
if [ "$machineName" != "waterman" ]; then 
  if [ "$machineName" != "blake" ]; then 
    echo "Invalid machine name!  Valid names are 'blake' and 'waterman'.  You specified " $machineName 
    exit 1 
  fi 
fi 

cd ../ext/kcshan-perf-analysis
git reset --hard origin/master
git pull 
#git submodule init 
#git submodule update 

cd ../../ali 

source execute_jupyter_nbs.sh $machineName >& execute_jupyter_nb_$machineName.out 
source concatenate_file.sh $machineName >& concatenate_file_$machineName.out 

cd ../
PWD=`pwd`
dataDir="$PWD/"$machineName"_nightly_data"
cd $dataDir
rm -rf *out
python email_report.py >& email.out


