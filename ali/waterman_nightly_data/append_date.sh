#!/bin/bash

now=$(date +"%Y%m%d")
FILE=ctest-$now.json
echo $FILE
if test -f "$FILE"; then
  echo "$FILE file exists"
  now=$(date +"%m_%d_%Y")
  echo $now
  mv Ali_PerfTestsWaterman.html Ali_PerfTestsWaterman_$now.html
  mv Comparison_Interactive.html Comparison_Interactive_$now.html
  git add Ali_PerfTestsWaterman_$now.html
  git add Comparison_Interactive_$now.html 
  git commit -m "Checking in Waterman Jupyter notebooks from $now ." 
  git push
  rm html_entry 
  echo "<li><p><strong><a href="waterman_nightly_data/Ali_PerfTestsWaterman_$now.html">$now</a></strong>.</p>" >& html_entry
else  
  echo "$FILE does not exist! Not Jupyter notebook in repo."
fi
