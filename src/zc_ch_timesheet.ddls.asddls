@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_CH_TIMESHEET
  provider contract transactional_query
  as projection on ZR_CH_TIMESHEET
{
  key Timesheetuuid,
      @ObjectModel.text.element: [ 'EmployeeFirstName' ]
      Employeeuuid,
      EmployeeFirstName,
      @ObjectModel.text.element: [ 'ProjectName' ]
      Projectuuid,
      ProjectName,
      Activity,
      WorkingDate,
      WorkingHours,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt

}
