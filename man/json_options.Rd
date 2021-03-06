% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jsondiff.R
\name{json_options}
\alias{json_options}
\title{JSON options}
\usage{
json_options(dataframe = c("rows", "columns", "values"),
  matrix = c("rowmajor", "columnmajor"), Date = c("ISO8601", "epoch"),
  POSIXt = c("string", "ISO8601", "epoch", "mongo"), factor = c("string",
  "integer"), complex = c("string", "list"), raw = c("base64", "hex",
  "mongo"), null = c("list", "null"), na = c("null", "string"),
  auto_unbox = TRUE, digits = 4, pretty = FALSE, force = FALSE, ...)
}
\arguments{
\item{dataframe}{how to encode data.frame objects: must be one of 'rows',
'columns' or 'values'}

\item{matrix}{how to encode matrices and higher dimensional arrays: must be
one of 'rowmajor' or 'columnmajor'.}

\item{Date}{how to encode Date objects: must be one of 'ISO8601' or 'epoch'}

\item{POSIXt}{how to encode POSIXt (datetime) objects: must be one of
'string', 'ISO8601', 'epoch' or 'mongo'}

\item{factor}{how to encode factor objects: must be one of 'string' or
'integer'}

\item{complex}{how to encode complex numbers: must be one of 'string' or
'list'}

\item{raw}{how to encode raw objects: must be one of 'base64', 'hex' or
'mongo'}

\item{null}{how to encode NULL values within a list: must be one of 'null' or
'list'}

\item{na}{how to print NA values: must be one of 'null' or 'string'. Defaults
are class specific}

\item{auto_unbox}{automatically \code{\link[jsonlite]{unbox}} all atomic
vectors of length 1. It is usually safer to avoid this and instead use the
\code{\link[jsonlite]{unbox}} function to unbox individual elements. An
exception is that objects of class \code{AsIs} (i.e. wrapped in \code{I()})
are not automatically unboxed. This is a way to mark single values as
length-1 arrays.}

\item{digits}{max number of decimal digits to print for numeric values. Use
\code{I()} to specify significant digits. Use \code{NA} for max precision.}

\item{pretty}{adds indentation whitespace to JSON output. Can be TRUE/FALSE
or a number specifying the number of spaces to indent. See
\code{\link[jsonlite]{prettify}}}

\item{force}{unclass/skip objects of classes with no defined JSON mapping}

\item{...}{arguments passed on to class specific \code{print} methods}
}
\description{
Helper function for \code{\link[jsonlite]{toJSON}} conversion settings.
These arguments are passed to \code{\link[jsonlite]{toJSON}}
}
