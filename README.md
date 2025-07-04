
# 🧾 Kultra Mega Stores – SQL Case Study (2009–2012)

This project analyzes office supply and furniture sales data for **Kultra Mega Stores (KMS)** in Nigeria.  
Focus: Abuja division, covering orders between **2009 and 2012**, using SQL for business analysis.

---

## 📦 Dataset Summary

- `Case_Study.csv`: Orders, products, customers, regions, shipping, and sales.
- `Order_Status.csv`: Information on returned orders.

---

<details>
<summary><strong>🎯 Business Context</strong></summary>

Kultra Mega Stores serves three types of customers:

- Individual Consumers  
- Small Businesses (Retail)  
- Large Corporations (Wholesale)  

I am a **Business Intelligence Analyst** helping the Abuja branch use its data to answer operational and customer questions. The data was provided in CSV format and imported into a SQL Server database table

---

<details>
<summary><strong>📊 Business Questions Answered with SQL</strong></summary>

### 📌 Case Scenario I
1. Which product category had the highest sales?  

2. What are the Top 3 and Bottom 3 regions in terms of sales?  

3. What were the total sales of appliances in Ontario?  

4. What should KMS do to increase revenue from the bottom 10 customers?  

5. Which shipping method cost the most?

### 📌 Case Scenario II
6. Who are the most valuable customers and what do they typically purchase?  

7. Which small business customer had the highest sales?  

8. Which corporate customer placed the most number of orders between 2009–2012?  

9. Which consumer customer was the most profitable?  

10. Which customer returned items, and what segment do they belong to?  

11. Did KMS appropriately spend shipping costs based on order priority?

</details>

---

## 🧾 SQL Queries & Outputs

