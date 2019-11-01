
{{- config(materialized='incremental', enabled=true, tags='sat') -}}


{%- set source = [ref('stg_weather_forecasts_hashed')]                                       -%}

{%- set src_pk = 'CITY_PK'                                                      -%}
{%- set src_hashdiff = 'CITY_HASHDIFF'                                          -%}
{%- set src_payload = ['CREATED_DATETIME', 'CLOUDS', 'DEG','HUMIDITY','PRESSURE','SNOW','SPEED','DESCRIPTION','MAIN']           -%}

{%- set src_eff = 'EFFECTIVE_FROM'                                                  -%}
{%- set src_ldts = 'LOAD_DATETIME'                                                       -%}
{%- set src_source = 'SOURCE'                                                       -%}

{%- set tgt_pk = source                                                             -%}
{%- set tgt_hashdiff = [src_hashdiff , 'BINARY(16)', 'HASHDIFF']                   -%}
{%- set tgt_payload = [[src_payload[0], 'NUMBER(38,0)', 'CREATED_DATETIME'],
                       [src_payload[1], 'NUMBER(38,0)', 'CLOUDS'],
                       [src_payload[2], 'NUMBER(38,0)', 'DEG'],
                       [src_payload[3], 'NUMBER(38,0)', 'HUMIDITY'],
                       [src_payload[4], 'NUMBER(38,0)', 'PRESSURE'],
                       [src_payload[5], 'NUMBER(38,0)', 'SNOW'],
                       [src_payload[6], 'NUMBER(38,0)', 'SPEED'],
                       [src_payload[7], 'VARCHAR(10000)', 'DESCRIPTION'],
                       [src_payload[8], 'VARCHAR(10000)', 'MAIN']]                   -%}

{%- set tgt_eff = source                                                            -%}
{%- set tgt_ldts = source                                                           -%}
{%- set tgt_source =  source                                                        -%}


{{  dbtvault.sat_template(src_pk, src_hashdiff, src_payload,
                          src_eff, src_ldts, src_source,
                          tgt_pk, tgt_hashdiff, tgt_payload,
                          tgt_eff, tgt_ldts, tgt_source,
                          source)                                                       }}