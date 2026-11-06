pkgs <- c("readr", "dplyr", "tidyr", "ggplot2", "ggrepel", "knitr")
to_install <- pkgs[!pkgs %in% rownames(installed.packages())]
if (length(to_install) > 0) install.packages(to_install)
invisible(lapply(pkgs, library, character.only = TRUE))
