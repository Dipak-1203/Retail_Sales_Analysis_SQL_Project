--- Retail Sales Analysis sql project no 1
create table Retail_Sales(
        transactions_id	int primary key,
        sale_date date,	
        sale_time time,
        customer_id	 smallint,
        age int,
        category varchar(100),
        quantiy	int,
        price_per_unit	int,
        gender varchar(10),
        cogs decimal(10, 2) ,	
        total_sale decimal(10, 2),
        Total_Profit decimal(10, 2)
);
--- print 10 rows of data
select * from Retail_Sales
limit 10 

---print all the rows
select * from Retail_Sales

--- print actual count on rows

select 
      count(*)
	  from
Retail_Sales

-- what if we have null values how to find it 

select * from Retail_Sales
where 
      transactions_id is null
	  or
      sale_date	is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  gender is null	
	  or
	  cogs	is null
	  or
	  total_sale is null
	  or
	  Total_Profit is null

--- in this case i don't have any ull value

--- if null value exists there is way how to delete this

delete from  Retail_Sales
 where 
      transactions_id is null
	  or
      sale_date	is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  gender is null	
	  or
	  cogs	is null
	  or
	  total_sale is null
	  or
	  Total_Profit is null
	  
--- nothing out put any thing because we dont have null values

--- data Exploration

--- simple questions (also called quarries)

--- Q!) How many sales we have ?

select count (*) as total_sale from Retail_Sales

--- Q2) how many unique customers we have?

select count(distinct customer_id ) as total_sales from Retail_Sales

--- Q3) what type category we have

select distinct category from Retail_Sales

---- Data Analysis & Business key problems and Answers

--Q1) writer sql query to retrieve all columns for sales made on "2022-11-05"

select * 
from Retail_Sales
where sale_date = '2022-11-05' ;


-- Q2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * 
from Retail_Sales
 where 
     category = 'Clothing'
	 and 
	 quantiy >= 4
     and 
	 to_char 	(sale_date , 'yyyy-mm') = '2022-11'

-- Q3) Write a SQL query to calculate the total sales (total_sale) for each category.


SELECT 
    category ,
	sum(total_sale) as net_sale,
    count (*) as Total_orders 
from
   Retail_Sales
group by 1
  

---Q4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select
    round(avg(age),2) as avg_age
from
    Retail_Sales
where category ='Beauty'


---Q5) Write a SQL query to find all transactions where the total_sale is greater than 1000.


select 
    *
  from 
	  Retail_Sales
where total_sale > 1000


---Q6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
     category,
	 gender,
	 count(*) as total_sales_by_gender
from Retail_Sales
     group by
	 category,
	 gender
order by 1	 
	 

---Q7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
-- MOST IMPORTANT 

SELECT * FROM

SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM sale_date)
        ORDER BY AVG(total_sale) DESC
    ) AS sales_rank
FROM Retail_Sales
GROUP BY 1,2


--Q8) Write a SQL query to find the top 5 customers based on the highest total sales

select 
      customer_id,
	  sum(total_sale) as total_sale
from Retail_Sales
group by 1
order by 2 desc
limit 5


-- Q9)  Write a SQL query to find the number of unique customers who purchased items from each category.

select
  category,
  count(distinct customer_id) as UNIQUE_COSTOMERS
 
from Retail_Sales
group by 
     category 


-- Q10)  Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(
select * , 
    case 
	    when Extract (hour from sale_time) < 12 then ' Morning'
		when Extract (hour from sale_time) between 12 and 17 then ' Afternoon'
		else 'Evening'
  end as shift
from Retail_Sales 
	
)
select shift,
     count(*) as total_orders
from hourly_sale
group by shift


--THE END

	















	































































































































