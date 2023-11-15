
1. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

```sql
SELECT
  DISTINCT city 
FROM station
WHERE LEFT(city,1) NOT IN('a','e','i','o','u')
  AND RIGHT(city,1) NOT IN('a','e','i','o','u')
```

2. Write a query that prints a list of employee names for employees in Employee having a salary greater than $2,000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.

```sql
SELECT
  name
FROM employee
WHERE salary > 2000
  AND months < 10
ORDER BY employee_id
```


3. Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.
   
```sql
SELECT 
  ROUND(long_w,4)
FROM station
WHERE lat_n =
  (SELECT MAX(lat_n) FROM station WHERE lat_n < 137.2345)
```

4. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings.

```sql
SELECT 
    months * salary AS earnings,
    COUNT(*)
FROM employee
GROUP BY earnings
ORDER BY earnings DESC
LIMIT 1
```

5. Write a query identifying the type of each record in the TRIANGLES table using its three side lengths.
```sql
SELECT CASE
            WHEN A = B AND B = C THEN 'Equilateral'
            WHEN A + B <= C  OR B + C <= A OR A + C <= B THEN 'Not A Triangle'
            WHEN A = B OR B = C OR C = A THEN 'Isosceles'
            ELSE 'Scalene'
        END AS 'shape'
FROM TRIANGLES
```

6. You are given a table, Functions, containing two columns: X and Y. Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1. Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
```sql
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
```

