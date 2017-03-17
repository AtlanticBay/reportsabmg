-- Funded Loans within PU -SF
-- Searches SF for completed funded abmg loans by a production unit. Used to investigate mismatch between SF & Byte
-- VARIABLE: {name:"puname", display:"Production Unit Name (MB Username)",type:"textarea" }
-- VARIABLE: {name:"funddate", display:"Funded Date", type:"daterange",default:{start: "-1 month", end: "now"}}

select a.`name` as LoanNumber, a.id as SFID, b.`name` as PU_Name, c.funded_abmg_date__c as 'Funded Date'
from LOAN__C a
join PRODUCTION_UNIT__C b
on a.production_unit__c=b.id
join STATUS__C c
on a.id=c.loan__c
where lower(b.`name`)='{{puname}}'
and c.funded_abmg_date__c between '{{funddate.start}}' and '{{funddate.end}}' 
