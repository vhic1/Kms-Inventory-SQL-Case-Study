---Question 1: Which product category had the highest sales?

SELECT TOP 1 [Product_Category],
SUM(Sales) AS Total_Sales
FROM case_study
GROUP BY [Product_Category]
ORDER BY Total_Sales DESC;