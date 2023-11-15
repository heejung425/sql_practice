/* 1. You are given a table, Functions, containing two columns: X and Y. 
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1. 
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
*/

SELECT x, y
FROM functions
WHERE x = y 
GROUP BY x, y 
HAVING COUNT(*) > 1

UNION

SELECT f1.x, f1.y 
FROM functions AS f1
    INNER JOIN functions AS f2
    ON f1.x = f2.y AND f2.x = f1.y
WHERE f1.x < f1.y
ORDER BY x



/* 2. Consider p1(a,b) and p2(c,d) to be two points on a 2D plane.
a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points p1 and p2 and round it to a scale of 4 decimal places.
*/

SELECT  
    ROUND((ABS(MIN(lat_n) - MAX(lat_n)) + ABS(MIN(long_w) - MAX(long_w))),4) -- Manhattan Distance : p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|
FROM station
