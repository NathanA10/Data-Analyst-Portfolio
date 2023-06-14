ggplot(data = dailyactivity, mapping = aes(x = TotalSteps, y = Calories)) + geom_point() +
  geom_smooth() + labs(title = "Calories vs Total Steps") + xlab("Total Steps")
