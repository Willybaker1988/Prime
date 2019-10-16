SELECT 
    MD5(CONCAT(w.t,'', w.v)) as WKEY
  , c.value:id::BIGINT AS id
  , c.value:country::NVARCHAR AS country_code
  , c.value:name::NVARCHAR AS city
  , c.value:coord:lat AS lat
  , c.value:coord:lon AS lon
FROM
    SNOWFLAKE_SAMPLE_DATA.WEATHER.DAILY_14_TOTAL w,
        lateral flatten(input => w.v, recursive => true) c,
        lateral flatten(input => c.value:coord ) d
WHERE
    w.t::DATE =  CURRENT_DATE - INTERVAL '1 days'