FROM rocker/shiny:latest

# Maintainer information
LABEL maintainer="VPS Calculator Team"
LABEL description="VPS Calculator Shiny Application"

# Install system dependencies if needed
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R package dependencies
RUN R -e "install.packages(c('shiny', 'shinydashboard'), repos='https://cran.rstudio.com/')"

# Remove default shiny server apps
RUN rm -rf /srv/shiny-server/*

# Copy app files to shiny server directory
COPY app.R /srv/shiny-server/
COPY DESCRIPTION /srv/shiny-server/
COPY www /srv/shiny-server/www
COPY data /srv/shiny-server/data
COPY R /srv/shiny-server/R

# Make sure the directory permissions are correct
RUN chown -R shiny:shiny /srv/shiny-server

# Expose the Shiny Server port
EXPOSE 3838

# Run Shiny Server
CMD ["/usr/bin/shiny-server"]
