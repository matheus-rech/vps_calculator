# Helper functions for VPS Calculator

# Calculate base cost for a component
calculate_component_cost <- function(quantity, price_per_unit) {
  return(quantity * price_per_unit)
}

# Apply regional pricing multiplier
apply_regional_multiplier <- function(base_cost, region) {
  multipliers <- list(
    "US East" = 1.0,
    "US West" = 1.1,
    "Europe" = 1.15,
    "Asia Pacific" = 1.2
  )
  
  multiplier <- multipliers[[region]]
  if (is.null(multiplier)) {
    multiplier <- 1.0
  }
  
  return(base_cost * multiplier)
}

# Format currency
format_currency <- function(amount) {
  return(paste0("$", format(round(amount, 2), nsmall = 2)))
}
