
---top 10 best selling games in North America--
SELECT TOP 10 *
FROM VideoGame..sales
ORDER BY NA_Sales desc


--Total Sales by location---
SELECT ROUND(SUM(NA_Sales),4) as NA_Total_Sales,
	   ROUND(SUM(EU_Sales),4) as EU_Total_Sales, 
	   ROUND(SUM(JP_Sales),4) as JP_Total_Sales, 
	   ROUND(SUM(Other_Sales),4) as Other_Total_Sales,
	   ROUND(SUM(Global_Sales), 4) as Global_Total_Sales
FROM VideoGame..sales


---Percent regional sales for each game--
SELECT Name, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales,
ROUND(NA_Sales/Global_Sales,3) * 100 as NA_percent,
ROUND(EU_Sales/Global_Sales, 3) * 100 as EU_percent,
ROUND(JP_Sales/Global_Sales,3) * 100 as JP_percent,
ROUND(Other_Sales/Global_Sales,3) * 100 as Other_percent
FROM VideoGame..sales


--Total Global sales by platform--
SELECT d.Platform, SUM(s.Global_Sales) as total_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
GROUP BY d.Platform
ORDER BY total_sales desc


--Regional sales by platform (North America)---
SELECT d.Platform, SUM(s.NA_Sales) as NA_total_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
GROUP BY d.Platform
ORDER BY NA_total_sales desc


--Regional sales by platform (Europe)---
SELECT d.Platform, SUM(s.EU_Sales) as EU_total_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
GROUP BY d.Platform
ORDER BY EU_total_sales desc


--Regional sales by platform (Japan)---
SELECT d.Platform, SUM(s.JP_Sales) as JP_total_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
GROUP BY d.Platform
ORDER BY JP_total_sales desc


---Most sales by video game genres--
SELECT TOP 10 d.Genre, SUM(s.Global_Sales) as Global_total_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
GROUP BY d.Genre
ORDER BY Global_total_sales desc


--Global and Regional Yearly Sales from 1980 to 2016 --
SELECT d.Year, SUM(s.NA_Sales) as NA_yearly_sales,
SUM(s.EU_Sales) as EU_yearly_sales,
SUM(s.JP_Sales) as JP_yearly_sales,
SUM(s.Other_Sales) as Other_yearly_sales,
SUM(s.Global_Sales) as Global_yearly_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
WHERE d.Year is not null 
AND d.Year BETWEEN 1980 AND 2016
GROUP BY d.Year
ORDER BY d.Year desc


----Create View for Global Yearly Sales-----
Create View Global_Sales_View as 
SELECT d.Year, SUM(s.Global_Sales) as Global_yearly_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
WHERE d.Year is not null
GROUP BY d.Year
ORDER BY d.Year desc


-----Global Sales using CTE (Rolling Sales)-----------
SELECT d.Name, d.Year, s.Global_Sales, SUM(s.Global_Sales) OVER (Partition by d.Year ORDER BY s.Rank) as Rolling_Global_Sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
WHERE d.Year is not null
ORDER BY d.Year


---Sales by platform from 1980 to 2016------------
SELECT d.Year, d.Platform, SUM(s.Global_Sales) as Global_yearly_sales
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
WHERE d.Year is not null 
AND d.Year BETWEEN 1980 AND 2016
GROUP BY d.Year, d.Platform
ORDER BY d.Year desc


---Regional sales from 1980 to 2016 (Subquery)-------------
SELECT  
	  NA_Total_Sales,
      ROUND(NA_Total_Sales/Total, 4) * 100 as NA_percent,
	  EU_Total_Sales,
      ROUND(EU_Total_Sales/Total, 4) * 100 as EU_percent,
	  JP_Total_Sales,
      ROUND(JP_Total_Sales/Total,4) * 100 as JP_percent,
	  Other_Total_Sales,
      ROUND(Other_Total_Sales/Total,4) * 100 as Other_percent,
	  Total
FROM
(
SELECT
       ROUND(SUM(NA_Sales), 5) as NA_Total_Sales,
	   ROUND(SUM(EU_Sales),4) as EU_Total_Sales, 
	   ROUND(SUM(JP_Sales),4) as JP_Total_Sales, 
	   ROUND(SUM(Other_Sales),4) as Other_Total_Sales,
	   ROUND(SUM(Global_Sales), 4) as Global_Total_Sales,
	  SUM(NA_Sales + EU_Sales + JP_Sales + Other_Sales) as Total
FROM VideoGame..description d
JOIN VideoGame..sales s
	ON d.Name = s.Name
WHERE d.Year is not null
AND d.Year BETWEEN 1980 AND 2016
) AS subquery
	