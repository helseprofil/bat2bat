# bat2bat

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/folkehelseprofil/bat2bat?branch=master&svg=true)](https://ci.appveyor.com/project/folkehelseprofil/bat2bat)

Denne R pakke er en shinyApp som brukes til for å sammenlikne batch filer.
Online versjon er tilgjengelig [https://fhprofil.shinyapps.io/bat2bat/](Shinyapps.io)

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
