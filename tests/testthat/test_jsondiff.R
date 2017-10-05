
context("jsondiff widget")

x <- list(
  name = "Pluto", orbital_speed_kms = 4.7, category = "planet",
  composition = c("methane", "nitrogen")
)

y <- list(
  name = "Pluto", category = "dwarf planet", orbital_speed_kms = 4.7,
  composition = c("nitrogen", "methane", "carbon monoxide")
)


test_that("Widget creation", {
  w1 <- jsondiff(x, y)
  expect_is(w1, "htmlwidget")
  expect_is(w1, "jsondiff")
})

test_that("Widget creation", {
  w1 <- jsondiff(jsonlite::toJSON(x), jsonlite::toJSON(y))
  expect_is(w1, "htmlwidget")
  expect_is(w1, "jsondiff")
})

test_that("Widget data", {
  w1 <- jsondiff(x, y)
  w_data <- jsonlite::fromJSON(w1$x)
  expect_equal(w_data$x1, x)
  expect_equal(w_data$x2, y)

  expect(
    all(
      c("x1", "x2", "hideUnchanged", "formatter", "objectHash") %in%
        names(w_data)
    ),

    message = "Not all expected elements in the widget data (x)."
  )
})

