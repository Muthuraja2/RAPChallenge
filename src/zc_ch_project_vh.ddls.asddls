@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - Projects'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.dataCategory: #VALUE_HELP
define view entity ZC_CH_PROJECT_VH
  as select from ZR_CH_PROJECT
{
      @UI.hidden: true
      @EndUserText.label: 'Project'
  key Projectuuid,
      @EndUserText.label: 'Project Name'
      ProjectName
}
