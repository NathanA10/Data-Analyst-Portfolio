--Average Steps on each DayofWeek--
SELECT 
DayOfWeek,
AVG(TotalSteps) as AverageSteps

FROM fitbit_data.daily_activity

LEFT JOIN fitbit_data.daily_sleep

ON daily_activity.id = daily_sleep.id
AND daily_activity.ActivityDate = daily_sleep.SleepDay

GROUP BY DayOfWeek 

ORDER BY AverageSteps DESC
