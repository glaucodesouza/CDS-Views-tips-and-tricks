define view entity Z_SETS
  as select distinct from setleaf         as _setLeaf
{
  key _setLeaf.valfrom as Plant
}
where
 _setLeaf.setname = 'ZXPTO_SET'
