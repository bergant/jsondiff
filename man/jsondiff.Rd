% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jsondiff.R
\name{jsondiff}
\alias{jsondiff}
\title{JSON differences}
\usage{
jsondiff(x1, x2, hide_unchanged = TRUE, json_opt = NULL,
  formatter = "html", object_hash = NULL, width = NULL, height = NULL,
  elementId = NULL)
}
\arguments{
\item{x1}{JSON string or list object}

\item{x2}{JSON string or list object}

\item{hide_unchanged}{(optional) if FALSE, unchanged elements are displayed.}

\item{json_opt}{(optional) options for converting to JSON (use
\link{json_options} to construct an object for options)}

\item{formatter}{(optional) "html" or "annotated"}

\item{object_hash}{(optional) a function for matching objects in an array}

\item{width}{Fixed width for widget (in css units). The default is NULL,
which results in intelligent automatic sizing based on the widget's
container.}

\item{height}{Fixed height for widget (in css units). The default is NULL,
which results in intelligent automatic sizing based on the widget's
container.}

\item{elementId}{element id}
}
\description{
Display differences between two JSONs
}
