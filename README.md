# Gender, an R package 

Lincoln A. Mullen | lincoln@lincolnmullen.com | http://lincolnmullen.com

Data sets, historical or otherwise, often contain a list of first names
but seldom identify those names by gender. Most techniques for finding
gender programmatically, such as the [Natural Language Toolkit][], rely
on lists of male and female names. However, the gender[\*][] of names
can vary over time. Any data set that covers the normal span of a human
life will require a fundamentally historical method to find gender from
names.

This package, based on collaborative work with [Cameron Blevins][],
encodes gender based on names and dates of birth, using the Social
Security Administration's data set of first names by year since 1880. By
using the SSA data instead of lists of male and female names, this
package is able to more accurately guess the gender of a name;
furthermore it is able to report the proportion of times that a name was
male or female for any given range of years.

See also Cameron's implementation of the same concept in a [Python
script][].

![Twelve names that changed over time](https://raw.github.com/lmullen/gender/master/changing-names.png)

## Installation

To install this package, first install [devtools][].

Then run the following command:

    devtools::install_github("lmullen/gender")

## Using the package

The simplest way to use this package is to pass a single name to the
`gender()` function. You can optionally specify a year or range of years
to the function. If you specify the years option, the function will
calculate the proportion of male and female uses of a name for that time
period; otherwise it will use the time period 1932-2012.

    gender("madison")
    # returns
    #      name proportion_female gender proportion_male
    # 1 madison            0.9828 female          0.0172

    gender("madison", years = c(1900, 1985))
    # returns
    #      name proportion_female gender proportion_male
    # 1 madison            0.0972   male          0.9028

    gender("madison", years = 1985)
    #      name proportion_female gender proportion_male
    # 1 madison            0.7863 female          0.2137

You probably have a data set with many names. For now
this package assumes that you have a data frame with a column `name`
which is a character vector (not a factor) containing all lowercase
names. If this does not match your data set, see [dplyr][] and
[stringr][] for help. You can pass that data frame to the `gender()`
function, which will add columns for gender and the certainty of that
guess to your data frame.

    gender(sample_names_data)

Using a data frame you can specify a single year or range of years as in
the example above. But you can also specify a column in your data set
which contains year of birth associated with the name. For now, this
column must be an integer vector (not a numeric vector) name `year`.

    gender(sample_names_data, years = TRUE)

If you prefer to use Kantrowitz corpus of male and female names, you can
use the `method` option.

    gender(sample_names_data, method = "kantrowitz")

If you prefer a more minimal output, use the option `certainty = FALSE`
to remove the `proportion_male` and `proportion_female` output.

## Data

This package includes cleaned-up versions of several data sets. To see
the available data sets run the following command:

    data(package = "gender")
    data(ssa_national)        # returns a data set with 1.6 million rows

The raw data sets used in this package are available here:

-   [Mark Kantrowitz's name corpus][]
-   [Social Security Administration's baby names by year and state][]
-   [Social Security Administration's baby names by year][]

## License

MIT License, <http://lmullen.mit-license.org/>

## Citation

Eventually Cameron and I will publish an article about this method. In
the meantime, you can cite and link to either his [Python
implementation][Python script] or my implementation in this R package.

## Note

<a name="gender-vs-sex"></a>\* Of course in most cases the Social
Security Administration data more approximately records the biological
category sex rather than the social category gender, since it mostly
records names given at birth. But since in most cases researchers will
be interested in gender, I've named this package gender, leaving it up
to researchers to interpret exactly what the encoded values mean.

  [Natural Language Toolkit]: http://www.nltk.org/
  [\*]: #gender-vs-sex
  [Cameron Blevins]: http://www.cameronblevins.org/
  [Python script]: https://github.com/cblevins/Gender-ID-By-Time
  [devtools]: https://github.com/hadley/devtools
  [dplyr]: https://github.com/hadley/dplyr
  [stringr]: https://github.com/hadley/stringr
  [Mark Kantrowitz's name corpus]: http://www.cs.cmu.edu/afs/cs/project/ai-repository/ai/areas/nlp/corpora/names/0.html
  [Social Security Administration's baby names by year and state]: http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-data-by-state-and-district-of-
  [Social Security Administration's baby names by year]: http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-national-level-data

---
[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)