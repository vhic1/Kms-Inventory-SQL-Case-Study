---Question 2: What are the Top 3 and Bottom 3 regions in terms of sales?

---Top 3 Regions
SELECT TOP 3 Region,
SUM(Sales) AS Total_Sales
FROM case_study
GROUP BY Region
ORDER BY Total_Sales DESC;

---Bottom 3 Regions
SELECT TOP 3 Region,
SUM(Sales) AS Total_Sales
FROM case_study
GROUP BY Region
ORDER BY Total_Sales ASC;