-- Funded Loans within PU -Byte
-- Searches Byte  for completed funded abmg loans by a production unit. Used to investigate mismatch between SF & Byte
-- OPTIONS: {database: "byte"}
-- VARIABLE: {name:"puname", display:"Production Unit Name (MB Username)",type:"textarea" }
-- VARIABLE: {name:"funddate", display:"Funded Date", type:"daterange",default:{start: "-1 month", end: "now"}}


  select fd.filename 'LoanNumber',
  fd.loanofficerusername 'PU_Name',
  st.fundingdate 'Funded Date'
  from filedata fd 
  join loan ln
  on ln.FileDataID=fd.FileDataID
	and fd.filename not like '26%' 
  and fd.filename not like '%.copy' 
  and fd.filename not like '%+'
  and (_IsActiveOrLinkedLoan=1 or _IsLoanOfRecord=1)
  join(select organizationid from organization where code not like '26%') org
  on fd.organizationid=org.organizationid
  join status st on fd.filedataid=st.filedataid
  where st.fundingdate between '{{funddate.start}}' and '{{funddate.end}}'
  and lower(fd.LoanOfficerUserName)='{{puname}}'
