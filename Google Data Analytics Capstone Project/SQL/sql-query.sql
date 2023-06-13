--Number of participants-----

SELECT 

COUNT (DISTINCT ID) AS num_of_participants  

FROM fitbit_data.daily_activity 


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

---------

--Device usage on Day activity--
SELECT 
ID,
COUNT(DISTINCT ActivityDate) AS num_days_used,
CASE
  WHEN COUNT(DISTINCT ActivityDate) >= 0 AND COUNT(DISTINCT ActivityDate) <= 10 THEN 'low usage'
  WHEN COUNT(DISTINCT ActivityDate) >= 11 AND COUNT(DISTINCT ActivityDate) <= 20 THEN 'medium usage'
  WHEN COUNT(DISTINCT ActivityDate) >= 21 AND COUNT(DISTINCT ActivityDate) <= 31 THEN 'high usage'
END AS device_usage
FROM fitbit_data.daily_activity 
GROUP BY Id

-----------

--Device usage on Sleep--

SELECT
ID,
COUNT(DISTINCT SleepDay) AS num_days_used,
CASE
  WHEN COUNT(DISTINCT SleepDay) >= 0 AND COUNT(DISTINCT SleepDay) <= 10 THEN 'low usage'
  WHEN COUNT(DISTINCT SleepDay) >= 11 AND COUNT(DISTINCT SleepDay) <= 20 THEN 'medium usage'
  WHEN COUNT(DISTINCT SleepDay) >= 21 AND COUNT(DISTINCT SleepDay) <= 31 THEN 'high usage'
  END AS device_usage
FROM fitbit_data.daily_sleep
GROUP BY Id

-------------------------

--Intensity vs Time of Day--
SELECT 
MilitaryTime,
SUM(TotalIntensity) as TotalIntensity

FROM fitbit_data.hourly_intensity

GROUP BY MilitaryTime

ORDER BY TotalIntensity DESC


----------------------------


--Steps vs Time of Day--
SELECT 
MilitaryTime,
SUM(StepTotal) as Totalsteps

FROM fitbit_data.hourly_steps

GROUP BY MilitaryTime

ORDER BY Totalsteps DESC
