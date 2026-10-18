# Data provenance

`hai_burden_table2.csv` holds the numbers from Table 2 of Zacher et al. (2019),
published in Eurosurveillance 24(46). The table is on page 5 of the article.
The 45 estimates and their 95% uncertainty intervals were entered by hand
from this table. I checked each number against the PDF.

Article link: https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135

Run `hai_burden.R` from the package root to rebuild `data/hai_burden.rda`.
The script reads the csv file, turns the short codes into readable labels and
saves the result with `usethis::use_data()`.