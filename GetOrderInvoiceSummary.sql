DELIMITER//
CREATE PROCEDURE GetOrderInvoiceSummary()
BEGIN
  SELECT 
    SUBSTRING(OrderRef, 3) AS `Order Reference`,
    CONCAT(UPPER(LEFT(MONTHNAME(OrderDate), 3)), '-', YEAR(OrderDate) % 100) AS `Order Period`,
    CONCAT(UCASE(SUBSTRING_INDEX(SupplierName, ' ', 1)), ' ', 
           LOWER(SUBSTRING_INDEX(SUBSTRING_INDEX(SupplierName, ' ', 2), ' ', -1))) AS `Supplier Name`,
    FORMAT(TotalAmount, 2) AS `Order Total Amount`,
    OrderStatus,
    InvoiceRef AS `Invoice Reference`,
    FORMAT(Amount, 2) AS `Invoice Total Amount`,
    CASE
      WHEN EXISTS (SELECT 1 FROM Invoice WHERE OrderID = O.OrderID AND InvoiceStatus = 'Pending') THEN 'To follow up'
      WHEN EXISTS (SELECT 1 FROM Invoice WHERE OrderID = O.OrderID AND InvoiceStatus = '') THEN 'To verify'
      ELSE 'OK'
    END AS `Action`
  FROM `Order` O
  LEFT JOIN Invoice I ON O.OrderID = I.OrderID
  LEFT JOIN Supplier S ON O.SupplierID = S.SupplierID
  ORDER BY OrderDate DESC;
END //
DELIMITER ;

--CALL GetOrderInvoiceSummary();