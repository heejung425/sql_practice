/* 1. Symmetric Pairs 
You are given a table, Functions, containing two columns: X and Y. 
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



/* 2. Weather Observation Station 18
Consider p1(a,b) and p2(c,d) to be two points on a 2D plane.
a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points p1 and p2 and round it to a scale of 4 decimal places.
*/

SELECT  
    ROUND((ABS(MIN(lat_n) - MAX(lat_n)) + ABS(MIN(long_w) - MAX(long_w))),4) -- Manhattan Distance : p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|
FROM station


    
/*3. New Companies
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 
Founder > Lead Manager > Senior Manager > Manager > Employee
Write a query to print the company_code, founder name, total # of lead managers, total # of senior managers, total # of managers, and total # of employees. 
Order your output by ascending company_code.
*/
    
SELECT  
    c.company_code, 
    c.founder, 
    COUNT(DISTINCT lm.lead_manager_code) AS total_lead_managers, 
    COUNT(DISTINCT sm.senior_manager_code) AS total_senior_managers, 
    COUNT(DISTINCT m.manager_code) AS total_managers, 
    COUNT(DISTINCT e.employee_code) AS total_employees
FROM company AS c
    LEFT JOIN lead_manager AS lm ON lm.company_code = c.company_code
    LEFT JOIN senior_manager AS sm ON sm.lead_manager_code = lm.lead_manager_code
    LEFT JOIN manager AS m ON m.senior_manager_code = sm.senior_manager_code
    LEFT JOIN employee AS e ON e.manager_code = m.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code


    
/*4. Top Competitors
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
If more than one hacker received full scores in the same number of challenges, then sort them by ascending hacker_id. 

 There are four tables:
    Hackers (hacker_id, name)
    Difficulty(difficulty_level,score) 
    Challenges (challenge_id, hacker_id, difficulty_level)
    Submissions (submission_id, hacker_id, challenge_id, score)
*/

SELECT 
    s.hacker_id, 
    h.name
FROM submissions AS s
    INNER JOIN hackers AS h ON h.hacker_id = s.hacker_id
    INNER JOIN challenges AS c ON c.challenge_id = s.challenge_id
    INNER JOIN difficulty AS d ON d.difficulty_level = c.difficulty_level
WHERE s.score = d.score  -- to get the full scores
GROUP BY s.hacker_id, h.name
HAVING COUNT(DISTINCT s.submission_id) > 1  --  who took more than one challenge 
ORDER BY COUNT(DISTINCT s.submission_id) DESC, s.hacker_id



/* 5. Weather Observation Station 19
    Query the Euclidean Distance between points p1 and p2 and format your answer to display 4 decimal digits.*/

SELECT 
    ROUND(SQRT(POWER(MAX(lat_n)-MIN(lat_n),2) + POWER(MAX(long_w)-MIN(long_W),2)),4)
FROM station



/* 6. Placements
You are given three tables: Students, Friends and Packages. 
Students contains two columns: ID and Name. 
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.
*/

SELECT 
    s.name
FROM friends AS f
    INNER JOIN students AS s ON s.id = f.id
    INNER JOIN packages AS p ON p.id = f.id
    INNER JOIN packages AS pf ON pf.id = f.friend_id
WHERE pf.salary > p.salary
ORDER BY pf.salary



/* 7. Binary Tree Nodes
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
- Root: If node is root node.
- Leaf: If node is leaf node.
- Inner: If node is neither root nor leaf node.
*/

SELECT n,
    CASE 
        WHEN p IS NULL THEN 'Root'
        WHEN n NOT IN (SELECT p FROM bst WHERE p IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner' END
FROM bst
ORDER BY n


/* 8. Julia asked her students to create some coding challenges.  Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
 Sort your results by the total number of challenges in descending order.  If more than one student created the same number of challenges, then sort the result by hacker_id. 
 If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result
*/

WITH counter AS  (
SELECT 
      hackers.hacker_id
    , hackers.name
    , COUNT(*) AS total_challenge
FROM challenges
    INNER JOIN hackers
    ON hackers.hacker_id = challenges.hacker_id
GROUP BY hackers.hacker_id, hackers.name
    )
    
SELECT 
      counter.hacker_id
    , counter.name
    , counter.total_challenge
FROM counter
WHERE total_challenge = (SELECT MAX(total_challenge)FROM counter)
OR total_challenge IN (
                        SELECT total_challenge
                        FROM counter
                        GROUP BY total_challenge
                        HAVING COUNT(*) = 1
                        )
ORDER BY counter.total_challenge DESC, counter.hacker_id
