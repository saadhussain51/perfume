CREATE OR REPLACE VIEW PERFUME_V AS
SELECT p.PerfumeID ,p.PerfumeName, p.PerfumeDescription , p.PerfumePrice , p.PerfumeStock || 'ml' AS "Quantity" ,
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

SELECT * FROM PERFUME_V ORDER BY PerfumeID ASC;

CREATE OR REPLACE VIEW INCOMPLETEORDERS_V AS
SELECT c.CustomerID,
       FirstName || ' ' || LastName AS "Customer_Name" , 
       o.OrderID ,
       p.PerfumeName,
       TO_CHAR(o.OrderDate, 'DD-MON-YYYY') AS ORDER_DATE ,
       ol.UnitPrice ,
       pt.PackagingTypeName,
       ol.OrderedQuantity,
       (ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice AS "TotalPrice",
       OrderStatus
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer')
INNER JOIN PerfumesOrder o
ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol
ON o.OrderID = ol.OrderID
INNER JOIN Perfume p
ON p.PerfumeID = ol.PerfumeID
AND o.OrderStatus IN ('In Progress' , 'Shipped')
INNER JOIN PackagingType pt 
USING(PackagingTypeID)
ORDER BY TO_CHAR(o.OrderDate , 'DD-MON-YYYY');

SELECT * FROM INCOMPLETEORDERS_V;

CREATE OR REPLACE VIEW COMPLETEORDERS_V AS
SELECT c.CustomerID,
       FirstName || ' ' || LastName AS "Customer_Name" , 
       o.OrderID ,
       p.PerfumeName,
       TO_CHAR(o.OrderDate, 'DD-MON-YYYY') AS ORDER_DATE ,
       ol.UnitPrice ,
       pt.PackagingTypeName,
       ol.OrderedQuantity,
       (ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice AS "TotalPrice" ,
       TO_CHAR(o.PaymentDate, 'DD-MON-YYYY') AS PaymentDate
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer')
INNER JOIN PerfumesOrder o
ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol
ON o.OrderID = ol.OrderID
INNER JOIN Perfume p
ON p.PerfumeID = ol.PerfumeID
AND o.OrderStatus IN ('Delivered')
INNER JOIN PackagingType pt 
USING(PackagingTypeID)
ORDER BY TO_CHAR(o.PaymentDate , 'DD-MON-YYYY');

SELECT * FROM INCOMPLETEORDERS_V WHERE PerfumeName = (SELECT PerfumeName FROM Perfume WHERE PErfumeID = 1);

CREATE OR REPLACE VIEW Perfumes_Display AS
SELECT PerfumeID , PerfumeName , PerfumeDescription ,PerfumePrice, PerfumeImage , PerfumeStock
FROM PERFUME;

SELECT * FROM Perfumes_Display;

CREATE OR REPLACE VIEW PERFUMES_V AS
SELECT p.PerfumeID ,p.PerfumeName, p.PerfumeDescription , p.PerfumePrice , p.PerfumeStock || 'ml' AS "Quantity" ,
         fg.CategoryName, g.GenderName, p.PERFUMEIMAGE
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

SELECT * FROM PERFUMES_V;

CREATE OR REPLACE VIEW CheckLoginCredentials AS
SELECT UserID, Email, Password , UserType
FROM PERFUMESTOREUSERS;

SELECT * FROM CHECKLOGINCREDENTIALS;

CREATE OR REPLACE VIEW CustomerPerfumesView AS
SELECT c.CustomerID,
       o.OrderID,
       p.PerfumeName,
       p.PerfumeDescription,
       p.PerfumeImage,
       (ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice AS TotalPrice,
       o.OrderStatus,
       o.OrderDate
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c ON u.UserID = c.CustomerID
INNER JOIN PerfumesOrder o ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol ON o.OrderID = ol.OrderID
INNER JOIN Perfume p ON p.PerfumeID = ol.PerfumeID
INNER JOIN PackagingType pt USING(PackagingTypeID)
WHERE u.UserType = 'Customer';

SELECT PerfumeName, PerfumeDescription, PerfumeImage, TotalPrice, OrderStatus
             FROM CustomerPerfumesView
             WHERE CustomerID = 21;
            
CREATE OR REPLACE VIEW ReceiptView AS 
SELECT c.CustomerID, 
       o.OrderID ,
       o.OrderStatus,
       o.PaymentMethod,
       o.PaymentStatus,
       p.PerfumeName,
       TO_CHAR(o.OrderDate, 'DD-MON-YYYY') AS ORDER_DATE ,
       ol.UnitPrice ,
       pt.PackagingTypeName,
       ol.OrderedQuantity,
       (ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice AS TotalPrice,
       TO_CHAR(o.PaymentDate, 'DD-MON-YYYY') AS PaymentDate
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer')
INNER JOIN PerfumesOrder o
ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol
ON o.OrderID = ol.OrderID
INNER JOIN Perfume p
ON p.PerfumeID = ol.PerfumeID
INNER JOIN PackagingType pt 
USING(PackagingTypeID); 

CREATE OR REPLACE VIEW CustomersView AS 
SELECT 
    c.CustomerID,
    u.FirstName || ' ' || u.LastName AS CustomerName,
    u.Email, 
    u.Phone,
    'Street No: ' || c.StreetNo || ' , Mohalla: ' || c.Mohalla || ' , ' || c.City || ' , ' || c.Province AS CustomerAddress,
    TO_CHAR(u.AccountCreationDate, 'DD-MON-YYYY') AS ACCOUNTCREATIONDATE,
    COUNT(o.OrderID) AS TotalOrders
FROM 
    PerfumeStoreUsers u
INNER JOIN 
    PerfumeStoreCustomers c ON u.UserID = c.CustomerID
LEFT JOIN 
    PerfumesOrder o ON o.CustomerID = c.CustomerID
WHERE 
    u.UserType = 'Customer'
GROUP BY 
    c.CustomerID, u.FirstName, u.LastName, u.Email, u.Phone, c.StreetNo, c.Mohalla, c.City, c.Province, u.AccountCreationDate
ORDER BY 
    c.CustomerID;
    
SELECT * FROM CUSTOMERSVIEW;

CREATE OR REPLACE VIEW SALESDASHBOARD AS
SELECT c.CustomerID,
       FirstName || ' ' || LastName AS CustomerName , 
       p.PerfumeName,
       ol.OrderedQuantity,
       c.City,
       o.OrderID,
       (ol.UnitPrice * ol.OrderedQuantity) + ol.PackagingPrice AS TotalPrice,
       OrderStatus
FROM PerfumeStoreUsers u
INNER JOIN PerfumeStoreCustomers c
ON u.UserID = c.CustomerID
AND u.UserType IN ('Customer')
INNER JOIN PerfumesOrder o
ON c.CustomerID = o.CustomerID
INNER JOIN PerfumeOrderline ol
ON o.OrderID = ol.OrderID
INNER JOIN Perfume p
ON p.PerfumeID = ol.PerfumeID
INNER JOIN PackagingType pt 
USING(PackagingTypeID)
ORDER BY TO_CHAR(o.OrderDate , 'DD-MON-YYYY'), CustomerID;

-- Top 5 Sellling Perfumes
SELECT PErfumeName , SUM(TotalPrice) 
FROM SALESDASHBOARD 
GROUP BY PerfumeName 
ORDER BY SUM(TotalPrice) DESC
FETCH NEXT 5 ROWS ONLY;

-- Total Revenue
SELECT SUM(TotalPrice) AS TotalRevenue 
FROM SALESDASHBOARD
WHERE ORDERSTATUS NOT IN ('Cancelled');

-- Top 5 Customers
SELECT CustomerName , City
FROM SALESDASHBOARD 
GROUP BY CustomerName , City 
ORDER BY SUM(TotalPrice) DESC
FETCH NEXT 5 ROWS ONLY;

-- City Wise Most Orders
SELECT CITY ,  COUNT(OrderID) AS TotalORders 
FROM SALESDASHBOARD
GROUP BY  City 
ORDER BY COUNT(CIty) DESC
FETCH NEXT 5 ROWS ONLY;

--Incompleted Orders
SELECT COUNT(*) AS TotalIncompletedOrders 
FROM SALESDASHBOARD
WHERE ORDERSTATUS IN ('In Progress' , 'Shipped');

-- Completed Orders
SELECT COUNT(*) AS TotalCompletedOrders 
FROM SALESDASHBOARD
WHERE ORDERSTATUS IN ('Delivered');

-- Total Orders
SELECT COUNT(*) AS TotalOrders 
FROM SALESDASHBOARD;

-- Cancelled Orders
SELECT COUNT(*) AS TotalCancelledOrders 
FROM SALESDASHBOARD
WHERE ORDERSTATUS IN ('Cancelled');

SELECT * FROM SALESDASHBOARD;
-- Total Perfumes
SELECT COUNT(*) AS TotalPerfumes FROM PERFUME;

-- Average Order Value
SELECT ROUND(AVG(TotalPrice) , 2)  
FROM SalesDashboard
WHERE ORDERSTATUS NOT IN ('Cancelled');

SELECT CustomerName, COUNT(OrderID) AS Orders, SUM(TotalPrice) AS TotalSpent
FROM SALESDASHBOARD
GROUP BY CustomerName, City
ORDER BY SUM(TotalPrice) DESC
FETCH NEXT 5 ROWS ONLY;

SELECT PerfumeName, SUM(OrderedQuantity) AS UnitsSold , SUM(TotalPrice) AS TotalSales
FROM SALESDASHBOARD
GROUP BY PerfumeName
ORDER BY SUM(TotalPrice) DESC
FETCH NEXT 5 ROWS ONLY;
