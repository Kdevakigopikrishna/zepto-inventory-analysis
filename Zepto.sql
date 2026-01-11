DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountpercent NUMERIC(8,2),
    availablequantity INTEGER,
    discountedsellingprice NUMERIC(8,2),
    weightin_gms INTEGER,
    outofstock BOOLEAN,
    quantity INTEGER
);

--- DATA Exploration

--- count rows
SELECT COUNT(*) FROM zepto;

---- sample data 10
SELECT * FROM zepto LIMIT 10;

-- null values
SELECT * FROM zepto 
WHERE category IS NULL OR
      name IS NULL OR
      mrp IS NULL OR
      discountpercent IS NULL OR
      availablequantity IS NULL OR
      discountedsellingprice IS NULL OR
      weightin_gms IS NULL OR
      outofstock IS NULL OR
      quantity IS NULL;

--- different product categories 
SELECT DISTINCT category FROM zepto ORDER BY category;

-- products in stock vs out of stock
SELECT outofstock, COUNT(sku_id) 
FROM zepto 
GROUP BY outofstock;

-- product names present multiple times
SELECT name, COUNT(sku_id) AS "number of SKUs"
FROM zepto 
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

----- Data Cleaning 

--- products with price = 0
SELECT * FROM zepto 
WHERE mrp = 0 OR discountedsellingprice = 0;

-- delete where mrp = 0
DELETE FROM zepto WHERE mrp = 0;

-- convert paise to rupees
UPDATE zepto 
SET mrp = mrp / 100.0,
    discountedsellingprice = discountedsellingprice / 100.0;

SELECT mrp, discountedsellingprice FROM zepto;

-- data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountpercent 
FROM zepto 
ORDER BY discountpercent DESC 
LIMIT 10;

-- Q2. What are the products with high MRP but out of stock
SELECT DISTINCT name, mrp 
FROM zepto 
WHERE outofstock = TRUE 
AND mrp > 300 
ORDER BY mrp DESC;

-- Q3. Calculate estimated revenue for each category
SELECT category,
SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountpercent
FROM zepto
WHERE mrp > 500 
AND discountpercent < 10
ORDER BY mrp DESC, discountpercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountpercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightin_gms, discountedsellingprice,
ROUND(discountedsellingprice / weightin_gms, 2) AS price_per_gram
FROM zepto
WHERE weightin_gms >= 100
ORDER BY price_per_gram;

-- Q7. Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightin_gms,
CASE 
    WHEN weightin_gms < 1000 THEN 'Low'
    WHEN weightin_gms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto;

-- Q8. What is the total inventory weight per category
SELECT category,
SUM(weightin_gms * availablequantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;
