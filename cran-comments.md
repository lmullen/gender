This is a patch release to make this package compatible with the upcoming 1.0.0 release of dplyr.

This resubmission fixes a problem with a URL in `inst/CITATION`.

## Testing environments

Mac OS X 10.15.4:
- R version 4.0.0

Windows via R-Hub:
- R-devel 

Ubuntu via Travis CI:
- R-oldrel
- R-release
- R-devel

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
