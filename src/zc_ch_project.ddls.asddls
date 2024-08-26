@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_CH_PROJECT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CH_PROJECT
{
  key Projectuuid,
  ProjectName,
  CustomerName,
  ProjectStartDate,
  ProjectEndDate,
  Status,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
