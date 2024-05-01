library(ggplot2)
library(dplyr)
#install.packages("plotly")
#install.packages("hrbrthemes")
library(plotly)
library(hrbrthemes)
library(ggplot2)
library(grid)
library(gridExtra)
library(scales)

# Load rainfall datasets from Ranchbot
E2R<-read.csv("data/weather/2024 ranchbot rain gauges/Escondido 2 Rain Gauge 20240101-20240429.csv")
E2R$Date<-as.POSIXct(E2R$Date, format="%Y-%m-%d")
E2R<-E2R[E2R$Date>="2024-02-01",]
E3R<-read.csv("data/weather/2024 ranchbot rain gauges/Escondido 3 Rain Gauge 20240101-20240429.csv")
E3R$Date<-as.POSIXct(E3R$Date, format="%Y-%m-%d")
E3R<-E3R[E3R$Date>="2024-02-01",]
E5R<-read.csv("data/weather/2024 ranchbot rain gauges/Escondido 5 Rain Gauge Rain Gauge 20231020-20240429.csv")
E5R$Date<-as.POSIXct(E5R$Date, format="%Y-%m-%d")
E5R<-E5R[E5R$Date>="2024-02-01",]

JVR<-read.csv("data/weather/2024 ranchbot rain gauges/Jalama Vaqueros Rain Gauge 20240101-20240429.csv")
JVR$Date<-as.POSIXct(JVR$Date, format="%Y-%m-%d")
O2R<-read.csv("data/weather/2024 ranchbot rain gauges/Oaks 2 Rain Gauge 20240101-20240429.csv")
O2R$Date<-as.POSIXct(O2R$Date, format="%Y-%m-%d")
O5R<-read.csv("data/weather/2024 ranchbot rain gauges/Oaks 5 Rain Gauge 20240101-20240429.csv")
O5R$Date<-as.POSIXct(O5R$Date, format="%Y-%m-%d")
T6R<-read.csv("data/weather/2024 ranchbot rain gauges/Tinta 6 Rain Gauge 20240101-20240429.csv")
T6R$Date<-as.POSIXct(T6R$Date, format="%Y-%m-%d")
T5R<-read.csv("data/weather/2024 ranchbot rain gauges/Tinta 5 Rain Gauge 20240101-20240429.csv")
T5R$Date<-as.POSIXct(T5R$Date, format="%Y-%m-%d")
T10R<-read.csv("data/weather/2024 ranchbot rain gauges/Tinta 10 Rain Gauge Rain Gauge 20240331-20240429.csv")
T10R$Date<-as.POSIXct(T10R$Date, format="%Y-%m-%d")

#merge all together so I can plot with a for loop
raingauge<-rbind(E2R,E3R,E5R,JVR,O2R,O5R,T6R,T5R,T10R)

