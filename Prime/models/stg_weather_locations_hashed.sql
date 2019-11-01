{{- config(materialized='view', schema='raw_staging', enabled=true, tags='staging') -}}

{%- set source_table = source('analytics_raw_staging', 'stg_weather_locations')                        -%}

{{ dbtvault.multi_hash([('CITY_ID', 'CITY_PK'),                           
                        ('COUNTRY_CODE', 'COUNTRY_PK'),                               
                        (['COUNTRY_CODE','CITY_ID'], 'COUNTRY_CITY_PK'),     
                        (['LAT','LON'],                      
                        'LOCATION_HASHDIFF', true)]) -}},

{{ dbtvault.add_columns(source_table,
                        [('!WEATHER_14_TOTAL', 'SOURCE'),
                         ('LOAD_DATETIME', 'EFFECTIVE_FROM')])                    }}

{{ dbtvault.from(source_table)                                                }}