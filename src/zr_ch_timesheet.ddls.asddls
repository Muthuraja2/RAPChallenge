@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CH_TIMESHEET
  as select from zch_timesheet as Timesheet
  association [1] to ZR_CH_EMPLOYEE as _employee on $projection.Employeeuuid = _employee.Employeeuuid
  association [1] to ZR_CH_PROJECT  as _project  on $projection.Projectuuid = _project.Projectuuid
{
  key timesheetuuid         as Timesheetuuid,
      employeeuuid          as Employeeuuid,
      _employee.EmployeeFirstName,
      projectuuid           as Projectuuid,
      _project.ProjectName,
      activity              as Activity,
      working_date          as WorkingDate,
      working_hours         as WorkingHours,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt

}
