library(abstats)
context("fit test")

test_that("Test of fit_novelty", {
  set.seed(1234)
  ate <- rev(1.3 ^ (rnorm(14, 0, 0.3) + 1:14) / 10)
  fit <- fit_novelty(ate)
  expect_equal(summary(fit)$r.squared, 0.9977496)
})
