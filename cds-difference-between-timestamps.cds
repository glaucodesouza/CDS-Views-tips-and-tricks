// --------------------------------------------------
// CDS1 (final calculation using tstmp_seconds_between)
// --------------------------------------------------
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'teste calcular datas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zteste_calc_diff
  as select from zteste_calc_diff2
{
  VbelnIni,
  erdatIni,
  erzetIni,
  timeStampIni,
  VbelnFim,
  erdatFim,
  erzetFim,
  timeStampFim,
  diffTime,
  ( floor(diffTime) )                                                                         as diffInt, //int part of diff time
  ( diffTime - floor(diffTime))                                                               as diffDec, //dec part of diff time
  cast( ( floor(diffTime) ) + ( ( diffTime - floor(diffTime)) * 60 / 100 ) as abap.dec(6,2) ) as diffCorreta
}


// --------------------------------------------------
// CDS 2 (needed)
// timeStampIni = starting timestamp
// timeStampFim = ending timestamp
// --------------------------------------------------
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'teste calcular datas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zteste_calc_diff2
  as select from zteste_calc_diff3
{
  VbelnIni,
  erdatIni,
  erzetIni,
  timeStampIni,
  VbelnFim,
  erdatFim,
  erzetFim,
  timeStampFim,
  cast ( ( tstmp_seconds_between( timeStampIni, timeStampFim, 'INITIAL' ) / 60 / 60 ) as abap.dec(15,2) ) as diffTime
}

// --------------------------------------------------
// CDS 3 (data origin selection)
// --------------------------------------------------
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'teste calcular datas (filha)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zteste_calc_diff3
as select from vbak 
inner join vbak as vbakFim on vbakFim.vbeln = vbakFim.vbeln
{
    vbak.vbeln as VbelnIni,
    vbak.erdat as erdatIni,
    vbak.erzet as erzetIni,
    cast( concat( vbak.erdat, vbak.erzet) as timestamp ) as timeStampIni,

    vbakFim.vbeln as VbelnFim,
    vbakFim.erdat as erdatFim,
    vbakFim.erzet as erzetFim,
    cast( concat( vbakFim.erdat, vbakFim.erzet) as timestamp ) as timeStampFim    
}
where vbak.vbeln = '0000000001'
and vbakFim.vbeln = '0000000002'


