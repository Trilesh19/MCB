CREATE OR REPLACE PROCEDURE GetOrderInvoiceSummary AS
BEGIN
  SELECT 
    SUBSTR(OrderRef, 3) AS "Order Reference",
    CONCAT(UPPER(SUBSTR(TO_CHAR(OrderDate, 'Month'), 1, 3)), '-', TO_CHAR(OrderDate, 'YY')) AS "Order Period",
    CONCAT(UPPER(SUBSTR(SupplierName, 1, INSTR(SupplierName, ' ') - 1)), ' ', 
           LOWER(SUBSTR(SupplierName, INSTR(SupplierName, ' ') + 1))) AS "Supplier Name",
    TO_CHAR(TotalAmount, 'FM999999990.00') AS "Order Total Amount",
    OrderStatus,
    InvoiceRef AS "Invoice Reference",
    TO_CHAR(Amount, 'FM999999990.00') AS "Invoice Total Amount",
    CASE
      WHEN EXISTS (SELECT 1 FROM Invoice WHERE OrderID = O.OrderID AND InvoiceStatus = 'Pending') THEN 'To follow up'
      WHEN EXISTS (SELECT 1 FROM Invoice WHERE OrderID = O.OrderID AND InvoiceStatus IS NULL) THEN 'To verify'
      ELSE 'OK'
    END AS "Action"
  FROM "Order" O
  LEFT JOIN Invoice I ON O.OrderID = I.OrderID
  LEFT JOIN Supplier S ON O.SupplierID = S.SupplierID
  ORDER BY OrderDate DESC;
END;
/
