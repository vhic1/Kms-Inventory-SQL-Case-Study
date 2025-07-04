---Question 10: Which consumer returned items, and what segment do they belong to?

SELECT DISTINCT 
    cs.[Customer_Name],
    cs.[Customer_Segment]
FROM Case_Study cs
INNER JOIN 
Order_Status os ON cs.[Order_ID] = os.[Order_ID]
WHERE os.[Status] = 'Returned';