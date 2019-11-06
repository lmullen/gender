This is a patch release improving documentation and testing.

## Testing environments

Mac OS X 10.15.1:
- R version 3.6.1 

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
