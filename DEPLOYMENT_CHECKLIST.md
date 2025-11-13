# Deployment Checklist for VPS Calculator Shiny App

## Pre-Deployment

- [ ] R (>= 3.5.0) is installed
- [ ] Required packages are installed (`shiny`, `shinydashboard`)
- [ ] App runs successfully locally with `shiny::runApp()`
- [ ] All dependencies are listed in DESCRIPTION file
- [ ] Static assets are in the `www/` directory
- [ ] Data files are in the `data/` directory

## Choose Your Deployment Method

### Option 1: Shinyapps.io (Cloud - Easiest)
- [ ] Create account at https://www.shinyapps.io/
- [ ] Install `rsconnect` package
- [ ] Configure account credentials
- [ ] Run `rsconnect::deployApp()`
- [ ] Test deployed app

### Option 2: Shiny Server (Self-hosted)
- [ ] Install Shiny Server on your server
- [ ] Copy app directory to `/srv/shiny-server/`
- [ ] Configure server settings in `/etc/shiny-server/shiny-server.conf`
- [ ] Restart Shiny Server: `sudo systemctl restart shiny-server`
- [ ] Test at `http://your-server:3838/vps_calculator/`

### Option 3: RStudio Connect (Enterprise)
- [ ] Access to RStudio Connect server
- [ ] Install `rsconnect` package
- [ ] Configure Connect server credentials
- [ ] Deploy with `rsconnect::deployApp()`
- [ ] Configure access permissions

### Option 4: Docker Container
- [ ] Create Dockerfile (example in README.md)
- [ ] Build image: `docker build -t vps-calculator .`
- [ ] Run container: `docker run -p 3838:3838 vps-calculator`
- [ ] Test at `http://localhost:3838/vps_calculator/`

## Post-Deployment

- [ ] Verify app loads correctly
- [ ] Test all interactive features (sliders, dropdowns)
- [ ] Verify calculations are accurate
- [ ] Check mobile responsiveness
- [ ] Monitor app logs for errors
- [ ] Set up monitoring/analytics (optional)

## Security Considerations

- [ ] Use HTTPS for production deployments
- [ ] Configure authentication if needed
- [ ] Review and limit app permissions
- [ ] Keep R and packages updated
- [ ] Regular security audits

## Maintenance

- [ ] Regular backups of app directory
- [ ] Monitor resource usage
- [ ] Update dependencies periodically
- [ ] Review and update pricing model as needed
- [ ] Collect user feedback
