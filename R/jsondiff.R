#' jsondiff: render difference between JSONs
#'
#' An R interface to jsondiffpatch library \url{https://github.com/benjamine/jsondiffpatch}
#'
#'
#'
#' @examples
#' \dontrun{
#'
#' x1 <- list(
#'   name = "Pluto",
#'   orbital_speed_kms = 4.7,
#'   category = "planet",
#'   composition = c("methane", "nitrogen")
#' )
#'
#' x2 <- list(
#'   name = "Pluto",
#'   category = "dwarf planet",
#'   orbital_speed_kms = 4.7,
#'   composition = c("nitrogen", "methane", "carbon monoxide")
#' )
#'
#' jsondiff(x1, x2)
#'
#' }
#'
#'
#' @section Support:
#'
#'   Use \url{https://github.com/bergant/jsondiff/issues} for bug reports
#'
#' @docType package
#' @name jsondiff-package
NULL


#' JSON differences
#'
#' Display differences between two JSONs
#'
#' @param  x1 JSON string or list object
#' @param  x2 JSON string or list object
#' @param  hide_unchanged (optional) if FALSE, unchanged elements are displayed.
#' @param  json_opt (optional) options for converting to JSON (use
#'   \link{json_options} to construct an object for options)
#' @param  formatter (optional) "html" or "annotated"
#' @param  object_hash (optional) a function for matching objects in an array
#' @param  width Fixed width for widget (in css units). The default is NULL,
#'   which results in intelligent automatic sizing based on the widget's
#'   container.
#' @param  height Fixed height for widget (in css units). The default is NULL,
#'   which results in intelligent automatic sizing based on the widget's
#'   container.
#' @param  elementId element id
#' @export
jsondiff <- function(
  x1, x2, hide_unchanged = TRUE, json_opt = NULL, formatter = "html",
  object_hash = NULL,
  width = NULL, height = NULL, elementId = NULL ) {

  if(all(!is.character(x1), length(x1) > 1,
         !is.character(x2), length(x2) > 1)) {
    if(is.null(json_opt)) {
      json_opt <- json_options()
    }
    x1 <- do.call(jsonlite::toJSON, c(list(x = x1), json_opt))
    x2 <- do.call(jsonlite::toJSON, c(list(x = x2), json_opt))
  } else {
    # just validate if x1 and x2 are JSON
    jsonlite::fromJSON(x1)
    jsonlite::fromJSON(x2)
  }

  # widget parameters
  x <-
    sprintf(
      '{
        "x1": %s,
        "x2": %s,
        "hideUnchanged": %s,
        "formatter": "%s",
        "objectHash": "%s"
      }\n',

      x1,
      x2,
      c("false","true")[hide_unchanged+1],
      formatter,
      ifelse(is.null(object_hash), "null", gsub("\n", " ", object_hash))
    )

  # create widget
  htmlwidgets::createWidget(
    name = "jsondiff",
    x,
    width = width,
    height = height,
    package = 'jsondiff',
    elementId = elementId,
    sizingPolicy = htmlwidgets::sizingPolicy(
      padding = 0,
      browser.fill = TRUE,
      knitr.figure = TRUE
    )
  )
}


#' JSON options
#'
#' Helper function for \code{\link[jsonlite]{toJSON}} conversion settings.
#' These arguments are passed to \code{\link[jsonlite]{toJSON}}
#'
#' @param dataframe how to encode data.frame objects: must be one of 'rows',
#'   'columns' or 'values'
#' @param matrix how to encode matrices and higher dimensional arrays: must be
#'   one of 'rowmajor' or 'columnmajor'.
#' @param Date how to encode Date objects: must be one of 'ISO8601' or 'epoch'
#' @param POSIXt how to encode POSIXt (datetime) objects: must be one of
#'   'string', 'ISO8601', 'epoch' or 'mongo'
#' @param factor how to encode factor objects: must be one of 'string' or
#'   'integer'
#' @param complex how to encode complex numbers: must be one of 'string' or
#'   'list'
#' @param raw how to encode raw objects: must be one of 'base64', 'hex' or
#'   'mongo'
#' @param null how to encode NULL values within a list: must be one of 'null' or
#'   'list'
#' @param na how to print NA values: must be one of 'null' or 'string'. Defaults
#'   are class specific
#' @param auto_unbox automatically \code{\link[jsonlite]{unbox}} all atomic
#'   vectors of length 1. It is usually safer to avoid this and instead use the
#'   \code{\link[jsonlite]{unbox}} function to unbox individual elements. An
#'   exception is that objects of class \code{AsIs} (i.e. wrapped in \code{I()})
#'   are not automatically unboxed. This is a way to mark single values as
#'   length-1 arrays.
#' @param digits max number of decimal digits to print for numeric values. Use
#'   \code{I()} to specify significant digits. Use \code{NA} for max precision.
#' @param force unclass/skip objects of classes with no defined JSON mapping
#' @param pretty adds indentation whitespace to JSON output. Can be TRUE/FALSE
#'   or a number specifying the number of spaces to indent. See
#'   \code{\link[jsonlite]{prettify}}
#' @param ... arguments passed on to class specific \code{print} methods
#'
#' @export
json_options <- function (
  dataframe = c("rows", "columns", "values"),
  matrix = c("rowmajor", "columnmajor"),
  Date = c("ISO8601", "epoch"),
  POSIXt = c("string", "ISO8601", "epoch", "mongo"),
  factor = c("string", "integer"),
  complex = c("string", "list"),
  raw = c("base64", "hex", "mongo"),
  null = c("list", "null"),
  na = c("null", "string"),
  auto_unbox = TRUE,
  digits = 4, pretty = FALSE, force = FALSE, ...)
{
  ret <-  list(
    dataframe = match.arg(dataframe),
    matrix = match.arg(matrix),
    Date = match.arg(Date),
    POSIXt = match.arg(POSIXt),
    factor = match.arg(factor),
    complex = match.arg(complex),
    raw = match.arg(raw),
    null = match.arg(null),
    auto_unbox = auto_unbox
  )

  if (!missing(na)) {
    ret$na <- match.arg(na)
  }
  else {
    ret$na <- NULL
  }
  el_args <- list(...)
  if(length(el_args)) {
    ret <- c(ret, el_args)
  }
  ret
}

#' Shiny bindings for jsondiff
#'
#' Output and render functions for using jsondiff within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a jsondiff
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name jsondiff-shiny
#'
#' @export
jsondiffOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(
    outputId, 'jsondiff', width, height, package = 'jsondiff')
}

#' @rdname jsondiff-shiny
#' @export
render_jsondiff <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, jsondiffOutput, env, quoted = TRUE)
}

