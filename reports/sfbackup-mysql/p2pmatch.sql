-- Person to Referral Linking - Exact Match
-- This report links contact referrals from Old Org into new; matching on first name and production unit

USE sfcleanups; 
SELECT 
  a.id, 
  a.pu_name AS ProductionUnit, 
  a.pu_id, 
  a.full_name, 
  a.referred_by_name AS 'ReferredByName(Original)', 
  b.id AS ReferredByID, 
  b.`name` AS 'ReferredByName(Matched)', 
  b.production_unit__c, 
  b.recordtypename AS RecordType 
FROM 
  p2psrc a 
  JOIN (
    SELECT 
      x.id, 
      x.production_unit__c, 
      x.`name`, 
      x.recordtypeid, 
      y.recordtypename 
    FROM 
      `SFBackup`.CONTACTVERSION__C x 
      JOIN (
        SELECT 
          cv.`name`, 
          Min(
            CASE WHEN rt.`name` = 'Real Estate Agent' THEN 1 WHEN rt.`name` = 'Real Estate Industry Participant' THEN 2 WHEN rt.`name` = 'Attorney' THEN 3 WHEN rt.`name` = 'Appraiser' THEN 4 WHEN rt.`name` = 'Builder' THEN 5 WHEN rt.`name` = 'Financial Professional' THEN 6 WHEN rt.`name` = 'Inspector' THEN 7 WHEN rt.`name` = 'Insurance' THEN 8 WHEN rt.`name` = 'Investor/Flipper' THEN 9 WHEN rt.`name` = 'Miscellaneous' THEN 10 WHEN rt.`name` = 'Title' THEN 11 WHEN rt.`name` = 'Borrower' THEN 12 WHEN rt.`name` = 'Partial' THEN 13 WHEN rt.`name` = 'Lead' THEN 14 ELSE NULL end
          ) RecordTypeRank, 
          rt.`name` AS RecordTypeName, 
          cv.recordtypeid 
        FROM 
          `SFBackup`.CONTACTVERSION__C cv 
          JOIN `SFBackup`.RECORDTYPE rt ON cv.recordtypeid = rt.id 
        GROUP BY 
          cv.`name`
      ) y ON x.`name` = y.`name` 
      AND y.recordtypeid = x.recordtypeid
  ) b ON b.`name` = a.referred_by_name 
  AND a.pu_id = b.production_unit__c 
ORDER BY 
  b.production_unit__c;
