
stereograph <- function(strike, dip){
  plunge = 90 - dip
  if(strike - 90 < 0){
    trend = strike + 270
  } else {
    trend = strike - 90
  }
  trendlabel = round(trend, digits=4)
  plungelabel = round(plunge, digits=4)
  helper <- function(dt){
    return(1 - dt**2)
  }
  par(mar = c(0.5, 0, 0.5, 0))
  sp::plot(0, 0, pch = '', asp = 1, ann = FALSE, xlim = c(-1, 1), ylim = c(-1, 1), axes = FALSE)
  text(0, 1.02, "N", adj = c(.5, 0), cex = 0.8)
  text(0.75,0.75, "NE", adj = c(.5, 0), cex = 0.8)
  text(1.1, 0, "E", adj = c(.5, 0), cex = 0.8)
  text(0.75,-0.75, "SE", adj = c(.5, 0), cex = 0.8)
  text(0,-1.05, "S", adj = c(.5, 0), cex = 0.8)
  text(-0.75,-0.75, "SW", adj = c(.5, 0), cex = 0.8)
  text(-1.1, 0, "W", adj = c(.5, 0), cex = 0.8)
  text(-0.75,0.75, "NW", adj = c(.5, 0), cex = 0.8)
  lines(cos(seq(0,  6.283, length = 720)), sin(seq(0, 6.283, length = 720)))
  eps = seq(0, 3.1415, 0.17452) - 1.57075
  for (arcs in seq(-1.57075, 1.57075, 0.08726)) {
    x = (0.707105) * sin(eps) * cos(arcs) * (2/(1 + cos(arcs) * cos(eps))) ** 0.5
    y = (0.707105) * sin(arcs) * (2/(1 + cos(arcs) * cos(eps))) ** 0.5
    lines(x, y, lwd = .5, col = 'pink')
  }
  arcs_v <- seq(-1.57075, 1.57075, 0.08726)
  for (arcs in seq(0.17452, 2.9669, 0.17452)) {
    x = (0.707105) * sin(arcs - 1.57075) * cos(arcs_v) *  (2/(1 + cos(arcs_v) * cos(arcs - 1.57075))) ** 0.5
    y = (0.707105) * sin(arcs_v) * (2/(1 + cos(arcs_v) * cos(arcs - 1.57075))) ** 0.5 
    lines(x, y, lwd = .5, col = 'pink')
  }
  trend <-  trend * (3.1415 / 180) + 3.1415
  plunge <- plunge * (3.1415 / 180) - 1.57075
  lng_dt <- 1.41421 * sin(plunge / 2) * sin(trend)
  lat_dt <- 1.41421 * sin(plunge / 2) * cos(trend)
  points(lng_dt, lat_dt, pch = 22, col = 'blue', cex = 1)
  label = paste("trend: ",toString(trendlabel), sep = "")
  label2 = paste("plunge: ",toString(plungelabel), sep = "")
  text(lng_dt + .025, lat_dt + 0.025, label2, cex = 1, adj = c(0, 0))
  text(lng_dt + .025, lat_dt + 0.125, label, cex = 1, adj = c(0, 0))
  strike <- strike * (3.1415 / 180)
  dip <-  dip * (3.1415 / 180)
  arcs_v <- seq(from = (-1 * 1.57075), to = (1.57075), length = 720)
  if(dip != 0){
    lambda <- 1.57075 - dip
    check_neg <- sapply( sin(arcs_v) / sin(acos(cos(arcs_v) * cos(lambda))), function(x){1 - x**2})
    check_neg[which(check_neg < 0)] <- 0
    x_bar <- 1.41421 * sin(acos(cos(arcs_v) * cos(lambda)) / 2) * sqrt(check_neg)
    y_bar <- 1.41421 * sin(acos(cos(arcs_v) * cos(lambda)) / 2) *  sin(arcs_v) / sin(acos(cos(arcs_v) * cos(lambda)))
  }else{
    x_bar <- c(sin(arcs_v + 1.57075), sin(arcs_v - 1.57075))
    y_bar <- c(cos(arcs_v + 1.57075), cos(arcs_v - 1.57075))
  }
  lng_dt <- cos(strike) * x_bar + sin(strike) * y_bar
  lat_dt <- -1 * sin(strike) * x_bar + cos(strike) * y_bar
  lines(lng_dt, lat_dt, col = "blue", lwd = 1)
  lines(c(-1, 1), c(0, 0), lwd = 1.5, col = "red")
  lines(c(0, 0), c(-1, 1), lwd = 1.5, col = "red")
  
}

strike <- runif(min = 0, max = 360, n = 1)
dip <- runif(min = 0, max = 90, n = 1)


stereograph(strike, dip)
#plot(0, 0, pch = '')
