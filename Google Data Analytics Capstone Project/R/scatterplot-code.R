# Scatter plot - Calories vs Total Steps

dailyactivity = read.csv("dailyActivity.csv")

ggplot(data = dailyactivity, mapping = aes(x = TotalSteps, y = Calories)) + geom_point() +
  geom_smooth() + labs(title = "Calories vs Total Steps") + xlab("Total Steps") +
  theme(plot.title = element_text(hjust = 0.5))


# Scatter plot - Total Minutes Asleep vs Sedentary Minutes
# Merged two data frames by Id and date

dailysleep = read.csv("SleepDay.csv")

merged_act_sleep = merge(dailyactivity, dailysleep, by=c('Id', 'date'))

ggplot(data = merged_act_sleep) + geom_point(mapping = aes(x = SedentaryMinutes, y = TotalMinutesAsleep)) +
  labs(title = "Total Minutes Asleep vs Sedentary Minutes") + xlab("Sedentary Minutes") +
  ylab("Total Minutes Asleep") + theme(plot.title = element_text(hjust = 0.5))
