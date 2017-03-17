-- Partials Mismatch - DOB link to other records
-- Possibility of matching certain mismatch records with other contact versions as well

use SFJungoBackup; 
select 
  a.id, 
  a.`name`, 
  d.`name` ProductionUnit, 
  a.DOB__c, 
  c.`name` RecordType, 
  b.birthdate as DOBOldOrg,
  e.`name` as JoinedName, 
  e.id as JoinedID, 
  e.DOB__c as JoinedDOB, 
  e.ProductionUnit as JoinedPU, 
  e.RecordType as JoinedRecordType 
from 
  SFBackup.CONTACTVERSION__C a 
  join CONTACT b ON a.LEGACY_CONTACT_ID__C = b.id 
  join SFBackup.RECORDTYPE c ON a.recordtypeid = c.id 
  join SFBackup.PRODUCTION_UNIT__C d ON d.id = a.PRODUCTION_UNIT__C 
  join (
    select 
      x.id, 
      x.`name`, 
      y.`name` as ProductionUnit, 
      x.DOB__c, 
      z.`name` as RecordType 
    from 
      SFBackup.CONTACTVERSION__C x 
      join SFBackup.PRODUCTION_UNIT__C y ON x.production_unit__c = y.id 
      join SFBackup.RECORDTYPE z ON x.RECORDTYPEID = z.ID
  ) e ON e.DOB__c = a.DOB__c 
  and a.`name` <> e.`name` 
where 
  c.`Name` = 'Partial' 
  and (
    a.DOB__c <> b.BIRTHDATE
    ) 
    or (
      (b.Birthdate is null 
      and a.DOB__C is not null) 
	or (a.DOB__C is null and b.BIRTHDATE is not null));
