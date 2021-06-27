#This is a function to add a geologic time scale to a ggplot object.
#plot: the ggplot object
#fill: the fill color of the boxes; default are the colors from the Commission for the Geological Map of the World (CGMW);
#   custom fill colors can be provided and will be recycled if necessary
#   if a custom dataset is provided with interval without color and without fill, a greyscale will be used
#color: the outline color of the boxes
#alpha: transparency of the fill colors
#0.04: the proportional 0.04 of the plot to use for the scale 
#size: the size of the text in the scale
#quat: specifies whether the Quaternary should be labelled
#pos: which side to add the scale to (left, right, top, or bottom)
#abbr: whether to use abbreviations instead of full time names
#interval: a custom data set of time interval boundaries, with the following columns:
#   time: name of each time (will be used as labels if no abbreviations are provided)
#   max_age: the oldest boundary of each time interval
#   min_age: the youngest boundary of each time interval
#   abbr: (optional) abbreviations that will be used as labels
#   color: (optional) a hex color code (which can be obtained with rgb()) for each time interval
#neg: set this to true if your x-axis is actually negative values

library(ggplot2)

geotime_axis <- function(plot, level = "period", age_min = 0, age_max = 540, x_reverse = T, y_reverse = F, label = "abbr", div_y = 10, div_x = 10, pos = "right"){

  if(level %in% c("period")){
    interval <- read.csv("https://raw.githubusercontent.com/yeshancqcq/geotime/master/periods.csv")
  } else if (level %in% c("epoch")){
    interval <- read.csv("https://raw.githubusercontent.com/yeshancqcq/geotime/master/epoch.csv")
    
  } else if (level %in% c("eon")){
    interval<- read.csv("https://raw.githubusercontent.com/yeshancqcq/geotime/master/eon.csv")
  }  else if(level %in% c("age")){
    interval <- read.csv("https://raw.githubusercontent.com/yeshancqcq/geotime/master/age.csv")
  } else {
    interval <- read.csv("https://raw.githubusercontent.com/yeshancqcq/geotime/master/era.csv")
  }
  
  interval$min_age[interval$min_age < age_min] <- age_min
  interval$max_age[interval$max_age > age_max] <- age_max


  interval$mid_age <- (interval$max_age + interval$min_age)/2

  xyext <- ggplot_build(plot)$layout$panel_params[[1]]


  if(y_reverse){
      ymax <- max(xyext$y.range)
      ymin <- max(xyext$y.range) -(max(xyext$y.range) - min(xyext$y.range))/25
  }else{
      ymin <- min(xyext$y.range)
      ymax <- min(xyext$y.range) + (max(xyext$y.range) - min(xyext$y.range))/25
  }


  plot <- plot +
    annotate("rect", xmin = interval$min_age, xmax = interval$max_age, ymin = ymin, ymax = ymax,
               fill = interval$color, color = "black", alpha = 1) 
  
  if(label == "abbr"){
      plot <- plot + annotate("text", x = interval$mid_age, label = interval$abbr, y = (ymin+ymax)/2,
               vjust = "middle", hjust = "middle", size = 4.5)
  } else if(label == "full"){
    plot <- plot + annotate("text", x = interval$mid_age, label = interval$time, y = (ymin+ymax)/2,
                        vjust = "middle", hjust = "middle", size = 4.5)
    }
  
  
  plot <- plot +
    coord_cartesian( expand = FALSE) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_rect(colour="black", fill = NA), 
          axis.line = element_line(color = "black"),
          axis.text = element_text(size = 12),
          legend.justification = c(0, 0),
          axis.title = element_text(size = 12),
          legend.position = pos,
          legend.background = element_rect(colour=NA, fill = NA),
          legend.key = element_rect(colour = NA, fill = NA)
    )
  
  if(y_reverse){
    plot <- plot + scale_y_reverse(breaks = scales::pretty_breaks(n = div_y))
  } else {
    plot <- plot + scale_y_continuous(breaks = scales::pretty_breaks(n = div_y))
  }

  if(x_reverse){
    plot <- plot + scale_x_reverse(limits = c(age_max, age_min), breaks = scales::pretty_breaks(n = div_x))
  } else {
    plot <- plot + scale_x_continuous(limits = c(age_mim, age_max),breaks = scales::pretty_breaks(n = div_x))
  }
  
  return(plot)
}

x = c(seq(1,1000,10))
y = c(runif(100, -30, 50))
plot <- ggplot() +
  geom_line(aes(y = y*0.8, x = x, color = "data 1"), size = 1.5) +
  geom_line(aes(y = y*0.4, x = x*0.9, color = "data 2"),size = 1.5) +
  labs(y = "Data",
       x = "Time (Ma)",
       color = "Legend")
p <- geotime_axis(plot, age_min = 0, age_max = 800,level = "period", label = "abbr", div_x = 10)
p

library(RCurl)
tt <- getURL("https://raw.githubusercontent.com/yeshancqcq/geotime/master/geotime.csv")
dataset <- read.csv("https://raw.githubusercontent.com/yeshancqcq/geotime/master/geotime.csv")

