@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CH_EMP_PROJ_ASG
  as select from zch_emp_proj_asg as EmpToProject
  association [1] to ZR_CH_EMPLOYEE as _employee on $projection.Employeeuuid = _employee.Employeeuuid
  association [1] to ZR_CH_PROJECT  as _project  on $projection.Projectuuid = _project.Projectuuid
{
  key employee_to_proj_uuid as EmployeeToProjUuid,
      employeeuuid          as Employeeuuid,
      _employee.EmployeeFirstName,
      projectuuid           as Projectuuid,
      _project.ProjectName,
      allotted_hours        as AllottedHours,
      allotted_man_days     as AllottedManDays,
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
