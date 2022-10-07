# 2022_hw2_template
HW2 - explore CalFire data

3. Write a shell script called `count_fires.sh` which does all of the following.
   * Download a comma delimited datasets from https://data.cnra.ca.gov/  which are listing of fires in several decades larger than 5000+. search for "Recent Large Fire Perimiters" in the search box. Click on the dataset it should take you to [this page](https://data.cnra.ca.gov/dataset/recent-large-fire-perimeters-5000-acres1). Download the [CSV file](https://gis.data.cnra.ca.gov/datasets/CALFIRE-Forestry::recent-large-fire-perimeters-5000-acres.csv). (hint use `curl`).
   * Print out the range of years that occur in this file (hint cut out the column you want, sort and get either the smallest or largest number)
      * you'll notice there are 2 weird numbers in there "48088" and "6901" - can you tell why? You will need to go into the file and correct something (this is reminder that data are not always clean!) to avoid this problem.
   * Print out the number of fires in the database (hint use `wc`, remove the header or subtract out the rows )
   * Print out the number of fires that occur each year (hint use `cut`, `sort` and `uniq -c`)
   * Print out the name largest fire (hint use `sort`) - use the `GIS_ACRES` column
   * Print out the total acreage burned in each year.
     * _hint_ you can simply the file by using cut `cut -d, -f2,13 ...` to get the columns you need and awk to accumulate `awk -F',' '{sum+=$2;} END{print sum;}'`
     *  you can have your script filter out just the rows for a given year and add up the numbers for it? This will be easiest with a loop. Think about
     ```
        for YEAR in $(GET THE YEARS)
        do
           TOTAL=$(grep ... | awk ...)
           echo "In Year $YEAR, Total was $TOTAL"
        done
        ```
