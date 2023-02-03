
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select 1 as id
    union all
    select null as id

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null


# Note: This file is to grant table level read access on production environment
# if you want to get read access on all tables under a dataset , please add the
# in google_dataset_iam_production.yaml
# Syntax:
# <google_table_iam>
#   <bigquery_project_id>
#     <acl>
#       <name: name of the business use cases, one business unit can have multiple use cases>
#       <users: list of users or groups which need access >
#         <email: user email, only for Service Account,and not recommended to add individuals>
#         <group: group email >
#       <tables: list of tables which a use case need access>
#         <name: name of the table>
# Example:
# mo-data-dwh-prod-xxx:
#    acl:
#      - name: DWH Data Engineers
#        users:
#          - group: mobile-de-dwh@ebay.com
#          - email: dwh-talend-test@mo-data-dwh-dev-yi0d.iam.gserviceaccount.com
#        tables:
#          - name: mobile_dwh.f_as24_listings
#          - name: mobile_dwh.f_customer_daily
#          - name: mobile_dwh.f_ddl_revenues
##############################################################################################
google_table_iam:
  mo-data-dwh-prod-2f8o:
    acl:
      - name: DWH Central Team
        users:
          - email: dwh-prod-batch-sa@dwh-prod-7b1n.iam.gserviceaccount.com
        tables:
          - name: mobile_dwh.ecg_metrics
          - name: mobile_dwh.clsfd_tables_dw_cal_dt
          - name: mobile_dwh.ecg_onestream_bq
          - name: mobile_dwh.ecg_onestream
      - name: mobile spark team
        users:
          - email: b2b-sourcing-data-agent@mo-b2b-src-prod-r7iy.iam.gserviceaccount.com
          - group: gp.mobile.spark@adevinta.com
        tables:
          - name: mobile_dwh.f_ad_count_flatten
          - name: mobile_dwh.d_vehicle
          - name: mobile_dwh.d_customer_flatten
          - name: mobile_dwh.h_district_zipcode_lookup
          - name: mobile_dwh.d_vehicle_status
      - name: obsa team
        users:
          - email: bsi-sf-obs@mo-data-obs-pr-wy5i.iam.gserviceaccount.com
          - group: gp.mobile.data-obs-prod@adevinta.com
        tables:
          - name: mobile_dwh.d_customer_flatten
          - name: mobile_dwh.f_ad_count_flatten
          - name: mobile_dwh.d_vehicle
          - name: mobile_dwh.d_ad_status
          - name: mart_marketing_dc.v_account