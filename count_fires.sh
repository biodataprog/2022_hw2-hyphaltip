#!/bin/bash -l

# step to write
# download the CSV file
# curl -o calfire.csv ...
if [ ! -f calfires_2021.csv ]; then
  curl -s -o calfires_2021.csv https://gis.data.cnra.ca.gov/datasets/CALFIRE-Forestry::recent-large-fire-perimeters-5000-acres.csv
fi
# print out the range of years found -- you may need to go in and edit the file
MAXYEAR=$(cut -d, -f2 calfires_2021.csv | sort -nr | head -n 1)
MINYEAR=$(cut -d, -f2 calfires_2021.csv | sort -n | grep -v YEAR | head -n 1)
# write code to set these variables with the smallest and largest years
echo "This report has the years: $MINYEAR-$MAXYEAR"
# if you have problems the CSV file already part of this repository so you can use 'calfires_2021.csv'

# print out the total number of fires (remember to remove the header line)
TOTALFIRECOUNT=$(tail -n +2 calfires_2021.csv | wc -l | awk '{print $1}')
# put your code here to update this variable
echo "Total number of fires: $TOTALFIRECOUNT"

# print out the number of fire in each year
echo "Number of fires in each year follows:"
tail -n +2 calfires_2021.csv | cut -d, -f2 | sort | uniq -c
# or
echo "  Or print as:"
tail -n +2 calfires_2021.csv | cut -d, -f2 | sort | uniq -c | while read COUNT YEAR
do
  echo -e "\t$YEAR had $COUNT fires"
done

# print out the name of the largest file use the GIS_ACRES and report the number of acres
IFS=,
tail -n +2 calfires_2021.csv | cut -d, -f6,13 | sort -t, -k2,2nr | head -n 1 | while read LARGEST LARGESTACRES
do
  echo "Largest fire was $LARGEST and burned $LARGESTACRES"
done


unset IFS
# print out the years - change the code in $(echo 1990) to print out the years (hint - how did you get MINYEAR and MAXYEAR?
TOTAL=0
LASTYEAR=""
for YEAR in $(tail -n +2 calfires_2021.csv | cut -d, -f2 | sort | uniq)
do

  TOTAL=$(tail -n +2 calfires_2021.csv | cut -d, -f2,13 | grep "$YEAR," | awk -F, '{SUM+= $1} END{print SUM}')
  echo "In Year $YEAR Total was $TOTAL"
done
