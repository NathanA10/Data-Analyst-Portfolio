# Bar graph - Average steps of participants by hour 

hourlysteps = read.csv("hourlySteps.csv")
  
Steps = hourlysteps %>% 
  group_by(MilitaryTime) %>%
  summarise(avg_step = mean(StepTotal))

ggplot(data = Steps) + geom_bar(mapping=aes(x = MilitaryTime, y = avg_step), stat = "identity", fill ="dark green")+
  theme(axis.text.x = element_text(angle = 90)) + labs(title = "Average Steps by Hour") + xlab("Time")+
  ylab("Average Steps") + theme(plot.title = element_text(hjust = 0.5))



# Bar graph - Average intensity of participants by hour

hourlyintensities = read.csv("hourlyIntensities.csv")

Intensity = hourlyintensities %>% 
  group_by(MilitaryTime) %>% 
  summarise(avg_intensity = mean(TotalIntensity))

ggplot(data = Intensity) + geom_bar(mapping=aes(x = MilitaryTime, y = avg_intensity), stat = "identity", fill ="dark green")+
  theme(axis.text.x = element_text(angle = 90)) + labs(title = "Average Intensity by Hour") + xlab("Time")+
  ylab("Average Intensity") + theme(plot.title = element_text(hjust = 0.5))






