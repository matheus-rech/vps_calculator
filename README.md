# VPS Calculator - Shiny App

A Shiny application for calculating Virtual Private Server (VPS) costs based on resource requirements.

## Features

- Interactive configuration of CPU, RAM, Storage, and Bandwidth
- Regional pricing variations
- Real-time cost calculations
- Monthly and yearly cost estimates
- Detailed pricing breakdown

## Prerequisites

- R (>= 3.5.0)
- Required R packages:
  - shiny (>= 1.7.0)
  - shinydashboard (>= 0.7.0)

## Installation

1. Install R from [CRAN](https://cran.r-project.org/)

2. Install required packages:
```r
install.packages(c("shiny", "shinydashboard"))
```

## Running Locally

To run the app locally:

```r
# In R console or RStudio
shiny::runApp()
```

Or from the command line:
```bash
R -e "shiny::runApp()"
```

The app will be available at `http://localhost:8100` (or another port if specified).

## Deployment Options

### 1. Shinyapps.io (Recommended for beginners)

```r
# Install rsconnect package
install.packages("rsconnect")

# Configure your account (get tokens from shinyapps.io)
rsconnect::setAccountInfo(
  name = "your-account-name",
  token = "your-token",
  secret = "your-secret"
)

# Deploy the app
rsconnect::deployApp()
```

### 2. Shiny Server (Open Source)

1. Install Shiny Server on your server
2. Copy the app directory to `/srv/shiny-server/vps_calculator/`
3. Access at `http://your-server:3838/vps_calculator/`

### 3. RStudio Connect

```r
# Install rsconnect package
install.packages("rsconnect")

# Configure your RStudio Connect server
rsconnect::addConnectServer(
  url = "https://your-connect-server.com",
  name = "myserver"
)

# Deploy
rsconnect::deployApp(server = "myserver")
```

### 4. Docker Deployment

Create a `Dockerfile`:
```dockerfile
FROM rocker/shiny:latest

# Install R dependencies
RUN R -e "install.packages(c('shiny', 'shinydashboard'), repos='https://cran.rstudio.com/')"

# Copy app files
COPY . /srv/shiny-server/vps_calculator/

# Expose port
EXPOSE 3838

# Run Shiny Server
CMD ["/usr/bin/shiny-server"]
```

Build and run:
```bash
docker build -t vps-calculator .
docker run -p 3838:3838 vps-calculator
```

## Directory Structure

```
vps_calculator/
├── app.R              # Main Shiny application file
├── DESCRIPTION        # Package dependencies
├── README.md          # This file
├── .gitignore         # Git ignore rules
├── www/               # Static assets (CSS, JS, images)
├── data/              # Data files
└── R/                 # Additional R scripts/modules
```

## Configuration

The app uses a simple pricing model that can be customized in `app.R`:

- CPU: $10 per core per month
- RAM: $5 per GB per month
- Storage: $0.10 per GB per month
- Bandwidth: $2 per TB per month

Regional multipliers:
- US East: 1.0x
- US West: 1.1x
- Europe: 1.15x
- Asia Pacific: 1.2x

## Customization

To customize the pricing model, edit the pricing calculations in the `server` function in `app.R`.

To add new regions or modify multipliers, update the `region_multiplier` switch statement.

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License