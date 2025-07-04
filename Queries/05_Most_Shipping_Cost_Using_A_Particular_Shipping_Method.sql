---Question 5: KMS incurred the most shipping cost using which shipping method?

SELECT Ship_Mode, SUM(Shipping_Cost) AS Total_Shipping_Cost
FROM Case_Study
GROUP BY Ship_Mode
ORDER BY Total_Shipping_Cost DESC;