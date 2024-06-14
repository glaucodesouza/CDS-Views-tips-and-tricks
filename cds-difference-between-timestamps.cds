// --------------------------------------------------
// FIRST CDS (final calculation using tstmp_seconds_between)
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
define view entity ztest_calc_diff
  //with parameters p_vbelnIni: vbeln_nach,
  //                p_vbelnFim: vbeln_nach
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
  cast ( tstmp_seconds_between( timeStampIni, timeStampFim, 'INITIAL' ) / 60 / 60 as abap.dec(15,2) ) as diff
  
}

// --------------------------------------------------
// SECOND CDS (needed)
// timeStampIni = starting timestamp
// timeStampFim = ending timestamp
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
define view entity ztest_calc_diff2 
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

