      logTimeStampIni,
      logTimeStampFim,
      
      //calcular diferença de tempo de movimentação
      cast ( ( tstmp_seconds_between( logTimeStampIni, logTimeStampFim, 'INITIAL' ) / 60 / 60 ) as abap.dec(15,2) ) as logDifHorasMov
      //resultado exemplo 2,38 (duas horas e 38 minutos)
      cast( ( floor(logDifHorasMov) ) + ( ( logDifHorasMov - floor(logDifHorasMov)) * 60 / 100 ) as abap.dec(6,2) ) as logDifTempFabrica
