



<img src="img/jsondiff.png" align="right" />

# jsondiff

[![Build Status](https://travis-ci.org/bergant/jsondiff.svg?branch=master)](https://travis-ci.org/bergant/jsondiff)

## Overview

**jsondiff** finds and renders difference in values between JSONs. Diffing R
objects (like lists and dataframes) is also supported by automatic conversion 
to JSON. It is implemented as an R interface to
[jsondiffpatch](https://github.com/benjamine/jsondiffpatch), powered by
[htmlwidgets](http://www.htmlwidgets.org/) framework.

## Installation 


```r
devtools::install_github("bergant/jsondiff")
```


## Usage 

Compare two lists:


```r
x <- list(
  name = "Pluto", orbital_speed_kms = 4.7, category = "planet", 
  composition = c("methane", "nitrogen")
)

y <- list(
  name = "Pluto", category = "dwarf planet", orbital_speed_kms = 4.7, 
  composition = c("nitrogen", "methane", "carbon monoxide")
)

library(jsondiff)

jsondiff(x, y)
```

![](img/fig-list-1.png)<!-- -->

Show also unchanged data:

```r
jsondiff(x, y, hide_unchanged = FALSE)
```

![](img/fig-list_unchanged-1.png)<!-- -->



Character vectors of size 1 are evaluated as JSONs:


```r
library(jsonlite)
json_x <- toJSON(x) 
json_y <- toJSON(y) 

jsondiff(json_x, json_y)
```

![](img/fig-json-1.png)<!-- -->

Data frames (example is from
[daff](https://github.com/edwindj/daff) package, which is probably a better 
choice to handle difference between data frames than **jsondiff**):


```r
x <- y <- iris[1:3,]

x <- head(x,2) # remove a row
x[1,1] <- 10 # change a value
x$hello <- "world"  # add a column
x$Species <- NULL # remove a column


jsondiff(y, x)
```

![](img/fig-dataframe-1.png)<!-- -->

Note that there are several options when converting R objects to JSON. Instead
of using `toJSON` explicitly, one can use `json_options`. For example, 
converting from data frame to JSON as "column first":


```r
jsondiff(y, x, json_opt = json_options(dataframe = "columns", factor = "string"))
```

![](img/fig-dataframe_cols-1.png)<!-- -->


## Related projects

Made possible by:

- [jsondiffpatch](https://github.com/benjamine/jsondiffpatch) - Diffing and patching JSONs (JavaScript library)
- [htmlwidgets](https://github.com/ramnathv/htmlwidgets) - Framework for easily creating R bindings to JavaScript libraries
- [jsonlite](https://github.com/jeroen/jsonlite) - A Robust, High Performance JSON Parser and Generator for R 

See also:

- [Daff](https://github.com/edwindj/daff) - Diff, patch and merge for data.frames
- [listviewer](https://github.com/timelyportfolio/listviewer) - R htmlwidget to view lists
- [diffobj](https://github.com/brodieG/diffobj) - Compare R Objects with a Diff
- [tools::Rdiff](https://stat.ethz.ch/R-manual/R-devel/library/tools/html/Rdiff.html): Difference R Output Files


## License

MIT

