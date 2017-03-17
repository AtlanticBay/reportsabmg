-- Mismatch - Mailing Address
-- Enter Description

use SalesforceContactOld; 
select 
  a.id, 
  a.`name`, 
  d.`name` ProductionUnit, 
  a.Mailing_Street__c, 
  a.MAILING_STATE__C, 
  a.Mailing_City__c, 
  a.Mailing_Zip__c, 
  c.`name` RecordType, 
  concat(b.`FIRSTNAME`, ' ', b.LASTNAME) as NameOldOrg, 
  b.MailingStreet as 'MailingStreet OldOrg', 
  b.MailingCity as 'MailingCity OldOrg', 
  b.MailingState as 'MailingState OldOrg', 
  b.MailingZip as 'MailingZip OldOrg' 
from 
  SFBackup.CONTACTVERSION__C a 
  join CONTACTS b ON a.LEGACY_CONTACT_ID__C = b.id 
  join SFBackup.RECORDTYPE c ON a.recordtypeid = c.id 
  join SFBackup.PRODUCTION_UNIT__C d ON d.id = a.PRODUCTION_UNIT__C 
where 
  c.`Name` not in ('Partial', 'Borrower') 
  and (
    a.Mailing_Street__c <> b.MailingStreet 
    or a.Mailing_City__c <> b.MailingCity 
    or a.Mailing_State__C <> b.MailingState --  or a.Mailing_Zip__c <> b.MailingZip
    or lpad(a.Mailing_Zip__c, 5, 0) <> lpad(b.mailingzip, 5, 0)
  );
