#!/bin/bash

cd blake_nightly_data
git reset --hard origin/master
git pull 
jupyter nbconvert --execute Ali_PerfTestsBlake.ipynb
bash append_date.sh >& append_date.out 
