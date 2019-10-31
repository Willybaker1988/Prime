{{- config(materialized='incremental', enabled=true, tags='hub') -}}

{%- set source = [ref('stg_weather_locations_hashed'),
                  ref('stg_weather_forecasts_hashed')]                                       -%}


{%- set src_pk = 'CITY_PK'                                                      -%}
{%- set src_nk = 'CITY_ID'                                                      -%}
{%- set src_ldts = 'LOADDATE'                                                       -%}
{%- set src_source = 'SOURCE'                                                       -%}


{%- set tgt_pk = source                                                             -%}
{%- set tgt_nk = source                                                             -%}
{%- set tgt_ldts = source                                                           -%}
{%- set tgt_source = source                                                         -%}

{{ dbtvault.hub_template(src_pk, src_nk, src_ldts, src_source,                         
                         tgt_pk, tgt_nk, tgt_ldts, tgt_source,               
                         source)                                                     }}