# For this part of the task, MySQL Workbench could not run in my machine. A walk aoround was to achieve the same using R dbplyr package which is uses the same logic and translates the logic into SQL syntax.
#dbplyr works with remote on-disk data stored in databases and uses tidyvers verbs which are easily converted into SQL codes.


#install.packages("dbplyr")

library(dbplyr)
#read a database remotely
my_db <- DBI::dbConnect(RSQLite::SQLite(), dbname = ":memory:")


# 1.Create a SQL query that summarizes the number of orders, customers & revenue by month
df <- my_db %>% 
  group_by(month) %>% 
  summarise(Orders=count(orders),customers=count(customers),revenue=sum(revenue))
# get SQL CODE
df %>% show_query()

#2. Create a SQL query that summarizes units sold and revenue by month and order source
df <- my_db %>% 
  group_by(month,order_source) %>% 
  summarise(Total_units=sum(units_sold),Average_unit=mean(units_sold,na.rm=T),
            Toatl_revenue=sum(revenue),Average_revenue=mean(revenue))
#get SQL CODE
df %>% show_query()
  
#3. Create SQL queries that generate the following high level KPIs:
## a). Average units per order
df <- my_db %>% 
  group_by(order) %>% 
  summarise(Average_units=mean(units))
#get SQL CODE
df %>% show_query()

## b). Average basket size
df <- my_db %>% 
  summarise(Average_busket_size=mean(basket_size))
#get SQL code
df %>% show_query()

#get SQL CODE
df %>% show_query()

## c). Number of customers with more than 10 orders and at least 2 products per order
df <- my_db %>% 
  filter(num_orders>10 & products_per_order>2)


#4. Create a SQL query that does a pivot table summarizing the number of orders by product and order source

df %>% my_db %>% 
  group_by(product,order_source) %>% 
  summarise(No_orders=n())

#collect SQL code
df %>% show_query()


  
