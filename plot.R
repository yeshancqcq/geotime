#This is a function to add a geologic time scale to a ggplot object.
#gg: the ggplot object
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

gggeo_scale <- function(gg, level = "period", age_min = 0, age_max = 540, x_reverse = T, y_reverse = F, label = "abbr", div_y = 10, div_x = 10, pos = "right"){

  if(level %in% c("period")){
    interval <- data.frame(time = c("Quaternary" ,"Neogene" ,"Paleogene" ,"Cretaceous" ,"Jurassic" ,"Triassic" ,"Permian" ,"Carboniferous", "Devonian" ,"Silurian" ,"Ordovician" ,"Cambrian" ,"Ediacaran" ,"Cryogenian","Tonian" ,"Stenian" ,"Ectasian" ,"Calymmian" ,"Statherian" ,"Orosirian" ,"Rhyacian","Siderian" ,"Neoarchean" ,"Mesoarchean" ,"Paleoarchean" ,"Eoarchean" ,"Hadean" ),
                          max_age = c(2.588,23.03,66,145,201.3,251.902,298.9,358.9,419.2,443.8,485.400,541,635,720,1000,1200,1400,1600,1800,2050,2300,2500,2800,3200,3600,4000,4600),
                          min_age = c(0,2.588,23.03, 66,145,201.3,251.902,298.9,358.9,419.2,443.8,485.4,541,635 ,720 ,1000 ,1200 ,1400 ,1600 ,1800 ,2050 ,2300 ,2500 ,2800 ,3200 ,3600,4000 ),
                          abbr = c("Q","N","Pg","K","J","Tr","P","C","D","S","O","Cm","Ed","Cr","To","Ste","Ec","Ca","Sta","Or","Rh","Si","Nar","Mar","Par","Ear","Ha"),
                          color = c("#F9F97F","#FFE619","#FD9A52","#7FC64E","#34B2C9","#812B92","#F04028","#67A599","#CB8C37","#B3E1B6","#009270","#7FA056","#FFC3E1","#FFAFD7","#FFA5D2","#FFA5D2","#FF98CC","#FF8BC5","#EE93C1","#E874AF","#EB84B8","#E874AF","#FF5CAD","#E62E8A","#CC297A","#B2246B","grey70"),
                          stringsAsFactors = FALSE)
  } else if (level %in% c("epoch")){
    interval<-data.frame(time=c("Holocene","Pleistocene","Pliocene","Miocene","Oligocene","Eocene","Paleocene","Late Cretaceous","Early Cretaceous","Late Jurassic","Middle Jurassic","Early Jurassic","Late Triassic","Middle Triassic","Early Triassic","Lopingian","Guadalupian","Cisuralian","Pennsylvanian","Mississippian","Late Devonian","Middle Devonian","Early Devonian","Pridoli","Ludlow","Wenlock","Llandovery","Late Ordovician","Middle Ordovician","Early Ordovician","Furongian","Miaolingian","Series,2","Terreneuvian","Ediacaran","Cryogenian","Tonian","Stenian","Ectasian","Calymmian","Statherian","Orosirian","Rhyacian","Siderian","Neoarchean","Mesoarchean","Paleoarchean","Eoarchean","Hadean"),
                         max_age=c(0.0117,2.5880,5.3330,23.0300,33.9,56,66,100.5,145,163.5,174.1,201.3,237,247.2,251.9020,259.1,272.9500,298.9,323.2,358.9,382.7,393.3,419.2,423,427.4,433.4,443.8,458.4,470,485.4,497,509,521,541,635,720,1000,1200,1400,1600,1800,2050,2300,2500,2800,3200,3600,4000,4600),
                         min_age=c(0,0.0117,2.5880,5.3330,23.0300,33.9,56,66,100.5,145,163.5,174.1,201.3,237,247.2,251.9020,259.1,272.9500,298.9,323.2,358.9,382.7,393.3,419.2,423,427.4,433.4,443.8,458.4,470,485.4,497,509,521,541,635,720,1000,1200,1400,1600,1800,2050,2300,2500,2800,3200,3600,4000),
                         abbr=c("H","Ple","Pli","Mi","Ol","Eo","Pa","LK","EK","LJ","MJ","EJ","LTr","MTr","Etr","Lop","Gu","Ci","Pn",
                                "Ms","LD","MD","ED","Pr","Lu","We","Ll","LO","MO","EO","Fu","Ml","S2","Te","Ed","Cr","To","Ste","Ec",
                                "Ca","Sta","Or","Rh","Si","Nar","Mar","Par","Ear","Ha"),
                         color=c("#FEF2E0","#FFF2AE","#FFFF99","#FFFF00","#FDC07A","#FDB46C","#FDA75F","#A6D84A","#8CCD57","#B3E3EE","#80CFD8",
                                 "#42AED0","#BD8CC3","#B168B1","#983999","#FBA794","#FB745C","#EF5845","#99C2B5","#678F66","#F1E19D","#F1C868",
                                 "#E5AC4D","#d8f5c9","#BFE6CF","#B3E1C2","#99D7B3","#7FCA93","#4DB47E","#1A9D6F","#B3E095","#A6CF86","#99C078","#8CB06C",
                                 "#FFC3E1","#FFAFD7","#FFA5D2","#FFA5D2","#FF98CC","#FF8BC5","#EE93C1","#E874AF","#EB84B8","#E874AF","#FF5CAD",
                                 "#E62E8A","#CC297A","#B2246B","grey70"),
                         stringsAsFactors=FALSE)
    
  }else if (level %in% c("eon")){
    interval<-data.frame(time=c("Phanerozoic","Proterozoic","Archean","Hadean"),
                         max_age=c(541,2500,4000,4600),
                         min_age=c(0,541,2500,4000),
                         abbr=c("Pha","Prot","Arch","Ha"),
                         color=c("#9AD9DD","#FF70B8","#FF3399","grey70"),
                         stringsAsFactors=FALSE)
  } else {
    interval<-data.frame(time=c("Cenozoic","Mesozoic","Paleozoic","Neoproterozoic","Mesoproterozoic","Paleoproterozoic","Neoarchean","Mesoarchean","Paleoarchean","Eoarchean","Hadean"),
    max_age=c(66,251.902,541,1000,1600,2500,2800,3200,3600,4000,4600),
    min_age=c(0,66,251.902,541,1000,1600,2500,2800,3200,3600,4000),
    color=c("#F2F91D","#67C5CA","#99C08D","#FF9BCD","#FF7EBF","#E665A6","#FF5CAD","#E62E8A","#CC297A","#B2246B","grey70"),
    abbr=c("Ce","Me","Pa","NP","MP","PP","Nar","Mar","Par","Ear","Ha"),
    stringsAsFactors=FALSE)
  }
  
  interval$min_age[interval$min_age < age_min] <- age_min
  interval$max_age[interval$max_age > age_max] <- age_max


  interval$mid_age <- (interval$max_age + interval$min_age)/2

  xyext <- ggplot_build(gg)$layout$panel_params[[1]]


  if(y_reverse){
      ymax <- max(xyext$y.range)
      ymin <- max(xyext$y.range) - 0.04 * (max(xyext$y.range) - min(xyext$y.range))
  }else{
      ymin <- min(xyext$y.range)
      ymax <- min(xyext$y.range) + 0.04 * (max(xyext$y.range) - min(xyext$y.range))
  }


  gg <- gg +
    annotate("rect", xmin = interval$min_age, xmax = interval$max_age, ymin = ymin, ymax = ymax,
               fill = interval$color, color = "black", alpha = 1) 
  
  if(label == "abbr"){
      gg <- gg + annotate("text", x = interval$mid_age, label = interval$abbr, y = (ymin+ymax)/2,
               vjust = "middle", hjust = "middle", size = 4.5)
  } else if(label == "full"){
    gg <- gg + annotate("text", x = interval$mid_age, label = interval$time, y = (ymin+ymax)/2,
                        vjust = "middle", hjust = "middle", size = 4.5)
    }
  
  
  gg <- gg +
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
    gg <- gg + scale_y_reverse(breaks = scales::pretty_breaks(n = div_y))
  } else {
    gg <- gg + scale_y_continuous(breaks = scales::pretty_breaks(n = div_y))
  }

  if(x_reverse){
    gg <- gg + scale_x_reverse(limits = c(age_max, age_min), breaks = scales::pretty_breaks(n = div_x))
  } else {
    gg <- gg + scale_x_continuous(limits = c(age_mim, age_max),breaks = scales::pretty_breaks(n = div_x))
  }
  
  return(gg)
}

x = c(0,9,20,50,120,170,250,321,500,520)
y = c(0,3,12,14,22,32,44,45,66,70)
gg <- ggplot() +
  geom_line(aes(y = y, x = x))
p <- gggeo_scale(gg, age_min = 0, age_max = 3000,level = "era", label = "none", div_x = 20)
p
