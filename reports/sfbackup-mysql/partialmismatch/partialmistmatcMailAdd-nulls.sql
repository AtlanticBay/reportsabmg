-- Partials Mismatch on Address where nulls are present 

use SFJungoBackup;
select
    a.id,
    a.`name`,
    d.`name` ProductionUnit,
	a.Mailing_Street__c,
    a.MAILING_STATE__C,
	a.Mailing_City__c,
	a.Mailing_Zip__c,
    c.`name` RecordType,
	concat(b.`FIRSTNAME`,' ',b.LASTNAME) as NameOldOrg,
	b.MailingStreet as 'MailingStreet OldOrg',
	b.MailingCity as 'MailingCity OldOrg',
	b.MailingState as 'MailingState OldOrg',
	b.MailingPostalCode as 'MailingZip OldOrg'
from
    SFBackup.CONTACTVERSION__C a
        join
    CONTACT b ON a.LEGACY_CONTACT_ID__C = b.id
        join
    SFBackup.RECORDTYPE c ON a.recordtypeid = c.id
        join
    SFBackup.PRODUCTION_UNIT__C d ON d.id = a.PRODUCTION_UNIT__C
where
    c.`Name` = 'Partial'       
	and (
	(
	(a.Mailing_Street__c is null and b.MailingStreet is not null) 
	or 
	(b.MailingStreet is null and a.Mailing_Street__c is not null)
	)
	or 
	(
	(a.Mailing_City__c is null and b.MailingCity is not null) 
	or 
	(b.MailingCity is null and a.Mailing_City__c is not null)
	)
	or
	(
	(a.Mailing_State__C is null and b.MailingState is not null) 
	or 
	(b.MailingState is null and a.Mailing_State__C is not null)
	)
	or 
	(
	(a.Mailing_Zip__c is null and b.MailingPostalCode is not null) 
	or 
	(b.MailingPostalCode is null and a.Mailing_Zip__c is not null)
	));
