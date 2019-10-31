{{- config(materialized='view', schema='raw_staging', enabled=true, tags='staging') -}}

{%- set source_table = source('analytics_raw_staging', 'stg_weather_forecasts')                        -%}

{{ dbtvault.multi_hash([('CITY_ID', 'CITY_PK'),                                                          
                        (['CITY_ID','CREATED_DATETIME'], 'CITY_CREATED_DATETIME_PK'),     
                        (['CLOUDS', 'DEG','HUMIDITY','PRESSURE','SNOW','SPEED','DESCRIPTION','MAIN'],                      
                        'CITY_HASHDIFF', true)]) -}},

{{ dbtvault.add_columns(source_table,
                        [('!1', 'SOURCE'),
                         ('LOAD_DATETIME', 'EFFECTIVE_FROM')])                    }}

{{ dbtvault.from(source_table)                                                }}