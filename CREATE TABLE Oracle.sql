CREATE TABLE Supplier (
  SupplierID NUMBER PRIMARY KEY,
  SupplierName VARCHAR2(255),
  ContactName VARCHAR2(255),
  Address VARCHAR2(255),
  ContactNumber VARCHAR2(255),
  Email VARCHAR2(255)
);

CREATE TABLE "Order" (
  OrderID NUMBER PRIMARY KEY,
  OrderRef VARCHAR2(255),
  OrderDate DATE,
  SupplierID NUMBER,
  TotalAmount NUMBER(10, 2),
  Description VARCHAR2(255),
  OrderStatus VARCHAR2(255),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Invoice (
  InvoiceID NUMBER PRIMARY KEY,
  InvoiceRef VARCHAR2(255),
  InvoiceDate DATE,
  OrderID NUMBER,
  InvoiceStatus VARCHAR2(255),
  HoldReason VARCHAR2(255),
  Amount NUMBER(10, 2),
  Description VARCHAR2(255),
  FOREIGN KEY (OrderID) REFERENCES "Order"(OrderID)
);