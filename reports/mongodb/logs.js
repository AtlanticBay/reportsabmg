// Logs - Search by date
// Search Informatica Integration Error logs by date
// OPTIONS: { mongodatabase: "inf"}
// FILTER: {filter: "link", column: "File Path"}
// FILTER: {filter: "date", column: "Error Log Date", params: {"format": "m-d-Y h:i A"}}
// VARIABLE : {name:"str", display: "Start Date", type:"date"}
// VARIABLE : {name: "endr", display: "End Date", type: "date"}
// VARIABLE : {name:"taskname", display: "Integration Task Name", type:"select", options:[
//                              "All Tasks (No Filter)",
//                              "Core_BYTE-Rep_SF-Prod_Condition",
//                              "Core_BYTE-Rep_SF-Prod_Contact_Employee",
//                              "Core_BYTE-Rep_SF-Prod_ContactVersion",
//                              "Core_BYTE-Rep_SF-Prod_Loan",
//                              "Core_BYTE-Rep_SF-Prod_LoanProperty",
//                              "Core_BYTE-Rep_SF-Prod_LoanRelationship_AdditionalParty",
//                              "Core_BYTE-Rep_SF-Prod_LoanRelationship_Borrowers",
//                              "Core_BYTE-Rep_SF-Prod_LoanRelationship_FileData",
//                              "Core_BYTE-Rep_SF-Prod_LoanRelationship_FileData_Clean_Contact",
//                              "Core_BYTE-Rep_SF-Prod_LoanRelationship_Party",
//                              "Core_BYTE-Rep_SF-Prod_ProductionUnit",
//                              "Core_BYTE-Rep_SF-Prod_Status",
//                              "Core_BYTE-Rep_SF-Prod_Term",
//                              "Core_BYTE-Rep_SF-Prod_Term_Update",
//                              "Core_BYTE-Rep_BYTE-Rep_LogRun_Hourly",
//                              "Core_BYTE-Rep_BYTE-Rep_LogRun_Hourly_Update"
//                              ]
//                      }


// Query collection
if (taskname=='All Tasks (No Filter)') 
{
var result = db.logs.find({"tzNaive":{$gte: ISODate(str),$lte: ISODate(endr)}})
} else {
var result = db.logs.find({"tzNaive":{$gte: ISODate(str),$lte: ISODate(endr)},"taskName": taskname})
}
// Build report rows
var rows = [];
result.forEach(function(el) {
     rows.push({
	     'Error Log Date': el.dateCreated.toJSON(), 
   	     'Task Name': el.taskName,
 	     'File Path': el.url,
	     'Error Count': el.errorCount
              });
     });

// Print out the rows
printjson(rows);
