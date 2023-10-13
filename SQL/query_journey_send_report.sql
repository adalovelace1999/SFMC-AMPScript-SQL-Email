select
  s.id JobID
, s.SentDate AT TIME ZONE 'PT' as SentDate
, s.status JobStatus
, s.EmailName
, s.NumberTargeted Targeted
, s.NumberDelivered Delivered
, case
    when isnull(s.NumberTargeted,0) = 0 then 0
    else cast((s.NumberDelivered) as decimal(18,4)) / cast(s.NumberTargeted as decimal(18,4))
  end as DeliveryRate
, case
    when isnull(s.NumberDelivered,0) = 0 then 0
    else cast((s.UniqueOpens) as decimal(18,4)) / cast(s.NumberDelivered as decimal(18,4))
  end as OpenRate
, case
    when isnull(s.NumberDelivered,0) = 0 then 0
    else cast((s.UniqueClicks) as decimal(18,4)) / cast(s.NumberDelivered as decimal(18,4))
  end as ClickThroughRate
, case
    when isnull(s.NumberDelivered, 0) = 0 then 0
    else cast((s.Unsubscribes) as decimal(18,4)) / cast(s.NumberDelivered as decimal(18,4))
  end as UnsubscribeRate
, s.PreviewURL
, getDate() AT TIME ZONE 'Pacific Standard Time' as ReportLastUpdated
from Send s
left join _job j on j.jobid = s.id
where
s.id is not null
and s.emailName is not null
and s.status <> 'Canceled'
and s.NumberTargeted > 0
and isnull(j.category,'') <> 'test send emails'
and isnull(j.testemailaddr,'') = ''
/* name: Send_Report */
/* target: Send_Report */
/* action: update */