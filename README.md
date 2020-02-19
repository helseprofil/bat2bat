# bat2bat

 <!-- badges: start -->
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/folkehelseprofil/bat2bat?branch=master&svg=true)](https://ci.appveyor.com/project/folkehelseprofil/bat2bat)
[![Travis build status](https://travis-ci.org/folkehelseprofil/bat2bat.svg?branch=master)](https://travis-ci.org/folkehelseprofil/bat2bat)
[![Codecov test coverage](https://codecov.io/gh/folkehelseprofil/bat2bat/branch/master/graph/badge.svg)](https://codecov.io/gh/folkehelseprofil/bat2bat?branch=master)
 <!-- badges: end -->


Denne R pakke er en shinyApp som brukes til for å sammenlikne batch filer.
Online versjon er tilgjengelig på [shinyapps.io](https://fhprofil.shinyapps.io/bat2bat/)

## Installasjon

For å installere pakken, kan følgende kode kjøres i R:

```r
if (!require("remotes")) install.package("remotes")
remotes::install_github("folkehelseprofil/bat2bat", dependencies=TRUE)
```

Hvis installasjon mislykkes bør du starte opp R eller RStudio på nytt og kjør komandoen på nytt.

## Bruk

Pakken må først lasteopp i R og funksjon `run_app()` brukes for å aktivere appen.

```r
library(bat2bat)
run_app()

```
