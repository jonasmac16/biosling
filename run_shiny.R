## https://vbaliga.github.io/posts/2019-04-28-verify-that-r-packages-are-installed-and-loaded/
## If a package is installed, it will be loaded. If any 
## are not, the missing package(s) will be installed 
## from CRAN and then loaded.

## First specify the packages of interest
packages = c("shiny", "BBmisc", "dplyr", "tidyr")

## Now load or install&load all
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
    }
  }
)

library(shiny)
runApp()