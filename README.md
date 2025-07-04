
# 🧾 Kultra Mega Stores – SQL Case Study (2009–2012)

This project analyzes sales and shipping data for **Kultra Mega Stores (KMS)**, a Nigerian office supplies and furniture company headquartered in Lagos.

The focus is on orders from **2009 to 2012**, specifically from the **Abuja division**, to uncover key business insights using SQL.

---

<details>
<summary><strong>🎯 Business Context</strong></summary>

Kultra Mega Stores serves three types of customers:

- Individual Consumers  
- Small Businesses (Retail)  
- Large Corporations (Wholesale)  

I am a **Business Intelligence Analyst** helping the Abuja branch use its data to answer operational and customer questions. The data was provided in CSV format and imported into a SQL Server database table named `Cases_Study` and `Order_Status`.

</details>

---

<details>
<summary><strong>🗂️ Folder Structure</strong></summary>

```
kms-inventory-sql-case-study/
│
├── data/
→ Raw CSV files
│   ├── KMS Sql Case Study.csv
│   └── Order_Status.csv
│
├── queries/
→ SQL scripts for each business question
│   ├── 01_Product_Category_With_Highest_Sales.sql
│   ├── 02_Top 3_And_Bottom 3_Regions_By_Sales.sql
│   ├── 03_Total_Appliances_Sale_Ontario.sql
│   ├── 04_Bottom 10_Customers.sql
│   ├── 05_Most_Shipping_Cost_Using_A_Particular_Shipping_Method.sql
│   ├── 06_top_customers_by_sales.sql
│   ├── 07_Small_Business_Customer_With_Highest_Sales.sql
│   ├── 08_Corporate_Customer_With_Most_Orders_2009-2012.sql
│   ├── 09_most_profitable_consumer_customer.sql
│   ├── 10_customer_returns.sql
│   └── 11_shipping_evaluation.sql
│
├── output/
→ Screenshots of query results

```

</details>

---

<details>
<summary><strong>📊 Business Questions Answered with SQL</strong></summary>

### 📌 Case Scenario I
1. Which product category had the highest sales?  

2. What are the Top 3 and Bottom 3 regions in terms of sales?  

3. What were the total sales of appliances in Ontario?  

4. Advise the management on what is needed to increase the revenue from the bottom 10 customers  

5. Which shipping method cost the most?  

### 📌 Case Scenario II
6. Who are the most valuable customers and what do they purchase?  

7. Which small business customer had the highest sales?  

8. Which corporate customer placed the most orders between 2009 and 2012?  

9. Which consumer customer was the most profitable?  

10. Which customers returned items, and what segment do they belong to?  

11. Did KMS spend shipping costs appropriately based on order priority?

Each `.sql` file in the `queries/` folder contains clean, commented SQL code for answering each question.

</details>

---

<details>
<summary><strong>🧠 Key Insights/Answers (Summary)</strong></summary>

1. **Technology category** had the highest sales.

2. **West, Ontario, and Prarie** were the top regions in terms of sales.  
- **Nunavut, Northwest Territories, and Yukon** were the bottom regions.

3. Total sales of appliances in Ontario was **₦202,346.9**.

4. The bottom 10 customers showed low engagement and low spend across various categories.  
  - **Recommendations:** Identify if these customers are inactive or new.  
  - Consider email campaigns, bundle offers, or reactivation discounts.

5. **Delivery Truck** incurred the most cost as a shipping method.

6. **Emily Phan** (Technology), **Deborah Brumfield** (Technology), **Roy Skaria** (Furniture) were top customers.

7. **Dennis Kane** was the small business customer with the highest sales.

8. **Adam Hart** placed the most corporate orders (18 orders).

9. **Emily Phan** was the most profitable consumer customer.

10. Over **419 unique customers** returned items.

11. Even though average delays were low, using inappropriate shipping methods;
- **Most orders (5,101)** used the correct shipping method.
- **822 orders were misaligned**:
     - **451 urgent orders** used slow Delivery Truck — risking delays even though average delay looks low as well.
     - **371 non-urgent orders** used Express Air — spending extra for speed they didn’t need..

</details>

---

<details>
<summary><strong>🛠 Tools & Technologies</strong></summary>

- SQL Server (SQL Server Management Studio 20)

</details>

---

<details>
<summary><strong>🚀 How to Use This Project</strong></summary>

1. Download or clone the repo from GitHub  
2. Import the CSV files into SQL Server as tables (`Cases_Study`, etc.)  
3. Open and run the `.sql` files in the `queries/` folder  
4. Explore the output  

</details>

---

<details>
<summary><strong>👤 About Me</strong></summary>

**Victor Adesoye**  
Business Intelligence & Data Analyst  
📧 victoradesoye@gmail.com  
🌍 [LinkedIn](https://www.linkedin.com/in/victor-adesoye)

</details>
