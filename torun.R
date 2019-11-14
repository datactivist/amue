library(plumber)
pr <- plumb("/usr/scritps/plumber.R")
pr$run(host='0.0.0.0', port = 9107, swagger = TRUE)