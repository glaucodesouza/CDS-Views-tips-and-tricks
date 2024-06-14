//get current system time
//logTimeStampFim in the end is e.g. 14:37:11
tstmp_to_tims(tstmp_current_utctimestamp(), abap_system_timezone( $session.client,'NULL' ), $session.client, 'NULL') as logTimeStampFim
