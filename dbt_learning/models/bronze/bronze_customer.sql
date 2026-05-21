{{config(materialized= "table")}}  -- This file is the model file for the bronze_customer model. This model is responsible for creating the bronze_customer table in the database. The bronze_customer table is a copy of the dim_customer table in the source schema. The purpose of this model is to create a staging table that can be used for further transformations in the silver layer.

"""(This config takes presedence over the property definied in the properties.yml file for this model, which is view. This means that even though we have defined this model as a view in the properties.yml file, it will be materialized as a table because of this config. This is an example of block level configuration, which takes presedence over the properties level configuration defined in the properties.yml file.)"""

select *
from {{ source('source', 'dim_customer') }}