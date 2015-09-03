This is an patch to the gender package which fixes a bug for some users who have
been unable install the data package because of an option they have set.

## Testing environments

Mac OS X 10.10.4:
- R version 3.2.2 (2015-08-14)

Windows via winbuilder:
- R version 3.2.2 (2015-08-14)
- R Under development (unstable) (2015-08-20 r69138)

Debian (via Docker):
- R Under development (unstable) (2015-08-11 r68999)

## Check results

There were no WARNINGS or ERRORS.

There were two NOTES.

    * checking CRAN incoming feasibility ... NOTE
    Suggests or Enhances not in mainstream repositories:
      genderdata
    
    Availability using Additional_repositories specification:
      genderdata   yes   http://packages.ropensci.org
    * checking package dependencies ... NOTE
    Package suggested but not available for checking: 'genderdata'

The 'genderdata' package provides additional datasets which cannot go on CRAN 
because of their size. It is available in a package repository, and is installed
with user confirmation when needed. It is a suggested package, and all tests and
checks for 'gender' pass with and without 'genderdata' installed.
