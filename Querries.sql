USE artgalleryinventorysystem;

-- GENERAL QUERRIES
-- 1. Display all information about the artworks sold for more than $5,00,00,000.

SELECT * FROM Artworks
WHERE price > 50000000;

-- 2. List the names and locations of exhibitions that started in 2023.

SELECT * FROM exhibitions
WHERE YEAR(start_date) = 2023;

-- 3. Retrieve the details of buyers who purchased artworks in 2024.

SELECT * FROM Buyers
WHERE buyer_id IN (
SELECT buyer_id FROM Sales
WHERE YEAR(sale_date) = 2024);

-- 4. Find the total number of exhibitions held in New York.

SELECT COUNT(*) AS Exhibition_Count FROM exhibitions
WHERE location LIKE "%New York%";

-- 5. Show all artworks that were created before 2000 and are available for sale.

SELECT * FROM Artworks
WHERE YEAR(creation_date) < 2000
AND
status = "Available";

-- AGGREGATION QUERRIES
-- 6. Find the average price of artworks sold in 2024.

SELECT AVG(price) AS average_price 
FROM Sales
WHERE YEAR(sale_date) = 2024;

-- 7. Calculate the total revenue generated from sales in each year.

SELECT YEAR(sale_date) AS Year, SUM(price) AS Total_Revenue
FROM Sales
GROUP BY YEAR;

-- 8. Count the number of artworks sold in each exhibition.

SELECT exhibition_id, COUNT(*) AS Artwork_Count
FROM Sales JOIN exhibition_artworks
GROUP BY exhibition_id;

-- 9. Determine the highest and lowest price of artwork sold in 2022.

SELECT 
MAX(price) AS Highest_price,
MIN(price) AS Lowest_price
FROM Sales
WHERE YEAR(sale_date) = 2022;

-- 10. Find the total number of buyers purchased each artwork.

SELECT artwork_id, COUNT(*) AS Artwork_count 
FROM Sales
GROUP BY artwork_id;

-- Joining Queries
-- 11. Display the names of artworks sold, their buyers' names, and the sale price.
SELECT A.title AS Artwork_Name, S.price, B.name As Buyers_Name
FROM Sales AS S
JOIN Artworks AS A
ON S.artwork_id = A.artwork_id
JOIN Buyers AS B
ON S.buyer_id = B.buyer_id;

-- 12. List the exhibitions along with the names of all artworks displayed in them.

SELECT E.name AS Exhibition_Name, A.title AS Artwork_Name
FROM Exhibitions AS E
JOIN Artworks AS A;

-- 13. Find the exhibitions where artworks priced above $5,00,000 were displayed.
SELECT E.name AS Exhibition_Name
FROM Exhibitions AS E
JOIN Exhibition_artworks AS EA
ON E.exhibition_id = EA.exhibition_id
JOIN Artworks AS A
ON EA.artwork_id = A.artwork_id
WHERE A.price > 500000;

-- 14. Display the names of buyers who purchased artworks created by a Thomas Gainsborough.

SELECT B.name AS Buyer_Name
FROM buyers AS B
JOIN Sales AS S
ON B.buyer_id = S.buyer_id
JOIN Artworks AS A
ON S.artwork_id = A.artwork_id
JOIN Artists As ARTST
ON A.artist_id = ARTST.artist_id
WHERE ARTST.name = "Thomas Gainsborough";

-- 15. Retrieve the names of buyers and the titles of the artworks they purchased, along with the exhibition name where the sale occurred.
SELECT B.name AS buyer_name, A.title AS artwork_title, E.name AS exhibition_name 
FROM Sales S
JOIN Buyers B 
ON S.buyer_id = B.buyer_id
JOIN Artworks A 
ON S.artwork_id = A.artwork_id
JOIN Exhibition_Artworks AS EA 
ON A.artwork_id = EA.artwork_id
JOIN Exhibitions AS E
ON EA.exhibition_id = E.exhibition_id;


-- Date Queries
-- 16. List all sales made in the first quarter of 2024.

SELECT * FROM Sales
WHERE YEAR(sale_date) = 2024 AND MONTH(sale_date) BETWEEN 1 AND 3;

-- 17. Retrieve exhibitions that started in the second half of 2023.

SELECT * FROM Exhibitions
WHERE YEAR(start_date) = 2023 AND MONTH(start_date) BETWEEN 7 AND 12;

-- 18. Find artworks sold after their respective exhibition's end date.

SELECT A.title AS Artwork_Name, S.sale_date, E.end_date AS Exhibition_end_date
FROM Artworks AS A
JOIN Sales AS S
ON A.artwork_id = S.artwork_id
JOIN Exhibition_artworks AS EA
ON A.artwork_id = EA.artwork_id
JOIN Exhibitions AS E
ON EA.exhibition_id = E.exhibition_id
WHERE S.sale_date > E.end_date;

-- 19. Show all exhibitions that lasted longer than 60 days in descending orders with respect to days.

SELECT name, DATEDIFF(end_date,start_date) AS DURATION
FROM Exhibitions
WHERE DATEDIFF(end_date,start_date) > 60
ORDER BY DURATION DESC;

-- 20. Retrieve the sale details of artworks sold within a week of their respective exhibition start date.

SELECT S.sale_id, A.title AS Artwork_Name, E.start_date, S.sale_date
FROM Sales AS S
JOIN Artworks AS A
ON S.artwork_id = A.artwork_id
JOIN Exhibition_artworks AS EA
ON S.artwork_id = EA.artwork_id
JOIN exhibitions AS E
ON EA.exhibition_id = E.exhibition_id
WHERE DATEDIFF(S.sale_date,E.start_date) < 7;
