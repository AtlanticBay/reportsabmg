-- SF - Total Loans Grouped by Status
-- Rollup report for total loans and value of loans in byte. Grouped by Status
-- Search by Status Date
-- VARIABLE: {name:"statusdate", display:"Status Date", type:"daterange", default:{"start": "-1 year", "end": "now"}}
-- ROLLUP : { columns: {
--    "Status Type": "Total:",
--    "Count of Total Loans": "{{sum}}",
--    "Value of Total Loans": "{{sum}}"
--  }
--}


select b.loan_status__c as 'Status Type', count(*) "Count of Total Loans" ,sum(a.Loan_With__c) "Value of Total Loans"
from LOAN__C a join STATUS__C b on a.ID=b.loan__c
where b.STATUS_DATE__C between '{{statusdate.start}}' and '{{statusdate.end}}'
group by b.loan_status__c
