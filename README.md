# RAPChallenge
RAP Challenge 


Employee Master App:  

Columns:  

Employee Id (UUID)  

Employee First Name (Mandatory)  

Employee Last Name  

Cost Center (Mandatory)  

Role  

Start Date (Mandatory)  

 

Operation Should Support – Create, Update & Delete 

  

Project Master App:  

Columns:  

Project Id (UUID)  

Project Name (Mandatory)  

Customer Name (Mandatory)  

Project Start Date (Mandatory)  

Project End Date  

Status  

 

Operation Should Support – Create, Update & Delete 

 

Employee Project Assignment App:  

Columns:  

Employee Id (Mandatory)  

Project Id (Mandatory)  

Allotted Hours (Mandatory)    

Allotted Man Days (Read only)  

  

Validations & Determinations:  

Employee Id & Project Id should be present in the Master tables  

Allotted Man days should be derived based on Allotted Hours   

 

Operation Should Support – Create, Update & Delete 

  

Timesheet App:  

Columns:  

Employee Id (Mandatory)  

Project Id (Mandatory)  

Activity   

Date (Mandatory)  

Hours (Mandatory)  

  

Validations:  

Employee Id & Project Id should be present in the Master tables  

Date should not be in the Future 

 

Operation Should Support – Create, Update & Delete 

 

 
