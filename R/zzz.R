.onLoad <- function(libname, pkgname){
    ## Size upload to 100MB
    options(shiny.maxRequestSize=100*1024^2)

    ## Load mixFil
    data("mixFil", package=pkgname, envir = parent.env(environment()))
}
