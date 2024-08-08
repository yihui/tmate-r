install.packages('gsDesign2', quiet = TRUE)

library(gsDesign2)

ratio = 1

enroll_rate = define_enroll_rate(duration = c(2, 2, 8), rate = c(1, 2, 3))

fail_rate = define_fail_rate(
  duration = c(4, Inf), fail_rate = log(2) / 12, hr = c(1, .6), dropout_rate = .001
)

alpha = 0.025
beta = 0.1

upper = gs_spending_bound
upar = list(sf = gsDesign::sfLDOF, total_spend = alpha)
test_upper = rep(TRUE, 2)

lower = gs_spending_bound
lpar = list(sf = gsDesign::sfLDOF, total_spend = beta)
test_lower = c(TRUE, FALSE)
binding = FALSE

info_frac = NULL
analysis_time = c(24, 36)

x = gs_design_ahr(
  enroll_rate = enroll_rate, fail_rate = fail_rate, 
  alpha = alpha, beta = beta, ratio = ratio,
  info_frac = info_frac, analysis_time = analysis_time, 
  upper = upper, upar = upar, test_upper = test_upper,
  lower = lower, lpar = lpar, test_lower = test_lower,
  binding = binding
)

event = x$analysis$event
event_new = c(floor(event[1]), ceiling(event[2]))
sample_size_new = (ceiling(x$analysis$n[2] / 2) * 2)  # 454L
enroll_rate = x$enroll_rate
enroll_rate_new = within(enroll_rate, {
  rate = rate * sample_size_new / x$analysis$n[2]
})
with(enroll_rate_new, sum(rate * duration)) - 454
