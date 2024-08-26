@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_CH_EMP_PROJ_ASG
  provider contract transactional_query
  as projection on ZR_CH_EMP_PROJ_ASG
{
  key EmployeeToProjUuid,
      @ObjectModel.text.element: [ 'EmployeeFirstName' ]
      @EndUserText.label: 'Employee'
      Employeeuuid,
      EmployeeFirstName,
      @ObjectModel.text.element: [ 'ProjectName' ]
      @EndUserText.label: 'Employee'
      Projectuuid,
      ProjectName,
      AllottedHours,
      AllottedManDays,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt

}
