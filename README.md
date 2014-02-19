# Gender: an R package to encode gender based on names and dates of birth

Lincoln A. Mullen | lincoln@lincolnmullen.com | http://lincolnmullen.com

This package encodes gender based on names and dates of birth, using the
Social Security Administration's data set of first names by year and
state. By using the SSA data instead of lists of male and female names,
this package is able to more accurately guess the gender of a name, and
it is able to report the probability that a name was male or female.

This package is based on a [Python script][] by [Cameron Blevins][] and
[Bridget Baird][], who came up with the original idea and found the data
set to make it possible.

# Installation

To install this package, first install 
[devtools](https://github.com/hadley/devtools). 

Then run the following command:

    devtools::install_github("lmullen/gender")

# License

MIT License <http://lmullen.mit-license.org/>

  [Python script]: https://github.com/cblevins/Gender-ID-By-Time
  [Cameron Blevins]: http://www.cameronblevins.org/
  [Bridget Baird]: http://oak.conncoll.edu/bbbai/
