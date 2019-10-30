{{ config(materialized='table',schema='raw_staging') }}

SELECT 
    c.value:id::BIGINT AS city_id   
  , d.value:dt::INT AS  created_datetime
  , d.value:clouds::INT AS clouds
  , d.value:deg::INT AS deg
  , d.value:humidity::INT AS humidity
  , d.value:pressure::INT AS pressure
  , d.value:snow::INT AS snow
  , d.value:speed::INT AS speed  
  , d1.value:description::VARCHAR AS description
  , d1.value:main::VARCHAR AS main
  , CURRENT_TIMESTAMP AS load_datetime
FROM
  SNOWFLAKE_SAMPLE_DATA.WEATHER.DAILY_14_TOTAL w,
      lateral flatten(input => w.v, recursive => true) c,
      lateral flatten(input => w.v, path => 'data') d,
      lateral flatten(input => d.value, path => 'weather') d1 
WHERE
    w.t::DATE =  CURRENT_DATE - INTERVAL '1 days'
AND
    c.value:country::NVARCHAR IS NOT NULL
    