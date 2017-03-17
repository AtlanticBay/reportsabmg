-- Mismatch on DOB for all CV Records
-- Records in CV that have 20% dob years

use sfcleanups;
select
    a.id,
    a.`name`,
    d.`name` ProductionUnit,
    a.DOB__c,
        c.`name` RecordType,
    date_format(str_to_date(b.DOB__c, '%m/%d/%Y'),
            '%Y-%m-%d') 'Birthdate(Backup 12/17)'
from
    SFBackup.CONTACTVERSION__C a
        join
    Contactversion_backup b ON a.id = b.id
        join
    SFBackup.RECORDTYPE c ON a.recordtypeid = c.id
        join
    SFBackup.PRODUCTION_UNIT__C d ON d.id = a.PRODUCTION_UNIT__C
where
   (a.DOB__c <> date_format(str_to_date(b.DOB__c, '%m/%d/%Y'),
            '%Y-%m-%d')
        or (date_format(str_to_date(b.DOB__c, '%m/%d/%Y'),
            '%Y-%m-%d') is null
        and a.DOB__C is not null))
	and a.DOB__c like '20%';
