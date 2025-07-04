---Question 8: Which corporate customer placed the most number of orders in 2009-2012?

SELECT TOP 1 Customer_Name, COUNT(DISTINCT Order_ID) AS Number_Of_Orders
FROM Case_Study
WHERE Customer_Segment = 'Corporate'
GROUP BY Customer_Name
ORDER BY Number_Of_Orders DESC;