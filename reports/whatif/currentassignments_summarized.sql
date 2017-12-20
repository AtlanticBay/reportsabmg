-- Current Assignments - Pivot
-- This is the first part of the whatif report creation:
-- Summarizes number of loans each team member has been a part of and touched during a 12 month period. Run pivot based on the picklist given and attach each result as  sheet to an excel workbook
-- OPTION: { database: "whatif" }
-- VARIABLE: { name: "input", display: "Type", type: "select", options: ["LoanOfficer","CurrentUnderwriter","CurrentProcessor","CurrentCloser","Underwriter_Byte_User_Name","Processor_Byte_User_Name","Closer_Byte_User_Name","Title_Review_User_Name"]}

call `whatif`.pivot("{{ input }}")
