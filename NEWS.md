# gender 0.6.0

- Fixes installation problems with the move away from rOpenSci
- Removes the `gender_df()` function, which did not work properly.

# gender 0.5.4

- update dependencies, and fix for dplyr 1.0.0
- update URL for rOpenSci CRAN-like repository

# gender 0.5.3

- improvements to documentation
- improvements to testing when genderdata is available

# gender 0.5.2

- bugfix for change in the genderize.io API (#50)

# gender 0.5.1

- bugfix for some users who cannot install the `genderdata` package as binary

# gender 0.5.0

- genderdata package is installed using `install.packages()` from the rOpenSci
  package repository instead of using `install_github()`.
- all functions always return data frames
- general performance improvements
- calls to Genderize.io API no longer fail if the name does not exist
- new function `gender_df()` efficiently applies `gender()` to data frames
- add North Atlantic Population Project dataset for six European countries

# gender 0.4.3

- updates to README.md as requested by CRAN

# gender 0.4.2

- bugfix: Kantrowitz method is now case-insensitive
- updates to title and descriptions according to CRAN policy

# gender 0.4.1

- tests and vignettes run without depending on the genderdata package
- users will be prompted to install the genderdata package from GitHub the
  first time that it is necessary
- added a demo mode with a minimal dataset

# gender 0.4

- data is now external to the gender package and is available in the
  genderdata package.
- genderdata package can be installed with a new function

# gender 0.3

- rewrote all functions to take only character vectors, not data frames, but
  provided instructions on how to use with data frames
- wrote a vignette describing the data sources and explaining the historical
  methodology behind this package

# gender 0.2

- implemented an `ipums` method that predicts gender before 1930 using U.S. Census
  data from IPUMS (contributed by Benjamin Schmidt).
- upgraded dependency on `dplyr` to 0.2.

# gender 0.1

- function `gender` implements gender lookup for names and data frames
- implemented finding gender by using the Kantrowitz names corpus
- implemented finding gender by using the national Social Security
  Administration data for names and dates of birth
