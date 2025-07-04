---Question 4: Advise the management of KMS on what to do to increase revenue from the bottom 10 customers?

SELECT TOP 10 [Customer_Name],
SUM(sales) AS Total_Sales
FROM Case_Study
GROUP BY [Customer_Name]
ORDER BY Total_Sales ASC;