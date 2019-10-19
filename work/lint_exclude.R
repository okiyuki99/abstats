library(dplyr)
lintr::lint_package() %>%
  as.data.frame %>%
  group_by(linter) %>%
  tally(sort = TRUE) %$%
  sprintf("linters: with_defaults(\n    %s\n    dummy_linter = NULL\n  )\n",
          paste0(linter, " = NULL, # ", n, collapse = "\n    ")) %>%
  cat(file = ".lintr")
