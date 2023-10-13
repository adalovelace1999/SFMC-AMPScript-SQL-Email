select a.*
from BRND_USA_MVP_EWELCOME As a 
where a.vin not in ( select vin from MVP_EWELCOME_VIN)
