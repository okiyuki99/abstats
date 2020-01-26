#' Fit Model for detecting novelty effect from Averate Treatment Effect
#'
#' @param ate Averate Treatment Effect, i.e. Expecttaion of Treatment - Expecttaion of Control
#' @param alpha parameter alpha
#' @param gamma parameter gamma
#'
#' @return linear model object
#'
#' @seealso
#'   [How A/B Tests Could Go Wrong: Automatic Diagnosis of Invalid Online Experiments, WSDM2019](https://dl.acm.org/citation.cfm?id=3291000)
#'
#' @examples
#' \dontrun{
#' ate <- rev(1.3^(rnorm(14, 0, 0.3) + 1:14) / 10)
#' fit <- fit_novelty(ate)
#' summary(fit)
#' fit <- fit_novelty(ate, alpha = 0.3, gamma = 2)
#' summary(fit)
#' }
#'
#' @importFrom stats lm
#' @export
fit_novelty <- function(ate, alpha = 0.35, gamma = 2) {
  df <- data.frame(y = ate, x1 = 1 / (seq_len(length(ate)) ^ alpha), x2 = 1 / (seq_len(length(ate)) ^ gamma))
  model <- lm(y ~ x1 + x2, data = df)
  return(model)
}
