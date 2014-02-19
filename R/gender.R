encode_gender <- function(first_names, year = c(1970, 2012), method = "ssa") {
  if (method == "ssa") {
    encode_gender_ssa(first_names, year)
  } else if (method == "corpus") {
    encode_gender_corpus(first_names)
  } else {
    warning("Method ", method, " is not recognized. Try ?encode_gender for help.")
  }
}

