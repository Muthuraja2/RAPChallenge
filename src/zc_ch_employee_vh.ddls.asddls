@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - Employee'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZC_CH_EMPLOYEE_VH
  as select from ZR_CH_EMPLOYEE
{
      @UI.hidden: true
  key Employeeuuid,
      @EndUserText.label: 'First Name'
      EmployeeFirstName,
      @EndUserText.label: 'Last Name'
      EmployeeLastName
}
