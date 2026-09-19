SELECT * FROM FRAGRANCECATEGORY;
SELECT * FROM GENDERCATEGORY;
SELECT * FROM PERFUME;
SELECT * FROM PERFUMEFRAGRANCEMAP;
SELECT * FROM PERFUMEGENDERMAP;
SELECT * FROM PACKAGINGTYPE;
SELECT * FROM FEATURE;
SELECT * FROM PACKAGINGFEATUREMAP;
SELECT * FROM PERFUMESTOREUSERS;
SELECT * FROM PERFUMESTORECUSTOMERS;
SELECT * FROM PERFUMESTOREMANAGERS;
SELECT * FROM PERFUMESINVENTORY;
SELECT * FROM PERFUMESORDER;
SELECT * FROM PERFUMEORDERLINE;

-- PERFUMES AVAILABLE BASED ON THE GENDER AND FRAGRANCE CATEGORY;
SELECT p.PerfumeID ,p.PerfumeName,p.PerfumeStock || 'ml' AS "Quantity In ml" ,
         fg.CategoryName , fg.LastingHours , g.GenderName
FROM Perfume p
INNER JOIN PerfumeFragranceMap pfg
ON p.PerfumeID = pfg.perfumeID
INNER JOIN FragranceCategory fg
ON fg.CategoryID = pfg.CategoryID
AND fg.CategoryName IN ('Citrus' , 'Oriental' , 'Musky' , 'Fruity' , 'Spicy' , 'Amber')
INNER JOIN PerfumeGenderMap pgm
ON pgm.PerfumeID = p.perfumeID
INNER JOIN GenderCategory g
ON g.GenderID = pgm.CategoryID
AND g.GenderName IN ('Women' , 'Men');

-- MANAGERS
SELECT FirstName || ' ' || LastName AS "Manager Name" ,
       Email , 
       Phone , 
       AccountCreationDate ,
       CNIC , 
       ManagerRole,
       HireDate
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreManagers m
ON u.UserID = m.ManagerID
AND u.UserType IN ('Manager');

--CUSTOMERS
SELECT CustomerID,
       FirstName || ' ' || LastName AS "Customer Name" ,
       Email , 
       Phone ,
       'Street No : ' || StreetNo || ' , ' || 'Mohalla : ' ||Mohalla || ' , ' || City || ' , ' || Province AS "Customer Address",
       AccountCreationDate       
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer');


-- CUSTOMERS ALONG WITH ORDERS
SELECT c.CustomerID,
       FirstName || ' ' || LastName AS "Customer Name" , 
       o.OrderID ,
       p.PerfumeName,
       o.OrderStatus , 
       o.OrderDate ,
       ol.UnitPrice ,
       ol.PackagingPrice,
       ol.OrderedQuantity,
       (ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice AS " Total Price "
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer')
INNER JOIN PerfumesOrder o
ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol
ON o.OrderID = ol.OrderID
INNER JOIN Perfume p
ON p.PerfumeID = ol.PerfumeID;

-- REVENUE BY PRODUCT , OR TOTAL REVENUE OR AVG REVENUE
SELECT
--       p.PerfumeName,SUM(ol.OrderedQuantity),
       SUM((ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice) AS "Total Revenue"
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer')
INNER JOIN PerfumesOrder o
ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol
ON o.OrderID = ol.OrderID
INNER JOIN Perfume p
ON p.PerfumeID = ol.PerfumeID;
--GROUP BY PerfumeName
--ORDER BY "Total Revenue" DESC;

SELECT COUNT(*) AS "INCOMPLETED ORDERS"
FROM PERFUMESORDER 
WHERE ORDERSTATUS = 'In Progress';

-- Order Receipt based on order id 
SELECT FirstName || ' ' || LastName AS "Customer Name" ,
        Phone ,
       'Street No : ' || StreetNo || ' , ' || 'Mohalla : ' ||Mohalla || ' , ' || City || ' , ' || Province AS "Customer Address",
       PerfumeName , 
       UnitPrice , 
       OrderedQuantity , 
       PackagingTypeName , 
       (UnitPrice * OrderedQuantity) + PackagingPrice AS "Total Bill" , 
       OrderStatus , 
       OrderDate , 
       PaymentStatus , 
       PaymentDate
FROM PErfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
INNER JOIN PerfumesORder o
ON c.CustomerID = o.CustomerID AND OrderID = 116
INNER JOIN PerfumeOrderLine ol
ON o.OrderID = ol.OrderID
INNER JOIN PErfume p 
ON p.PerfumeID = ol.PerfumeID
INNER JOIN PackagingType pt
ON pt.PackagingTypeID = ol.PackagingTypeID;

-- Perfumes information based on perfume id 
SELECT p.PerfumeID ,p.PerfumeName,p.PerfumeStock || 'ml' AS "Quantity In Stock(ml)" ,
       fg.CategoryName , fg.LastingHours , g.GenderName
FROM Perfume p
INNER JOIN PerfumeFragranceMap pfg
ON p.PerfumeID = pfg.perfumeID
AND p.PerfumeID = 3
INNER JOIN FragranceCategory fg
ON fg.CategoryID = pfg.CategoryID
AND fg.CategoryName IN ('Citrus' , 'Oriental' , 'Musky' , 'Fruity' , 'Spicy' , 'Amber')
INNER JOIN PerfumeGenderMap pgm
ON pgm.PerfumeID = p.perfumeID
INNER JOIN GenderCategory g
ON g.GenderID = pgm.CategoryID
AND g.GenderName IN ('Women' , 'Men');

-- Based on Cusotmer id , the information , how many orders he has placed till now
SELECT 
    c.CustomerID,
    u.FirstName || ' ' || u.LastName AS "Customer Name",
    o.OrderID,
    o.OrderDate AS "Order Date"
FROM 
    PerfumeStoreCustomers c
INNER JOIN 
    PerfumesOrder o ON c.CustomerID = o.CustomerID
INNER JOIN
    PerfumeStoreUsers u ON u.UserID = c.CustomerID
WHERE 
    c.CustomerID = 18 
    AND TRUNC(o.OrderDate) = '02-MAY-25';
    
SELECT 
    TO_CHAR(OrderDate, 'Mon-YYYY') AS Month,
    COUNT(*) AS TotalOrders
FROM 
    PerfumesOrder
GROUP BY 
    TO_CHAR(OrderDate, 'Mon-YYYY')
ORDER BY 
    TO_DATE(TO_CHAR(OrderDate, 'Mon-YYYY'), 'Mon-YYYY');
    
SELECT TO_CHAR(orderdate , 'DD/MM/YYYY')
FROM PerfumesOrder;
     
SELECT 
    c.CustomerID
FROM 
    PerfumeStoreCustomers c
INNER JOIN 
    PerfumeStoreUsers u ON u.UserID = c.CustomerID
WHERE 
    TRIM(u.FirstName || ' ' || u.LastName) = TRIM('Ali Raza');

SELECT 
    c.CustomerID
   FROM 
    PerfumeStoreCustomers c
   INNER JOIN 
    PerfumeStoreUsers u ON u.UserID = c.CustomerID
    WHERE 
    email = 'ali.raza@example.com';
    
SELECT * FROM PerfumeStoreUsers;


