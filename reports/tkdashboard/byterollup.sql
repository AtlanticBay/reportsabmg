-- Byte - Total Loans Grouped by Status
-- Rollup report for total loans and value of loans in byte. Grouped by Status 
-- Search by status date
-- OPTIONS : {database: "byte"}
-- VARIABLE:{name:"statusdate", display:"Status Date",type:"daterange", default:{"start":" -1 year", "end": "now"}} 
-- ROLLUP : { columns: {
--    "Status Type": "Total:",
--    "Count of Total Loans": "{{sum}}",
--    "Value of Total Loans": "{{sum}}"
--  }
--}	


select st.displayvalue as 'Status Type' ,count(*) as'Count of Total Loans', (sum(a.LoanWith)) as 'Value of Total Loans' from Loan a
join FileData b on a.FileDataID=b.FileDataID and a.loanid=b.loanid
and b.filename not like '26%' and b.filename not like '%.copy' and b.filename not like '%+'
join (select OrganizationID from Organization where code not like '26%') org
on b.OrganizationID=org.OrganizationID
join (select x.filedataid,
x.loanstatus,
x._statusdate,
case when sfdict.lookupvalue='Lead' then 'Lead (Credit not Pulled)'
when sfdict.lookupvalue='CustomStatus7' then 'Prospect(Credit Pulled)'
when sfdict.lookupvalue='Closed' then 'Credit Only (Denied/WD)'
when sfdict.lookupvalue='Prequal' then 'New Loan (In Ops)'
when sfdict.lookupvalue='CollateralSent' then 'Compliance Held'
when sfdict.lookupvalue='InProcessing' then 'Ready to U/W'
when sfdict.lookupvalue='Shipped' then 'In Underwriting'
when sfdict.lookupvalue='CreditOnly' then 'Not Underwritable'
when sfdict.lookupvalue='CustomStatus8' then 'TBD Not Approvable (As Is)'
when sfdict.lookupvalue='CustomStatus9' then 'TBD Approved'
when sfdict.lookupvalue='Resubmitted' then 'Resubmitted'
when sfdict.lookupvalue='Approved' then 'Approved (W/ Property)'
when sfdict.lookupvalue='Declined' then 'Denied'
when sfdict.lookupvalue='CustomStatus2' then 'Cond W U/W'
when sfdict.lookupvalue='CustomStatus4' then 'U/W Clear'
when sfdict.lookupvalue='InClosing' then 'With Closing'
when sfdict.lookupvalue='DocsSigned' then 'Instruc Out'
when sfdict.lookupvalue='DocsSent' then 'Docs Sent'
when sfdict.lookupvalue='Funded' then 'Funded (ABMG)'
when sfdict.lookupvalue='CustomStatus10' then 'Funded by Corr'
when sfdict.lookupvalue='CustomStatus11' then 'Purchased from Corr'
when sfdict.lookupvalue='Purchased' then 'Loan Sold'
when sfdict.lookupvalue='CustomStatus1' then 'Audited by Compliance'
when sfdict.lookupvalue='CleartoClose' then 'Paid in Full'
when sfdict.lookupvalue='Submitted' then 'W/D for Incompleteness'
when sfdict.lookupvalue='Canceled' then 'Canc/Withdn'
when sfdict.lookupvalue='Suspended' then 'Not Approved (As Is)'
else sfdict.lookupvalue end as displayvalue
from status x join dictsalesforcevalues sfdict on x.loanstatus=sfdict.sourcevalue
and dictname='loanstatus') st
on a.filedataid=st.filedataid
where st._statusdate between '{{statusdate.start}}' and '{{statusdate.end}}'
--and (a._IsActiveOrLinkedLoan=1 or a._IsLoanOfRecord=1)
group by st.displayvalue

