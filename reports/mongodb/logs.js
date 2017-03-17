// Logs - Search by date
// Search Informatica Integration Error logs by date
// OPTIONS: { mongodatabase: "hztest"}
// FILTER: {filter: "link", column: "File Path"}
// FILTER: {filter: "date", column: "Error Log Date", params: {"format": "m-d-Y h:i A"}}
// VARIABLE : {name:"str", display: "Start Date", type:"date"}
// VARIABLE : {name: "endr", display: "End Date", type: "date"}
// VARIABLE : {name:"taskname", display: "Integration Task Name", type:"select", options:["All Tasks (No Filter)","Prod_st_BYTEtoSF_ContactVersion","Prod_st_BYTEtoSF_Contact_Employee","Prod_st_BYTEtoSF_Loan","Prod_st_BYTEtoSF_LoanRelationship_AdditionalParty","Prod_st_BYTEtoSF_LoanRelationship_Borrowers","Prod_st_BYTEtoSF_LoanRelationship_FileData","Prod_st_BYTEtoSF_LoanRelationship_FileData_Clean_Contact","Prod_st_BYTEtoSF_LoanRelationship_Party","Prod_st_BYTEtoSF_LoanProperty","Prod_st_BYTEtoSF_Status","Prod_st_BYTEtoSF_Condition","Prod_st_BYTEtoSF_Term","Prod_st_BYTEtoSF_Term_Update","Prod_st_BYTEtoSF_Term_Update"]}



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
