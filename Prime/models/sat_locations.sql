{{- config(materialized='incremental', enabled=true, tags='sat') -}}

{%- set source = [ref('stg_weather_locations_hashed')]                                       -%}

{%- set src_pk = 'COUNTRY_CITY_PK'                                                      -%}
{%- set src_hashdiff = 'LOCATION_HASHDIFF'                                          -%}
{%- set src_payload = ['LAT', 'LON']           -%}

{%- set src_eff = 'EFFECTIVE_FROM'                                                  -%}
{%- set src_ldts = 'LOAD_DATETIME'                                                       -%}
{%- set src_source = 'SOURCE'                                                       -%}

{%- set tgt_pk = source                                                             -%}
{%- set tgt_hashdiff = [src_hashdiff , 'BINARY(16)', 'HASHDIFF']                   -%}
{%- set tgt_payload = [[src_payload[0], 'NUMBER(38,0)', 'LAT'],
                       [src_payload[1], 'NUMBER(38,0)', 'LON']]                   -%}

{%- set tgt_eff = source                                                            -%}
{%- set tgt_ldts = source                                                           -%}
{%- set tgt_source =  source                                                        -%}


{{  dbtvault.sat_template(src_pk, src_hashdiff, src_payload,
                          src_eff, src_ldts, src_source,
                          tgt_pk, tgt_hashdiff, tgt_payload,
                          tgt_eff, tgt_ldts, tgt_source,
                          source)                                                       }}