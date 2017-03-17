-- Partials Mismatch - EMAIL
-- Shows mismatch

select a.id, a.`name`,a.Email__c, b.Email 'Email(OldOrg)' from CONTACTVERSION__C a join SFJungoBackup.CONTACT b on a.LEGACY_CONTACT_ID__C=b.id
join RECORDTYPE c on a.RECORDTYPEID=c.id where c.`Name`='Partial' and a.Email__c <> b.Email;
