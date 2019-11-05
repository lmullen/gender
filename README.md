
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gender

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/gender)](https://CRAN.R-project.org/package=gender)
[![CRAN\_Downloads](http://cranlogs.r-pkg.org/badges/grand-total/gender)](https://CRAN.R-project.org/package=gender)
[![Build
Status](https://travis-ci.org/ropensci/gender.svg?branch=master)](https://travis-ci.org/ropensci/gender)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ropensci/gender?branch=master&svg=true)](https://ci.appveyor.com/project/ropensci/gender)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ropensci/gender/master.svg)](https://codecov.io/github/ropensci/gender?branch=master)

## Guidelines and warnings

This package attempts to infer gender (or more precisely, sex assigned
at birth) based on first names using historical data, typically data
that was gathered by the state. This method has many limitations, and
before you use this package be sure to take into account the following
guidelines.

1)  Your analysis and the way you report it should take into account the
    limitations of this method, which include its reliance of data
    created by the state and its inability to see beyond the
    state-imposed gender binary. At a minimum, be sure to read our
    article explaining the limitations of this method, as well as the
    review article that is critical of this sort of methodology, both
    cited below.

2)  Do not use this package to study individuals: it is at most useful
    for studying populations in the aggregate.

3)  Resort to this method only when the alternative is not a more
    nuanced and justifiable approach to studying gender, but where the
    alternative is not studying gender at all. For instance, for many
    historical sources this approach might be the only way to get a
    sense of the sex ratios in a population. But ask whether you really
    need to use this method, whether you are using it responsibly, or
    whether you could use a better approach instead.

Blevins, Cameron, and Lincoln A. Mullen, “Jane, John … Leslie? A
Historical Method for Algorithmic Gender Prediction,” *Digital
Humanities Quarterly* 9, no. 3 (2015).
<http://www.digitalhumanities.org/dhq/vol/9/3/000223/000223.html>

Mihaljević, Helena, Marco Tullney, Lucía Santamaría, and Christian
Steinfeldt. “Reflections on Gender Analyses of Bibliographic Corpora.”
*Frontiers in Big Data* 2 (August 28, 2019): 29.
<https://doi.org/10.3389/fdata.2019.00029>.

## Description

Data sets, historical or otherwise, often contain a list of first names
but seldom identify those names by gender. Most techniques for finding
gender programmatically rely on lists of male and female names. However,
the gender associated with names can vary over time. Any data set that
covers the normal span of a human life will require a historical method
to find gender from names. This [R](https://www.r-project.org/) package
uses historical datasets from the U.S. Social Security Administration,
the U.S. Census Bureau (via [IPUMS USA](https://usa.ipums.org/usa/)),
and the [North Atlantic Population
Project](https://www.nappdata.org/napp/) to provide predictions of
gender for first names for particular countries and time periods.

## Installation

You can install [this package from
CRAN](https://cran.r-project.org/package=gender):

``` r
install.packages("gender")
```

The first time you use the package you will be prompted to install the
accompanying [genderdata
package](https://github.com/ropensci/genderdata). Alternatively, you can
install this package for yourself from the [rOpenSci package
repository](http://packages.ropensci.org/):

``` r
install.packages("genderdata", type = "source",
                 repos = "http://packages.ropensci.org")
```

If you prefer, you can install the development versions of both packages
from the [rOpenSci package repository](http://packages.ropensci.org/):

``` r
install.packages(c("gender", "genderdata"),
                 repos = "http://packages.ropensci.org",
                 type = "source")
```

## Using the package

The `gender()` function takes a character vector of names and a year or
range of years and uses various datasets to predict the gender of names.
Here we predict the gender of the names Madison and Hillary in 1930 and
again in the 2000s using Social Security data.

``` r
library(gender)
gender(c("Madison", "Hillary"), years = 1930, method = "ssa")
#> # A tibble: 2 x 6
#>   name    proportion_male proportion_female gender year_min year_max
#>   <chr>             <dbl>             <dbl> <chr>     <dbl>    <dbl>
#> 1 Hillary               1                 0 male       1930     1930
#> 2 Madison               1                 0 male       1930     1930
gender(c("Madison", "Hillary"), years = c(2000, 2010), method = "ssa")
#> # A tibble: 2 x 6
#>   name    proportion_male proportion_female gender year_min year_max
#>   <chr>             <dbl>             <dbl> <chr>     <dbl>    <dbl>
#> 1 Hillary          0.0055             0.994 female     2000     2010
#> 2 Madison          0.0046             0.995 female     2000     2010
```

See the package vignette for a fuller introduction and suggestions on
how to use the `gender()` function efficiently with large datasets.

``` r
vignette(topic = "predicting-gender", package = "gender")
```

To read the documentation for the datasets, install the [genderdata
package](https://github.com/ropensci/genderdata) then examine the
included datasets.

``` r
library(genderdata)
data(package = "genderdata")
```

## Citation

If you use this package, I would appreciate a citation.

``` r
citation("gender")
#> 
#> To cite the 'gender' package, you may either cite the package
#> directly or cite the journal article which explains its method:
#> 
#>   Lincoln Mullen (2018). gender: Predict Gender from Names Using
#>   Historical Data. R package version 0.5.2.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {gender: Predict Gender from Names Using Historical Data},
#>     author = {Lincoln Mullen},
#>     year = {2018},
#>     note = {R package version 0.5.2},
#>     url = {https://github.com/ropensci/gender},
#>   }
#> 
#> For the journal article, please cite:
#> 
#> Cameron Blevins and Lincoln Mullen, "Jane, John ... Leslie? A
#> Historical Method for Algorithmic Gender Prediction," _Digital
#> Humanities Quarterly_ 9, no. 3 (2015):
#> <http://www.digitalhumanities.org/dhq/vol/9/3/000223/000223.html>.
```

-----

[![rOpenSCi
logo](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
