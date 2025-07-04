
# 🧾 Kultra Mega Stores – SQL Case Study (2009–2012)

This project analyzes office supply and furniture sales data for **Kultra Mega Stores (KMS)** in Nigeria.  
Focus: Abuja division, covering orders between **2009 and 2012**, using SQL for business analysis.

---

## 📦 Dataset Summary

- `KMS Sql Case Study.csv`: Orders, products, customers, regions, shipping, and sales.
- `Order_Status.csv`: Information on returned orders.

---

<details>
<summary><strong>📊 Business Questions Answered</strong></summary>

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

## 🧾 Sample SQL Queries

```sql
-- 1. Product Category with the Highest Sales
SELECT Product_Category, SUM(Sales) AS Total_Sales
FROM Cases_Study
GROUP BY Product_Category
ORDER BY Total_Sales DESC;
```

```sql
-- 2. Top 3 and Bottom 3 Regions by Sales
-- Top 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM Cases_Study
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Bottom 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM Cases_Study
GROUP BY Region
ORDER BY Total_Sales ASC;
```

```sql
-- 3. Total Sales of Appliances in Ontario
SELECT SUM(Sales) AS Total_Appliance_Sales
FROM Cases_Study
WHERE Product_Sub_Category = 'Appliances'
  AND Province = 'Ontario';
```

```sql
-- 5. Shipping Method with the Most Shipping Cost
SELECT Ship_Mode, SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM Cases_Study
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost DESC;
```

```sql
-- 11. Did Shipping Method Match Order Priority?
WITH EvaluatedOrders AS (
    SELECT Order_ID, Order_Priority, Ship_Mode, Shipping_Cost,
           DATEDIFF(DAY, Order_Date, [Ship Date]) AS Shipping_Delay,
           CASE 
               WHEN Order_Priority IN ('Low', 'Medium') AND Ship_Mode = 'Express Air' THEN 'Unnecessary Express'
               WHEN Order_Priority IN ('High', 'Critical') AND Ship_Mode = 'Delivery Truck' THEN 'Slow for Urgent Order'
               ELSE 'Appropriate'
           END AS Shipping_Evaluation
    FROM Cases_Study
)
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
<summary><strong>📈 Key Insights & Recommendations</strong></summary>

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

- SQL Server Management Studio  
- Excel (for dataset review)  
- GitHub (for portfolio sharing)

---

## 👤 About Me

**Victor Adesoye**  
Business Intelligence & Data Analyst  
📧 victoradesoye@gmail.com  
🌍 [LinkedIn](https://linkedin.com/in/victor-adesoye)
