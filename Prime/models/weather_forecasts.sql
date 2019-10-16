SELECT 
    MD5(CONCAT(w.t,'', w.v)) as WKEY
  , d.value:dt::INT AS  datetime
  , d.value:clouds::INT AS clouds
  , d.value:deg::INT AS deg
  , d.value:humidity::INT AS humidity
  , d.value:pressure::INT AS pressure
  , d.value:snow::INT AS snow
  , d.value:speed::INT AS speed  
  , d1.value:description::VARCHAR AS description
  , d1.value:main::VARCHAR AS main
FROM
  SNOWFLAKE_SAMPLE_DATA.WEATHER.DAILY_14_TOTAL w,
      lateral flatten(input => w.v, path => 'data') d,
      lateral flatten(input => d.value, path => 'weather') d1 
WHERE
    w.t::DATE =  CURRENT_DATE - INTERVAL '1 days'