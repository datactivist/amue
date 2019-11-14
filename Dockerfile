FROM rocker/r-base
MAINTAINER Joel Gombin <joel@datactivist.coop>
RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev

RUN R -e 'install.packages("purrr", repo = "http://cran.irsn.fr/")'
RUN R -e 'install.packages("dplyr", repo = "http://cran.irsn.fr/")'
RUN R -e 'install.packages("ggplot2", repo = "http://cran.irsn.fr/")'
RUN R -e 'install.packages("plotly", repo = "http://cran.irsn.fr/")'
RUN R -e 'install.packages("remotes", repo = "http://cran.irsn.fr/")'
RUN R -e 'remotes::install_github("trestletech/plumber", ref = "do-swagger")'
RUN R -e 'remotes::install_github("bergant/airtabler")'
RUN mkdir /usr/scripts
COPY torun.R /usr/scripts/torun.R
COPY plumber.R /usr/scripts/plumber.R
EXPOSE 9107
CMD Rscript /usr/scripts/torun.R
