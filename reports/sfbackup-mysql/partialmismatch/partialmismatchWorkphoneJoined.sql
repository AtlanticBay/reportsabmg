-- Partials Mismatch from Old Org - Work Phone
-- Mismatch on workphone from old org; linking those mismatch records with other existing cv records in SF new org


use SalesforceContactOld; 
select 
  a.id, 
  a.`name`, 
  d.`name` ProductionUnit, 
  a.WORK_PHONE__C, 
  c.`name` RecordType, 
  b.Phone as 'WorkPhone(OldOrg)' 
from 
  SFBackup.CONTACTVERSION__C a 
  join CONTACTS b ON a.LEgacy_Contact_ID__c = b.id 
  join SFBackup.RECORDTYPE c ON a.recordtypeid = c.id 
  join SFBackup.PRODUCTION_UNIT__C d ON d.id = a.PRODUCTION_UNIT__C 
where 
  c.`Name` = 'Partial' 
  and (
    a.work_phone__c <> b.phone 
    or (
      (
        a.work_phone__c is null 
        and b.phone is not null
      ) 
      or (
        b.phone is null 
        and a.work_phone__c is not null
      )
    )
  );
