<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/gender)](http://cran.r-project.org/package=gender) [![CRAN\_Downloads](http://cranlogs.r-pkg.org/badges/grand-total/gender)](http://cran.r-project.org/package=gender) [![Build Status](https://travis-ci.org/ropensci/gender.svg?branch=master)](https://travis-ci.org/ropensci/gender) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/gender?branch=master)](https://ci.appveyor.com/project/ropensci/gender)

gender: Predict Gender from Names Using Historical Data
=======================================================

Data sets, historical or otherwise, often contain a list of first names but seldom identify those names by gender. Most techniques for finding gender programmatically rely on lists of male and female names. However, the gender associated with names can vary over time. Any data set that covers the normal span of a human life will require a historical method to find gender from names. This [R](http://www.r-project.org/) package uses historical datasets from the U.S. Social Security Administration, the U.S. Census Bureau (via [IPUMS USA](https://usa.ipums.org/usa/)), and the [North Atlantic Population Project](https://www.nappdata.org/napp/) to provide predictions of gender for first names for particular countries and time periods.

Installation
------------

You can install [this package from CRAN](http://cran.r-project.org/package=gender):

``` r
install.packages("gender")
```

The first time you use the package you will be prompted to install the accompanying [genderdata package](https://github.com/ropensci/genderdata). Alternatively, you can install this package for yourself from the [rOpenSci package repository](http://packages.ropensci.org/):

``` r
install.packages("genderdata", type = "source",
                 repos = "http://packages.ropensci.org")
```

If you prefer, you can install the development versions of both packages from the [rOpenSci package repository](http://packages.ropensci.org/):

``` r
install.packages(c("gender", "genderdata"),
                 repos = "http://packages.ropensci.org",
                 type = "source")
```

Using the package
-----------------

The `gender()` function takes a character vector of names and a year or range of years and uses various datasets to predict the gender of names. Here we predict the gender of the names Madison and Hillary in 1930 and again in the 2000s using Social Security data.

``` r
library(gender)
gender(c("Madison", "Hillary"), years = 1930, method = "ssa")
#> Source: local data frame [2 x 6]
#> 
#>      name proportion_male proportion_female gender year_min year_max
#>     (chr)           (dbl)             (dbl)  (chr)    (dbl)    (dbl)
#> 1 Hillary               1                 0   male     1930     1930
#> 2 Madison               1                 0   male     1930     1930
gender(c("Madison", "Hillary"), years = c(2000, 2010), method = "ssa")
#> Source: local data frame [2 x 6]
#> 
#>      name proportion_male proportion_female gender year_min year_max
#>     (chr)           (dbl)             (dbl)  (chr)    (dbl)    (dbl)
#> 1 Hillary          0.0055            0.9945 female     2000     2010
#> 2 Madison          0.0046            0.9954 female     2000     2010
```

See the package vignette or [read it online at CRAN](https://cran.rstudio.com/web/packages/gender/vignettes/predicting-gender.html) for a fuller introduction and suggestions on how to use the `gender()` function efficiently with large datasets.

``` r
vignette(topic = "predicting-gender", package = "gender")
```

To read the documentation for the datasets, install the [genderdata package](https://github.com/ropensci/genderdata) then examine the included datasets.

``` r
library(genderdata)
data(package = "genderdata")
```

Citation
--------

If you use this package, I would appreciate a citation. You can see up to date citation information with `citation("gender")`. You can cite either the package or the accompanying journal article.

> Lincoln Mullen (2015). gender: Predict Gender from Names Using Historical Data. R package version 0.5.0.9000. <https://github.com/ropensci/gender>

> Cameron Blevins and Lincoln Mullen, "Jane, John ... Leslie? A Historical Method for Algorithmic Gender Prediction," *Digital Humanities Quarterly* (forthcoming 2015).

------------------------------------------------------------------------

[![rOpenSCi logo](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