```sql
-- 1. Product Category with the Highest Sales
SELECT TOP 1 [Product_Category],
SUM(Sales) AS Total_Sales
FROM case_study
GROUP BY [Product_Category]
ORDER BY Total_Sales DESC;
```
![01](https://github.com/user-attachments/assets/0568ade0-cfbd-4ada-9bab-d36a0f9574a8)



```sql
-- 2. Top 3 and Bottom 3 Regions by Sales
---Top 3 Regions
SELECT TOP 3 Region,
SUM(Sales) AS Total_Sales
FROM case_study
GROUP BY Region
ORDER BY Total_Sales DESC;

---Bottom 3 Regions
SELECT TOP 3 Region,
SUM(Sales) AS Total_Sales
FROM case_study
GROUP BY Region
ORDER BY Total_Sales ASC;
```

```sql
-- 3. Total Sales of Appliances in Ontario
SELECT Region, Product_Sub_Category, SUM (Sales) AS [Total_Sales]
FROM Case_Study
WHERE Region = 'Ontario' AND Product_Sub_Category = 'Appliances'
GROUP BY Region, Product_Sub_Category
```

```sql
-- 4. What should KMS do to increase revenue from the bottom 10 customers?  
SELECT TOP 10 [Customer_Name],
SUM(sales) AS Total_Sales
FROM Case_Study
GROUP BY [Customer_Name]
ORDER BY Total_Sales ASC;
```

```sql
-- 5. Which shipping method cost the most?
SELECT Ship_Mode, SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM Case_Study
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost DESC;
```

```sql
-- 6. Who are the most valuable customers and what do they typically purchase?  
-- Step 1: Get total sales by customer and category
WITH CustomerCategorySales AS (
SELECT Customer_Name,Product_Category,
SUM(Sales) AS Category_Sales
FROM Case_Study
GROUP BY Customer_Name, Product_Category),
-- Step 2: Rank each category per customer (most sales first)
RankedCategories AS (
SELECT *, ROW_NUMBER() OVER (
PARTITION BY Customer_Name
ORDER BY Category_Sales DESC) AS rn
FROM CustomerCategorySales),
-- Step 3: Get total sales per customer (for top 5)
CustomerTotals AS (
SELECT Customer_Name, SUM(Category_Sales) AS Total_Sales
FROM CustomerCategorySales
GROUP BY Customer_Name),
-- Step 4: Top 5 customers by total sales
Top5Customers AS (
SELECT TOP 5 * FROM CustomerTotals
ORDER BY Total_Sales DESC)
-- Step 5: Join to get each top customer's top product category
SELECT 
rc.Customer_Name,
rc.Product_Category AS Top_Product_Category,
rc.Category_Sales,
t5.Total_Sales
FROM RankedCategories rc
JOIN Top5Customers t5 ON rc.Customer_Name = t5.Customer_Name
WHERE rc.rn = 1
ORDER BY t5.Total_Sales DESC;
```

```sql
-- 7. Which small business customer had the highest sales? 
SELECT TOP 1 Customer_Name, SUM(Sales) AS Total_Sales
FROM Case_Study
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
```

```sql
-- 8. Which corporate customer placed the most number of orders in 2009-2012?
SELECT TOP 1 Customer_Name, COUNT(DISTINCT Order_ID) AS Number_Of_Orders
FROM Case_Study
WHERE Customer_Segment = 'Corporate'
GROUP BY Customer_Name
ORDER BY Number_Of_Orders DESC;
```

```sql
-- 9.  Which consumer customer was the most profitable?  
SELECT TOP 1 Customer_Name, SUM(Profit) AS Total_Profit
FROM Case_Study
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;
```

```sql
-- 10. Which customer returned items, and what segment do they belong to?  SELECT DISTINCT 
    cs.[Customer_Name],
    cs.[Customer_Segment]
FROM Case_Study cs
INNER JOIN 
Order_Status os ON cs.[Order_ID] = os.[Order_ID]
WHERE os.[Status] = 'Returned';
```

```sql
-- 11. Did KMS appropriately spend shipping costs based on order priority?
WITH EvaluatedOrders AS (
SELECT Order_ID, Customer_Name, Order_Priority, Ship_Mode, Shipping_Cost, 
Order_Date, Ship_Date,
DATEDIFF(DAY, Order_Date, Ship_Date) AS Shipping_Delay,
CASE 
WHEN Order_Priority IN ('Low', 'Medium') AND Ship_Mode = 'Express Air' 
THEN 'Unnecessary Express'
WHEN Order_Priority IN ('High', 'Critical') AND Ship_Mode = 'Delivery Truck' 
THEN 'Slow for Urgent Order'
ELSE 'Appropriate' END AS Shipping_Evaluation
FROM Case_Study)

SELECT Shipping_Evaluation,
COUNT(DISTINCT Order_ID) AS Order_Count,
SUM(Shipping_Cost) AS Total_Shipping_Cost,
AVG(Shipping_Cost) AS Average_Shipping_Cost,
AVG(Shipping_Delay) AS Average_Shipping_Delay
FROM EvaluatedOrders
GROUP BY Shipping_Evaluation
ORDER BY Order_Count DESC;
```


---

<details>
<summary><strong>📈 Key Insights & Answers</strong></summary>

- **Technology** was the highest-selling product category.  
- **Express Air** was the most expensive shipping method; however, many low-priority orders used it unnecessarily.  
- **Emily Phan** was the most valuable and profitable customer (Tech-focused).  
- **Dennis Kane** had the highest small business sales.  
- **Adam Hart** placed the most corporate orders (18 total).  
- **Over 800 orders** had mismatched shipping vs priority, costing KMS ₦25,000+.  
- Most returns came from **Consumer** and **Small Business** segments.

🔎 **Suggestions:**
- Match shipping method to order priority to save cost.  
- Increase revenue from bottom customers using campaigns or bundles.  
- Focus marketing on top regions and best-performing categories.  
- Track and reduce product returns.

</details>

---

## 💻 Tools Used

- SQL Server (SQL Server Management Studio 20)  
- Excel (for dataset review)  
- GitHub (for portfolio sharing)

---

## 👤 About Me

**Victor Adesoye**  
Business Intelligence & Data Analyst  
📧 victoradesoye@gmail.com  
🌍 [LinkedIn](https://linkedin.com/in/victor-adesoye)
