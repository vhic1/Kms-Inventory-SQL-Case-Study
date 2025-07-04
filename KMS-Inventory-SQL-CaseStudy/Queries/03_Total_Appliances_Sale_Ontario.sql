---Question 3: What were the total sales of appliances in Ontario?

SELECT Region, Product_Sub_Category, SUM (Sales) AS [Total_Sales]
FROM Case_Study
WHERE Region = 'Ontario' AND Product_Sub_Category = 'Appliances'
GROUP BY Region, Product_Sub_Category