@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_CH_EMPLOYEE
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CH_EMPLOYEE
{
  key Employeeuuid,
  EmployeeFirstName,
  EmployeeLastName,
  CostCenter,
  Role,
  StartDate,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
