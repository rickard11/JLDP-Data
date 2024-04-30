library(ggplot2)
library(dplyr)
#install.packages("plotly")
#install.packages("hrbrthemes")
library(plotly)
library(hrbrthemes)

# Load rainfall datasets from Ranchbot
Tinta3<-read.csv("tinta3.csv")

colnames(data)<-c("date","Jalama_HQ","Oaks","Sutter","Tinta","Army Camp","Bunker Hill","Cistern",
                  "Cojo HQ","Jalachichi","Ramajal","Repeator")
data$date <- as.POSIXct(data$date,format="%Y-%m-%d %H:%M:%S")

# Usual area chart

p<-data %>%
  ggplot( aes(x=date, y=Oaks)) +
  geom_area(fill="#69b3a2", alpha=0.5) +
  geom_line(color="#69b3a2") +
  ylab("Rainfall (mm)") +
  theme_ipsum()

# Turn it interactive with ggplotly
p <- ggplotly(p)
p




#Now read in the available pressure transducer data
#Note there is a lot more PT data for earlier years, but no dendra data (look for weather data elsewhere to use this data)

Oaks2$date<-as.POSIXct(Oaks2$date, format="%Y/%m/%d")
Oaks2$datetime<-paste0(Oaks2$date," ",substr(Oaks2$time,1,8))
Oaks2$datetime<-as.POSIXct(Oaks2$datetime,format="%Y-%m-%d %H:%M:%S")
Oaks2

colnames(Oaks1)[1]<-"date"
Oaks1$date<-as.POSIXct(Oaks1$date, format="%m/%d/%Y")
Oaks1$datetime<-paste0(Oaks1$date," ",Oaks1$Time)
Oaks1$datetime<-as.POSIXct(Oaks1$datetime,format="%Y-%m-%d %I:%M:%S %p")
Oaks1

Tinta3$date<-as.POSIXct(Tinta3$date, format="%Y/%m/%d")
Tinta3$datetime<-paste0(Tinta3$date," ",substr(Tinta3$time,1,8))
Tinta3$datetime<-as.POSIXct(Tinta3$datetime,format="%Y-%m-%d %H:%M:%S")
Tinta3

#Next Merge them together into one dataset

#Next plot them

#Next pull out individual storm data

