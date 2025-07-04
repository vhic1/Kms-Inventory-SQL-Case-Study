---Question 11: If the delivery truck is the most economical but the slowest, shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately sent shipping costs based on the Order Priority? 

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