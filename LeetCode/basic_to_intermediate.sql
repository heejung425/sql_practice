/* 197. Rising Temperature
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
*/

-- solution #1
SELECT t.id
FROM weather AS t
    INNER JOIN weather AS y
    ON t.recorddate = DATE_ADD(y.recorddate, INTERVAL 1 DAY)
WHERE t.temperature > y.temperature

-- solution #2
SELECT w1.id
FROM weather AS w1, weather AS w2
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.temperature > w2.temperature;


/* 1179. Reformat Department Table
Table: Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
Reformat the table such that there is a department id column and a revenue column for each month.
*/

SELECT  id,
        SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS 'Jan_Revenue', 
        SUM(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS 'Feb_Revenue',
        SUM(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS 'Mar_Revenue',
        SUM(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS 'Apr_Revenue',
        SUM(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS 'May_Revenue',
        SUM(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS 'Jun_Revenue',
        SUM(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS 'Jul_Revenue',
        SUM(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS 'Aug_Revenue',
        SUM(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS 'Sep_Revenue',
        SUM(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS 'Oct_Revenue',
        SUM(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS 'Nov_Revenue',
        SUM(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS 'Dec_Revenue'
FROM department
GROUP BY id
