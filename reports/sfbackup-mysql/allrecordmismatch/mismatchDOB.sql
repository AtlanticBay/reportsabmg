-- Mismatch DOB 
-- Breif Description

select 
  a.id, 
  a.`name`, 
  a.DOB__c, 
  STR_TO_DATE(b.Birthdate, '%m/%d/%Y') as 'Birthdate(OldOrg)', 
  c.`name` as RecordType 
from 
  CONTACTVERSION__C a 
  join SalesforceContactOld.CONTACTS b ON a.LEGACY_CONTACT_ID__C = b.id 
  join RECORDTYPE c ON a.RECORDTYPEID = c.id 
where 
  c.`Name` not in ('Partial', 'Borrower') 
  and (
    a.DOB__c <> STR_TO_DATE(b.Birthdate, '%m/%d/%Y') 
    or (
      b.birthdate is null 
      and a.DOB__C is not null
    )
  );
