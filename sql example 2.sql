select os.order_number,
       count(os.order_item_id) as count_items
from orders as os
group by os.order_number
having count(os.order_item_id) >1
order by count_items desc

select cs.fk_customer,
       cd.last_name as lname,
       cd.first_name as fname
from fact_tables.conversions as cs left join dimensions.customer_dimension as cd
on cs.fk_customer = cd.sk_customer
group by 1,2,3
having count(cs.fk_customer)>1;


select cs.conversion_id,
       cs.fk_customer,
       cs.conversion_date,
       cs.conversion_type,
       row_number() over (partition by cs.fk_customer order by cs.conversion_date) as conversion_order,
       LAG(cs.conversion_date) over (Partition by cs.fk_customer order by cs.conversion_date) as previous_conversion,
       LEAD(cs.conversion_date) over (Partition by cs.fk_customer order by cs.conversion_date) as next_conversion
from fact_tables.conversions as cs
order by cs.fk_customer, cs.conversion_date


select cs.conversion_id,
       cd.customer_id,
       cd.first_name,
       cd.last_name,
       cs.conversion_date,
       cs.conversion_type
from fact_tables.conversions as cs
inner join dimensions.customer_dimension as cd
on cs.fk_customer = cd.sk_customer
order by cd.customer_id, cs.conversion_date

select cd.first_name,
       cd.last_name,
       cs.conversion_date,
       cs.conversion_type,
       pd.product_name,
       dd.year_quarter
      -- LAG(cs.conversion_date) over (Partition by cs.fk_customer order by cs.conversion_date) as previous_conversion,
      -- LEAD(cs.conversion_date) over (Partition by cs.fk_customer order by cs.conversion_date) as next_conversion
from fact_tables.conversions as cs
left join dimensions.customer_dimension as cd
on cs.fk_customer =cd.sk_customer
left join dimensions.product_dimension as pd
on cs.fk_product= pd.sk_product
left join dimensions.date_dimension as dd
on cs.fk_conversion_date = dd.sk_date
order by cd.customer_id, cs.conversion_date

select *
from fact_tables.conversions as cs inner join dimensions.customer_dimension as ds
on cs.fk_customer> ds.sk_customer

select *
from fact_tables.conversions as cs left join dimensions.customer_dimension as ds
on cs.fk_customer> ds.sk_customer

select cs.conversion_id,
       cs.fk_customer,
       cs.conversion_date,
       cd.first_name,
       cd.last_name
from fact_tables.conversions as cs cross join dimensions.customer_dimension as cd
-- union only keeps unique results
select cs.conversion_id,
       cs.conversion_date,
       cs.fk_customer,
       cs.conversion_channel
from fact_tables.conversions as cs
where conversion_channel = 'Social Media'
union
select cs.conversion_id,
       cs.conversion_date,
       cs.fk_customer,
       cs.conversion_channel
from fact_tables.conversions as cs
where conversion_channel = 'Direct Mail CRM'
-- Union all keeps all results
select cs.conversion_channel
from fact_tables.conversions as cs
where conversion_channel = 'Social Media'
union all
select cs.conversion_channel
from fact_tables.conversions as cs
where conversion_channel = 'Direct Mail CRM'

-- union only can merge same column & same value type
select cast(cs.fk_customer as text)
from fact_tables.conversions as cs
union
select cast(cs.fk_customer as text)
from fact_tables.conversions as cs


select current_date

select cs.conversion_id,
       cs.conversion_date,
       cs.conversion_type,
       cd.first_name,
       cd.last_name,
       lead(cs.conversion_date)over(partition by cs.fk_customer order by cs.conversion_date) as next_converstion_date,
       unique()
from fact_tables.conversions as cs left join dimensions.customer_dimension as cd
on cs.fk_customer = cd.sk_customer