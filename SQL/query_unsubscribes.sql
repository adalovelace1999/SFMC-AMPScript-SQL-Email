SELECT DISTINCT 
CASE j.TriggeredSendCustomerKey 
WHEN '256721' THEN 'High Engaged'
WHEN '256723' THEN 'Low Engaged'
WHEN '256725' THEN 'Non Engaged: non-Gmail'
WHEN '256722' THEN 'Non Engaged: Gmail'
WHEN '256724' THEN 'Medium Engaged'
WHEN '256720' THEN 'Remainder'
END AS Segment
, de.N_BRND as Brand
, COUNT(DISTINCT s.SubscriberKey) as [Unsubscribes]
FROM _Unsubscribe s INNER JOIN BRND_USA_ALL_CC_BROWNR_2023_04 de ON s.SubscriberKey = de.FCA_ID
INNER JOIN _Job j on s.JobID = j.JobID
AND DATEDIFF(DAY, s.EventDate, GETDATE()) <= 7
AND j.TriggeredSendCustomerKey IN ('256720', '256721', '256722', '256723', '256724', '256725')
AND s.IsUnique = 1
GROUP BY j.TriggeredSendCustomerKey, de.N_BRND