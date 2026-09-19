CREATE TABLE FragranceCategory (
    CategoryID         INT PRIMARY KEY,
    CategoryName       VARCHAR(50) NOT NULL,
    IntensityLevel      VARCHAR(20),
    OilConcentration    VARCHAR(30),
    LastingHours        VARCHAR(20),
    AllergicReactions   VARCHAR(255),
    PositiveImpacts     VARCHAR(255),
    SuitableOccasions   VARCHAR(255)
);

CREATE TABLE GenderCategory(
GenderID INT PRIMARY KEY,
GenderName VARCHAR(15)
);

CREATE TABLE Perfume(
PerfumeID INT PRIMARY KEY,
PerfumeName VARCHAR(30) NOT NULL,
PerfumePrice NUMBER(6 , 2),
PerfumeStock INT NOT NULL,
PerfumeDescription VARCHAR(255),
PerfumeImage VARCHAR(255)
);

CREATE TABLE PerfumeFragranceMap(
PerfumeID INT NOT NULL,
CategoryID INT NOT NULL,
CONSTRAINT PerfumeFragranceMap_pk PRIMARY KEY(PerfumeID , CategoryID),
CONSTRAINT PerumeFragranceMap_fk1 FOREIGN KEY(PerfumeID) REFERENCES Perfume(PerfumeID),
CONSTRAINT PerumeFragranceMap_fk2 FOREIGN KEY(CategoryID) REFERENCES FragranceCategory(CategoryID)
);

CREATE TABLE PerfumeGenderMap(
PerfumeID INT NOT NULL,
CategoryID INT NOT NULL,
CONSTRAINT PerfumeGenderMap_pk PRIMARY KEY(PerfumeID , CategoryID),
CONSTRAINT PerumeGenderMap_fk1 FOREIGN KEY(PerfumeID) REFERENCES Perfume(PerfumeID),
CONSTRAINT PerumeGenderMap_fk2 FOREIGN KEY(CategoryID) REFERENCES GenderCategory(GenderID)
);

-- Packaging types with their total price
CREATE TABLE PackagingType (
    PackagingTypeID INT PRIMARY KEY,
    PackagingTypeName VARCHAR2(50) NOT NULL,
    PackagingTypePrice NUMBER(6, 2) NOT NULL
);

-- Features (no price here)
CREATE TABLE Feature (
    FeatureID INT PRIMARY KEY,
    FeatureName VARCHAR2(100) NOT NULL
);

-- Mapping packaging types to their included features
CREATE TABLE PackagingFeatureMap (
    PackagingTypeID INT,
    FeatureID INT,
    PRIMARY KEY (PackagingTypeID, FeatureID),
    FOREIGN KEY (PackagingTypeID) REFERENCES PackagingType(PackagingTypeID),
    FOREIGN KEY (FeatureID) REFERENCES Feature(FeatureID)
);

CREATE TABLE PerfumeStoreUsers (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(40),
    LastName VARCHAR(40) ,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Password VARCHAR(50) NOT NULL,
    UserType VARCHAR(10) CHECK (UserType IN ('Customer', 'Manager')),
    AccountCreationDate DATE DEFAULT SYSDATE
);

CREATE TABLE PerfumeStoreCustomers (
    CustomerID INT PRIMARY KEY,
    StreetNo INT,
    Mohalla VARCHAR (50),
    City VARCHAR (50) ,
    Province VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES PerfumeStoreUsers(UserID)
);

ALTER TABLE PerfumeStoreCustomers
MODIFY (Province VARCHAR(50) NULL);



CREATE TABLE PerfumeStoreManagers (
    ManagerID INT PRIMARY KEY,
    CNIC VARCHAR(15) UNIQUE,
    HireDate DATE DEFAULT SYSDATE,
    ManagerRole VARCHAR(50) NOT NULL,
    FOREIGN KEY (ManagerID) REFERENCES PerfumeStoreUsers(UserID)
);

CREATE TABLE PerfumeInventory (
    InventoryID INT PRIMARY KEY,
    PerfumeID INT NOT NULL,
    ManagerID INT NOT NULL,
    ChangesLog VARCHAR(75) CHECK (ChangesLog IN (
        'Initial Stock Added',
        'Restocked',
        'Damaged/Expired',
        'Returned by Customer',
        'Sold via Order'
    )),
    PreviousQuantity INT CHECK (PreviousQuantity >= 0),
    QuantityChanged INT,
    UpdatedQuantity INT CHECK (UpdatedQuantity >= 0),
    UpdateDate DATE DEFAULT SYSDATE,
    Remarks VARCHAR(255),
    CONSTRAINT Inventory_FK1 FOREIGN KEY (PerfumeID) REFERENCES PERFUME(PerfumeID),
    CONSTRAINT Inventory_FK2 FOREIGN KEY (ManagerID) REFERENCES PerfumeStoreManagers(ManagerID)
);

CREATE TABLE PERFUMESORDER (
    OrderID NUMBER PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE DEFAULT SYSDATE,
    OrderStatus VARCHAR2(20) DEFAULT 'In Progress' CHECK (OrderStatus IN ('In Progress', 'Shipped', 'Delivered','Cancelled')),
    PaymentMethod VARCHAR2(10) DEFAULT 'COD' CHECK (PaymentMethod = 'COD'),
    PaymentStatus VARCHAR2(20) DEFAULT 'Pending' CHECK (PaymentStatus IN ('Pending', 'Confirmed')),
    PaymentDate DATE,
    CONSTRAINT PerfumesOrder_fk FOREIGN KEY(CustomerID) REFERENCES PerfumeStoreCustomers(CustomerID)
);

CREATE TABLE PERFUMEORDERLINE (
    OrderID INT,
    PerfumeID INT,
    PackagingTypeID INT,
    OrderedQuantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    PackagingPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PerfumesOrderline_pk PRIMARY KEY (OrderID, PerfumeID, PackagingTypeID),
    CONSTRAINT PerfumesOrderline_fk1 FOREIGN KEY (OrderID) REFERENCES PERFUMESORDER(OrderID),
    CONSTRAINT PerfumesOrderline_fk2 FOREIGN KEY (PerfumeID) REFERENCES PERFUME(PerfumeID),
    CONSTRAINT PerfumesOrderline_fk3 FOREIGN KEY (PackagingTypeID) REFERENCES PACKAGINGTYPE(PackagingTypeID)
    
);

SELECT uc.constraint_name, uc.table_name, ucc.column_name, uc.search_condition
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'PERFUMESORDER'
  AND ucc.column_name = 'ORDERSTATUS'
  AND uc.constraint_type = 'C';

ALTER TABLE PerfumesOrder
ADD CONSTRAINT CHK_ORDERSTATUS
CHECK (OrderStatus IN ('In Progress', 'Shipped', 'Delivered', 'Cancelled'));

CREATE SEQUENCE order_seq
START WITH 127
INCREMENT BY 1
NOCACHE
NOCYCLE;

DROP SEQUENCE order_seq;