# Load well depth datasets from ranchbot
E2W<-read.csv("data/wells/2024 ranchbot well depth/Escondido 2 Well 20240101-20240429.csv")
E2W$Date.and.Time<-as.POSIXct(E2W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
E2W<-E2W[E2W$Date.and.Time>="2024-02-01",]
E2W$Date<-format(E2W$Date.and.Time,format="%Y-%m-%d")
E2W$Date<-as.POSIXct(E2W$Date,format="%Y-%m-%d")
E2W<-aggregate(ft..below.ground.~Date,E2W,FUN=mean)

E5W<-read.csv("data/wells/2024 ranchbot well depth/Escondido 5 Well 20231019-20240429.csv")
E5W$Date.and.Time<-as.POSIXct(E5W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
E5W<-E5W[E5W$Date.and.Time>="2024-02-01",]
E5W$Date<-format(E5W$Date.and.Time,format="%Y-%m-%d")
E5W$Date<-as.POSIXct(E5W$Date,format="%Y-%m-%d")
E5W<-aggregate(ft..below.ground.~Date,E5W,FUN=mean)

E3W<-read.csv("data/wells/2024 ranchbot well depth/Escondido3 Well 20240101-20240429.csv")
E3W$Date.and.Time<-as.POSIXct(E3W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
E3W<-E3W[E3W$Date.and.Time>="2024-02-01",]
E3W$Date<-format(E3W$Date.and.Time,format="%Y-%m-%d")
E3W$Date<-as.POSIXct(E3W$Date,format="%Y-%m-%d")
E3W<-aggregate(ft..below.ground.~Date,E3W,FUN=mean)

JVW<-read.csv("data/wells/2024 ranchbot well depth/Jalama vaqueros Well 20240101-20240429.csv")
JVW$Date.and.Time<-as.POSIXct(JVW$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
JVW<-JVW[JVW$Date.and.Time>="2024-02-01",]
JVW$Date<-format(JVW$Date.and.Time,format="%Y-%m-%d")
JVW$Date<-as.POSIXct(JVW$Date,format="%Y-%m-%d")
JVW<-aggregate(ft..below.ground.~Date,JVW,FUN=mean)

#O2W<-read.csv("data/wells/2024 ranchbot well depth/Oaks 2 Well 20240101-20240429.csv")
#O2W$Date.and.Time<-as.POSIXct(O2W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
#O2W<-O2W[O2W$Date.and.Time>="2024-02-01",]
#O2W$Date<-format(O2W$Date.and.Time,format="%Y-%m-%d")
#O2W$Date<-as.POSIXct(O2W$Date,format="%Y-%m-%d")
#O2W<-aggregate(ft..below.ground.~Date,O2W,FUN=mean)

O5W<-read.csv("data/wells/2024 ranchbot well depth/Oaks 5 Well 20240101-20240429.csv")
O5W$Date.and.Time<-as.POSIXct(O5W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
O5W<-O5W[O5W$Date.and.Time>="2024-02-01",]
O5W$Date<-format(O5W$Date.and.Time,format="%Y-%m-%d")
O5W$Date<-as.POSIXct(O5W$Date,format="%Y-%m-%d")
O5W<-aggregate(ft..below.ground.~Date,O5W,FUN=mean)

T2W<-read.csv("data/wells/2024 ranchbot well depth/Tinta 2 Well 20240101-20240429.csv")
T2W$Date.and.Time<-as.POSIXct(T2W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
T2W<-T2W[T2W$Date.and.Time>="2024-02-01",]
T2W$Date<-format(T2W$Date.and.Time,format="%Y-%m-%d")
T2W$Date<-as.POSIXct(T2W$Date,format="%Y-%m-%d")
T2W<-aggregate(ft..below.ground.~Date,T2W,FUN=mean)

T5W<-read.csv("data/wells/2024 ranchbot well depth/Tinta 5 Well 20240101-20240429.csv")
T5W$Date.and.Time<-as.POSIXct(T5W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
T5W<-T5W[T5W$Date.and.Time>="2024-02-01",]
T5W$Date<-format(T5W$Date.and.Time,format="%Y-%m-%d")
T5W$Date<-as.POSIXct(T5W$Date,format="%Y-%m-%d")
T5W<-aggregate(ft..below.ground.~Date,T5W,FUN=mean)

T6W<-read.csv("data/wells/2024 ranchbot well depth/Tinta 6 Well 20240101-20240429.csv")
T6W$Date.and.Time<-as.POSIXct(T6W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
T6W<-T6W[T6W$Date.and.Time>="2024-02-01",]
T6W$Date<-format(T6W$Date.and.Time,format="%Y-%m-%d")
T6W$Date<-as.POSIXct(T6W$Date,format="%Y-%m-%d")
T6W<-aggregate(ft..below.ground.~Date,T6W,FUN=mean)

T10W<-read.csv("data/wells/2024 ranchbot well depth/Tinta 10 Well 20240101-20240429.csv")
T10W$Date.and.Time<-as.POSIXct(T10W$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
T10W<-T10W[T10W$Date.and.Time>="2024-02-01",]
T10W$Date<-format(T10W$Date.and.Time,format="%Y-%m-%d")
T10W$Date<-as.POSIXct(T10W$Date,format="%Y-%m-%d")
T10W<-aggregate(ft..below.ground.~Date,T10W,FUN=mean)

#Oaks 2, Jalama vaqueros and Tinta 2 are gone for now.
Welldepth<-rbind(E2W,E3W,E5W,O5W,T6W,T5W,T10W)
Welldepth<-Welldepth[Welldepth$Date.and.Time>="2024-02-01",]
Welldepth$Date.and.Time<-as.POSIXct(Welldepth$Date.and.Time,format="%Y-%m-%d %H:%M:%S")
#Unify the starting and ending dates for all wells that we use
#Can go back and compare to full E5 recharge
# Plot all datasets
ggplot(Welldepth)+geom_line(aes(x=Date.and.Time,y=ft..below.ground.))+ facet_wrap( ~ Location)

#Need to plot individuals and set cowplot because facet wrap forces same axis.
ggplot(E2W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Escondido 2")+ylab("Feet Below Ground")
ggplot(E3W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Escondido 3")+ylab("Feet Below Ground")
ggplot(E5W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Escondido 5")+ylab("Feet Below Ground")
ggplot(O5W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Oaks 5")+ylab("Feet Below Ground")
ggplot(T6W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Tinta 6")+ylab("Feet Below Ground")
ggplot(T5W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Tinta 5")+ylab("Feet Below Ground")
ggplot(T10W)+geom_line(aes(x=Date,y=ft..below.ground.),linewidth=1.5)+theme_bw()+scale_y_continuous(trans = "reverse")+
  ggtitle("Tinta 10")+ylab("Feet Below Ground")




#################################################################################
#####Calculate groundwater recharge

#First sum all the rain for the year an put it in a dataframe
rainsum<-aggregate(Rain..in.~Location,raingauge,FUN=sum)
rainsum

# Mostly looks good, but there are errors in Tinta 10.
# Get max and min of well level- this will be trickier if there are outliers- should remove in plotting function






###Testing hydrograph

#E2
g1 <- ggplot(E2R, aes(Date, Rain..in.)) +
  geom_bar(stat = 'identity', fill = "lightblue", color="black") +
  theme_bw() +
  ylab("Precip.") +
  labs(title = "Escondido 2") +
  scale_y_reverse(labels = label_number(accuracy = 0.1))+
  theme(axis.title.x    = element_blank(),
        axis.text.x     = element_blank(),
        axis.ticks.x    = element_blank())

g2 <- ggplot(E2W, aes(Date, ft..below.ground.))+
  geom_line() +
  ylab("Well Depth") +
  theme_bw() +scale_y_continuous(trans = "reverse")
g1 <- ggplot_gtable(ggplot_build(g1))
g2 <- ggplot_gtable(ggplot_build(g2))
maxWidth = unit.pmax(g1$widths[2:3], g2$widths[2:3])

g1$widths[2:3] <- maxWidth
g2$widths[2:3] <- maxWidth
grid.arrange(g1, g2, ncol = 1, heights = c(1, 3))














