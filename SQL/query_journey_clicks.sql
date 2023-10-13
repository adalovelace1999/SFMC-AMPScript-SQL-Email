Select imo.FCA_ID AS SubscriberKey,
imo.Email_Address AS EmailAddress, 
s.EventDate AS SentDate,
c.EventDate AS ClickDate,
c.URL,
c.LinkName
From BRND_USA_IMO_AUGUST_TEST As imo
Inner join _Sent As s
ON s.SubscriberKey = imo.FCA_ID
Left join _Click As c
ON c.SubscriberKey = imo.FCA_ID 
where CONVERT (date, c.EventDate) >= DATEADD(day,-30, GETDATE())