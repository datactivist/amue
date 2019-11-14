FROM trestletech/plumber
MAINTAINER Docker User <docker@user.org>

RUN R -e "install.packages('remotes')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('purrr')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('plotly')"

RUN R -e "remotes::install_github('bergant/airtabler')"


CMD ["plumber.R"]