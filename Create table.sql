CREATE TABLE Supplier (
  SupplierID INT PRIMARY KEY AUTO_INCREMENT,
  SupplierName VARCHAR(255),
  ContactName VARCHAR(255),
  Address VARCHAR(255),
  ContactNumber VARCHAR(255),
  Email VARCHAR(255)
);

CREATE TABLE Order (
  OrderID INT PRIMARY KEY AUTO_INCREMENT,
  OrderRef VARCHAR(255),
  OrderDate DATE,
  SupplierID INT,
  TotalAmount DECIMAL(10, 2),
  Description VARCHAR(255),
  OrderStatus VARCHAR(255),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Invoice (
  InvoiceID INT PRIMARY KEY AUTO_INCREMENT,
  InvoiceRef VARCHAR(255),
  InvoiceDate DATE,
  OrderID INT,
  InvoiceStatus VARCHAR(255),
  HoldReason VARCHAR(255),
  Amount DECIMAL(10, 2),
  Description VARCHAR(255),
  FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
);
