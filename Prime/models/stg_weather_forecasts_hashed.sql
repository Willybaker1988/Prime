{{- config(materialized='view', schema='raw_staging', enabled=true, tags='staging') -}}

{%- set source_table = source('analytics_raw_staging', 'weather_forecasts')                        -%}

{{ dbtvault.multi_hash([('CITY_ID', 'CITY_PK'),                                                          
                        (['CREATED_DATETIME','CLOUDS', 'DEG','HUMIDITY','PRESSURE','SNOW','SPEED','DESCRIPTION','MAIN'],                      
                        'CITY_HASHDIFF', true)]) -}},

{{ dbtvault.add_columns(source_table,
                        [('!WEATHER_14_TOTAL', 'SOURCE'),
                         ('LOAD_DATETIME', 'EFFECTIVE_FROM')])                    }}

{{ dbtvault.from(source_table)                                                }}