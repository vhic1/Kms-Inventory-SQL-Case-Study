![Image 7](https://github.com/user-attachments/assets/157979a8-5515-42a9-89bc-58a8a25988f6)
# 🧾 Kultra Mega Stores – SQL Case Study (2009–2012)

This project analyzes office supply and furniture sales data for **Kultra Mega Stores (KMS)** in Nigeria.  
Focus: Abuja division, covering orders between **2009 and 2012**, using SQL for business analysis.

---

## 📦 Dataset Summary

- `Case_Study.csv`: Orders, products, customers, regions, shipping, and sales.
- `Order_Status.csv`: Information on returned orders.

---

## 🎯 Business Context

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

**Output/Visual**

[Image 1](https://github.com/user-attachments/assets/f9cb84eb-23d4-4ce9-ad76-4d394dda0f95)


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

**Output/Visual**


[Image 2 1](https://github.com/user-attachments/assets/0798b69f-48d0-4254-bc9c-89e843e072c6)
[Image 2 2](https://github.com/user-attachments/assets/e58219c5-3041-46c2-99f6-00043ec21e1e)

```sql
-- 3. Total Sales of Appliances in Ontario
SELECT Region, Product_Sub_Category, SUM (Sales) AS [Total_Sales]
FROM Case_Study
WHERE Region = 'Ontario' AND Product_Sub_Category = 'Appliances'
GROUP BY Region, Product_Sub_Category
```

**Output/Visual**

[Image 3](https://github.com/user-attachments/assets/eec57459-bf6e-4792-b067-646c8398046b)


```sql
-- 4. What should KMS do to increase revenue from the bottom 10 customers?  
SELECT TOP 10 [Customer_Name],
SUM(sales) AS Total_Sales
FROM Case_Study
GROUP BY [Customer_Name]
ORDER BY Total_Sales ASC;
```

**Output/Visual**

[Image 4](https://github.com/user-attachments/assets/70f172ea-b57d-4bc0-87fb-ac9caf7f729b)


```sql
-- 5. Which shipping method cost the most?
SELECT Ship_Mode, SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM Case_Study
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost DESC;
```

**Output/Visual**

[Image 5](https://github.com/user-attachments/assets/b253c3d0-2c1a-4b3e-a018-f1da6810ae8f)

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

**Output/Visual**

[Image 6](https://github.com/user-attachments/assets/45f7ca05-7ad6-459f-b23c-0b6450d9e800)

```sql
-- 7. Which small business customer had the highest sales? 
SELECT TOP 1 Customer_Name, SUM(Sales) AS Total_Sales
FROM Case_Study
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
```

**Output/Visual**

[Image 7](https://github.com/user-attachments/assets/3e7fbfe2-ad72-4b88-98fb-eb82ed951cbd)



```sql
-- 8. Which corporate customer placed the most number of orders in 2009-2012?
SELECT TOP 1 Customer_Name, COUNT(DISTINCT Order_ID) AS Number_Of_Orders
FROM Case_Study
WHERE Customer_Segment = 'Corporate'
GROUP BY Customer_Name
ORDER BY Number_Of_Orders DESC;
```

**Output/Visual**

[Image 8](https://github.com/user-attachments/assets/08e0f285-ddd0-4f10-ac99-987908416c35)


```sql
-- 9.  Which consumer customer was the most profitable?  
SELECT TOP 1 Customer_Name, SUM(Profit) AS Total_Profit
FROM Case_Study
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;
```

**Output/Visual**

[Image 9](https://github.com/user-attachments/assets/0d33e0e5-2c4a-45ef-b2f2-7c622323ce71)


```sql
-- 10. Which customer returned items, and what segment do they belong to?  SELECT DISTINCT 
    cs.[Customer_Name],
    cs.[Customer_Segment]
FROM Case_Study cs
INNER JOIN 
Order_Status os ON cs.[Order_ID] = os.[Order_ID]
WHERE os.[Status] = 'Returned';
```

**Output/Visual**

[Image 10](https://github.com/user-attachments/assets/2a0695d5-a620-4a31-bf87-a28d5f4e9352)


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

**Output/Visual**

[Image 11](https://github.com/user-attachments/assets/342d0d88-5938-43b2-83ca-d068dd2355a3)



---

<details>
<summary><strong>📈 Key Insights & Answers to the Questions</strong></summary>

1. **Technology category** had the highest sales.

2. **West, Ontario, and Prarie** were the top regions in terms of sales.
        -**Nunavut, Northwest Territories, and Yukon** were the bottom regions.

3. Total sales of appliances in Ontario was **₦202,347**.

4. The bottom 10 customers showed low engagement and low spend across various categories.
- **Recommendations:**
      - Identify if these customers are inactive or new.
      - Consider email campaigns, bundle offers, or enticing discounts.

5.**Delivery Truck** incurred the most cost as a shipping method.  

6.**Emily Phan** (Technology), **Deborah Brumfield** (Technology), **Roy Skaria** (Furniture) were top customers.

7.**Dennis Kane** was the small business customer with the highest sales.

8.**Adam Hart** placed the most corporate orders **(18 orders)**.

9.**Emily Phan** was the most profitable consumer customer. 

10.Over **419 unique customers** returned items across different segments.  

11. While **most orders (5,101)** used appropriate shipping,
- **822 orders were misaligned**, due to mismatched shipping vs priority.
- 451 urgent orders used slow Delivery Truck — risking delays even though average delay looks low.
- 371 non-urgent orders used Express Air — spending extra for speed they didn’t need.

🔎 **Suggestions:**
- Match shipping method to order priority to save cost.  
- Increase revenue from bottom customers using campaigns or bundles.    
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
DSA Data Analyst Student 
📧 victoradesoye@gmail.com  
🌍 [LinkedIn](https://linkedin.com/in/victor-adesoye)
