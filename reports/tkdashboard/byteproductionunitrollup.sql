-- Byte - Total Loans by PU
-- Report totals loans and total loan amount by Production Unit
-- OPTIONS: {database: "byte"}
-- VARIABLE: {name:"fundeddate", display: "Funded Date", type:"daterange", default:{"start":"-1 manth","end":"now"}}
-- ROLLUP : { columns: {
--    "ProductionUnit": "Total:",
--    "Count of Total Loans": "{{sum}}",
--    "Value of Total Loans": "{{sum}}"
--  }
--}


select 
  exttext.value as ProductionUnit, count(*) as 'Count of Total Loans', 
  (
    sum(a.LoanWith)
  ) as 'Value of Total Loans' 
from 
  Loan a 
  join FileData b on a.FileDataID = b.FileDataID 
  and b.loanid=a.loanid
  and b.filename not like '26%' 
  and b.filename not like '%.copy' 
  and b.filename not like '%+' 
  join (
    select 
      OrganizationID 
    from 
      Organization 
    where 
      code not like '26%'
  ) org on b.OrganizationID = org.OrganizationID 
  join (
    select 
      x.filedataid, 
      x.loanstatus, 
      x.fundingdate,
	  x.CustomStatus9Date as  'TBD Approved Date',
	  x.ApprovedDate as 'Approved Date',
	  x.CustomStatus8Date as 'TBD Not Approvable As Is Date',
	  x.CustomStatus2Date as 'Cond with UW Date',
	  x.InClosingDate as 'With Closing Date',
      sfdict.lookupvalue 
    from 
      status x 
      join dictsalesforcevalues sfdict on x.loanstatus = sfdict.sourcevalue 
      and dictname = 'loanstatus'
  ) st on a.filedataid = st.filedataid
 and st.fundingdate between '{{fundeddate.start}}' and '{{fundeddate.end}}' 
	join extendedtextvalue exttext on a.filedataid=exttext.filedataid
	and exttext.name='ProductionUnit' and exttext.value not in ('null','')
--	and a._IsActiveOrLinkedLoan=1
	group by exttext.value
