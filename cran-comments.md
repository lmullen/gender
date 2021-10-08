This is a patch release to fix problems with installing supplemental data.

## Testing environments

Mac OS X 10.15.4:
- R version 4.0.0

Windows via winbuilder:
- R-devel 

Ubuntu via GitHub Actions:
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
      genderdata   no   ?                           
      ?             ?   http://packages.ropensci.org

    Package suggested but not available for checking: 'genderdata'

The 'genderdata' package provides additional datasets which cannot go on CRAN 
because of their size. It is available in a package repository, and is installed
with user confirmation when needed. It is a suggested package, and all tests and
checks for 'gender' pass with and without 'genderdata' installed.
