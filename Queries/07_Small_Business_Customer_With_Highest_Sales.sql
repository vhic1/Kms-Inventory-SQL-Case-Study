---Question 7: Which small business customer had the highest sales?

SELECT TOP 1 Customer_Name, SUM(Sales) AS Total_Sales
FROM Case_Study
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;