-- SF - Total Loans by PU
-- Reports total loans and total loan amount by each PU
-- VARIABLE: {name: "fundeddate", type:"daterange", display: "Funded Date", default:{"start":"-1 month","end":"now"}}
-- ROLLUP : { columns: {
--    "ProductionUnit": "Total:",
--    "Count of Total Loans": "{{sum}}",
--    "Value of Total Loans": "{{sum}}"
--  }
--}



select 
  c.name as ProductionUnit, count(*) "Count of Total Loans", 
  sum(a.Loan_With__c) "Value of Total Loans" 
from 
  LOAN__C a 
  join STATUS__C b on a.ID = b.loan__c
and (b.funded_abmg_date__c between "{{fundeddate.start}}" and "{{fundeddate.end}}")
join PRODUCTION_UNIT__C c on a.production_unit__c=c.id
group by c.name

