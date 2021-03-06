% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/all-generics.r
\name{getHitDef}
\alias{getHitDef}
\alias{getPrimaryHitDef}
\title{Access components of BLAST Hits}
\usage{
getHitDef(x, ...)

getPrimaryHitDef(x, ...)
}
\arguments{
\item{x}{A \linkS4class{Hit} or \linkS4class{HitList} object.}

\item{...}{Further arguments passed to methods.}
}
\value{
A character vector or list of character vectors.
}
\description{
Extract the (primary) hit definition.
}

