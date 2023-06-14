 
ggplot(data = hourlysteps) + geom_histogram(mapping=aes(x = MilitaryTime, y = StepTotal), stat = "identity", fill="dark green")+
  theme(axis.text.x = element_text(angle = 90))

Steps = hourlysteps %>% 
  group_by(MilitaryTime) %>%
  summarise(avg_step = mean(StepTotal))

ggplot(data = Steps) + geom_bar(mapping=aes(x = MilitaryTime, y = avg_step), stat = "identity", fill ="dark green")+
  theme(axis.text.x = element_text(angle = 90)) + labs(title = "Average Steps by Hour") + xlab("Time")+
  ylab("Average Steps") + theme(plot.title = element_text(hjust = 0.5))
  