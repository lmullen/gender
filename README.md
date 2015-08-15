<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/gender)](http://cran.r-project.org/web/packages/gender) [![CRAN\_Downloads](http://cranlogs.r-pkg.org/badges/grand-total/gender)](http://cran.r-project.org/web/packages/gender) [![Build Status](https://travis-ci.org/ropensci/gender.svg?branch=master)](https://travis-ci.org/ropensci/gender) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/gender?branch=master)](https://ci.appveyor.com/project/ropensci/gender)

gender: Predict Gender from Names Using Historical Data
=======================================================

Data sets, historical or otherwise, often contain a list of first names but seldom identify those names by gender. Most techniques for finding gender programmatically, such as the [Natural Language Toolkit](http://www.nltk.org/), rely on lists of male and female names. However, the gender[\*](#gender-vs-sex) of names can vary over time. Any data set that covers the normal span of a human life will require a historical method to find gender from names.

This package encodes gender based on names and dates of birth, using either the Social Security Administration's data set of first names by year since 1880 (based on an implementation by [Cameron Blevins](http://www.cameronblevins.org/)) or the U.S. Census data from IPUMS for years before 1930 (contributed by [Ben Schmidt](http://benschmidt.org/)). By using these data sets instead of lists of male and female names, this package is able to more accurately guess the gender of a name; furthermore it is able to report the proportion of times that a name was male or female for any given range of years.

Installation
------------

You can install the [CRAN version](http://cran.r-project.org/web/packages/gender/index.html) of this package with `install.packages("gender")`. The first time you use the package you will be prompted to install the necessary data, which is in the [genderdata package](http://github.com/lmullen/genderdata) hosted on GitHub.

If you prefer, you can install the development versions of both packages directly from GitHub. First install [devtools](https://github.com/hadley/devtools). Then run the following commands, which will install the gender package and its accompanying data package.

``` r
# install.packages("devtools")
devtools::install_github("ropensci/gender")
devtools::install_github("ropensci/genderdata")
```

Using the package
-----------------

The simplest way to use this package is to pass a single name to the `gender()` function. You can optionally specify a year or range of years to the function. If you specify the years option, the function will calculate the proportion of male and female uses of a name for that time period.

``` r
library(gender)
gender("madison")
#> Source: local data frame [1 x 6]
#> 
#>      name proportion_male proportion_female gender year_min year_max
#> 1 madison          0.0162            0.9838 female     1932     2012
```

Using the Social Security data, you can predict gender for years from 1880 to 2012. Notice that in the 1950s Madison is a male name.

``` r
gender("madison", method = "ssa", years = c(1950, 1959))
#> Source: local data frame [1 x 6]
#> 
#>      name proportion_male proportion_female gender year_min year_max
#> 1 madison               1                 0   male     1950     1959
```

Using the IPUMS U.S. Census data, you can predict gender from years from 1789 to 1930.

``` r
gender("madison", method = "ipums", years = 1820)
#> Source: local data frame [1 x 6]
#> 
#>      name proportion_male proportion_female gender year_min year_max
#> 1 madison               1                 0   male     1820     1820
```

See the function documentation for more options: `?gender`. See the package vignette for suggestions on how to use the function with a data frame: `vignette(topic = "predicting-gender", package = "gender")`

Data
----

The accompanying [genderdata package](http://github.com/ropensci/genderdata) includes cleaned-up versions of several data sets. To see the available data sets run the following command:

``` r
library(genderdata)
data(package = "genderdata")
data(ssa_national)        # returns a data set with 1.6 million rows
```

The raw data sets used in this package are available here:

-   [Mark Kantrowitz's name corpus](http://www.cs.cmu.edu/afs/cs/project/ai-repository/ai/areas/nlp/corpora/names/0.html)
-   [Social Security Administration's baby names by year and state](http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-data-by-state-and-district-of-)
-   [Social Security Administration's baby names by year](http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-national-level-data)
-   [IPUMS Census data](https://usa.ipums.org/)

License
-------

MIT License, <http://lmullen.mit-license.org/>

Citation
--------

Eventually Cameron and I will publish an article about this method. In the meantime, please cite this [GitHub repository](https://github.com/ropensci/gender).

By [Lincoln Mullen](http://lincolnmullen.com) and [contributors](https://github.com/ropensci/gender/graphs/contributors).

Note
----

<a name="gender-vs-sex"></a>\* Of course in most cases the Social Security Administration data more approximately records the biological category sex rather than the social category gender, since it mostly records names given at birth. But since in most cases researchers will be interested in gender, I've named this package gender, leaving it up to researchers to interpret exactly what the encoded values mean.

------------------------------------------------------------------------

[![rOpenSCi logo](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
