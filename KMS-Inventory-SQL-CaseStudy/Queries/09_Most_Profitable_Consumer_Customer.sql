---Question 9:  Which consumer customer was the most profitable one?

SELECT TOP 1 Customer_Name, SUM(Profit) AS Total_Profit
FROM Case_Study
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;