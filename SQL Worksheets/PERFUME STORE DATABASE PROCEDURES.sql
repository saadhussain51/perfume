CREATE OR REPLACE PROCEDURE update_order_and_payment_status (
    p_order_id     IN INT,
    p_orderStatus  IN VARCHAR
)
IS
BEGIN
    -- Update order status
    UPDATE PerfumesOrder
    SET OrderStatus = p_orderStatus,
        PaymentDate = SYSDATE
    WHERE OrderID = p_order_id;

    -- If order is delivered, update payment status and payment date
    IF UPPER(p_orderStatus) = 'DELIVERED' THEN
        UPDATE PerfumesOrder
        SET PaymentStatus = 'Confirmed'
        WHERE OrderID = p_order_id;
    END IF;

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE RegisterProcedure (
CustomerEmail IN VARCHAR,
CustomerPassword IN VARCHAR,
UserType IN VARCHAR ) AS
UserIDC INT;
BEGIN
  INSERT INTO PERFUMESTOREUSERS (Email, Password , USerType) VALUES (CustomerEmail, CustomerPassword , UserType);
  
  SELECT USERID INTO UserIDC
  FROM PERFUMESTOREUSERS
  WHERE Email = CustomerEmail;
  
  INSERT INTO PERFUMESTORECUSTOMERS(CustomerID) VALUES (UserIDC); 
END;
/

BEGIN
 RegisterProcedure( 'shahnawaz@gmail.com', 'Shani@111' , 'Customer');
END;

/
CREATE OR REPLACE PROCEDURE PlacePerfumeOrder (
    p_CustomerID      IN INT,
    p_PerfumeID       IN INT,
    p_PackagingTypeID IN INT,
    p_OrderedQuantity IN INT,
    -- New User Details
    p_FirstName       IN VARCHAR,
    p_LastName        IN VARCHAR,
    p_PhoneNumber     IN VARCHAR,
    -- New Address Details
    p_Street          IN INT,
    p_Mohallah        IN VARCHAR,
    p_City            IN VARCHAR,
    p_Province        IN VARCHAR
) AS
    v_UnitPrice       NUMBER;
    v_PackagingPrice  NUMBER;
    v_OrderId         INT;
BEGIN
    -- Get perfume unit price
    SELECT PerfumePrice INTO v_UnitPrice
    FROM PERFUME
    WHERE PerfumeID = p_PerfumeID;


    -- ✅ Update user info in PerfumeStoreUsers
    UPDATE PerfumeStoreUsers
    SET FirstName = p_FirstName,
        LastName = p_LastName,
        Phone = p_PhoneNumber
    WHERE UserID = p_CustomerID;

    -- ✅ Update address in PerfumeStoreCustomers
    UPDATE PerfumeStoreCustomers
    SET StreetNo = p_Street,
        Mohalla = p_Mohallah,
        City = p_City,
        Province = p_Province
    WHERE CustomerID = p_CustomerID;

    -- Get packaging price
    SELECT PackagingTypePrice INTO v_PackagingPrice
    FROM PACKAGINGTYPE
    WHERE PackagingTypeID = p_PackagingTypeID;

    -- Insert into PERFUMESORDER
    INSERT INTO PERFUMESORDER (
        CustomerID, OrderDate, OrderStatus, PaymentMethod, PaymentStatus, PaymentDate
    ) VALUES (
       p_CustomerID, SYSDATE, 'In Progress', 'COD', 'Pending', NULL
    );

    SELECT OrderID INTO v_OrderID 
    FROM PERFUMESORDER
    ORDER BY ORDERDATE DESC
    FETCH NEXT 1 ROW ONLY;
    
    -- Insert into PERFUMEORDERLINE
    INSERT INTO PERFUMEORDERLINE (
        OrderID, PerfumeID, PackagingTypeID, OrderedQuantity, UnitPrice, PackagingPrice
    ) VALUES (
        v_OrderID, p_PerfumeID, p_PackagingTypeID, p_OrderedQuantity, v_UnitPrice, v_PackagingPrice
    );
    
    UPDATE PERFUME
    SET PerfumeStock = PerfumeStock - (50*p_OrderedQuantity)
    WHERE PerfumeID = p_PerfumeID;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
PlacePerfumeOrder(
23 , 60 , 2 , 2 , 'Muhammad' , 'Nawaz' , '03190876543' ,03 , 'Dhoke Khabba', 'Rawalpindi' , 'Punjab');
END;
/

CREATE OR REPLACE PROCEDURE UpdatePrices(
PerID IN INT,
UpdatedPrice IN NUMBER )
AS 
BEGIN
  UPDATE Perfume
  SET PerfumePrice = UpdatedPrice
  WHERE PerfumeID = PerID;
END;
/

BEGIN
UpdatePrices(1 , 2900);
END;
/

CREATE OR REPLACE PROCEDURE AddPerfume(
P_Name IN VARCHAR,
P_Description IN VARCHAR,
P_Price IN VARCHAR,
P_Stock IN NUMBER,
P_ImagePath IN VARCHAR,
F_ID IN INT,
G_ID IN INT)
AS
P_ID INT;
BEGIN
 INSERT INTO Perfume(PerfumeName , PerfumeDescription, PerfumePrice , PerfumeStock , PerfumeImage) VALUES ( P_Name, P_Description , P_Price , P_Stock , P_ImagePath);
 
 SELECT PerfumeID INTO P_ID
 FROM PERFUME
 WHERE PERFUMENAME = P_Name AND PerfumeImage = P_ImagePath;
 
 INSERT INTO PERFUMEGENDERMAP VALUES (P_ID , G_ID);
 INSERT INTO PERFUMEFRAGRANCEMAP VALUES (P_ID , F_ID);
END;
/
BEGIN
ADDPERFUME( 'Luxurious Floral Musk' , ' A great long lasting perfume for women specially on wedding ocassions' , 6500 , 4500 , '../Images/WOMEN/MUSKY/Luxurious Floral Musk.jpg' , 4 , 2);
END;
/
CREATE OR REPLACE PROCEDURE InventoryChanges(
P_ID IN INT,
M_ID IN INT,
ChLog IN VARCHAR,
QtyChng IN VARCHAR,
Remarks IN VARCHAR
) 
AS 
BEGIN 
INSERT INTO PERFUMEINVENTORY ( PerfumeID, ManagerID, ChangesLog, QuantityChanged, Remarks)
VALUES ( P_ID , M_ID , ChLog , QtyChng , Remarks );
END;
/
BEGIN
InventoryChanges(2 , 1 , 'Damaged/Expired' , 4500 , 'Expired due to incidental actions'); 
END;
/
