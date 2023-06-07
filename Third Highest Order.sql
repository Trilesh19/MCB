DELIMITER //

CREATE PROCEDURE GetThirdHighestOrderDetails()
BEGIN
  DECLARE orderCount INT;
  DECLARE orderRef VARCHAR(255);
  DECLARE orderDate DATE;
  DECLARE supplierName VARCHAR(255);
  DECLARE orderAmount DECIMAL(10, 2);
  DECLARE orderStatus VARCHAR(255);
  DECLARE invoiceRefs VARCHAR(255);

  SET @rowNumber := 0;
  
  SELECT COUNT(*) INTO orderCount FROM `Order`;
  
  IF orderCount < 3 THEN
    SELECT 'No third highest order found.';
  ELSE
    SELECT
      `Order Reference`,
      `Order Date`,
      `Supplier Name`,
      `Order Total Amount`,
      `Order Status`,
      `Invoice References`
    INTO
      orderRef,
      orderDate,
      supplierName,
      orderAmount,
      orderStatus,
      invoiceRefs
    FROM (
      SELECT 
        @rowNumber := @rowNumber + 1 AS rowNumber,
        SUBSTRING(OrderRef, 3) AS `Order Reference`,
        DATE_FORMAT(OrderDate, '%M %d, %Y') AS `Order Date`,
        UPPER(SupplierName) AS `Supplier Name`,
        FORMAT(TotalAmount, 2) AS `Order Total Amount`,
        OrderStatus,
        GROUP_CONCAT(InvoiceRef ORDER BY InvoiceRef SEPARATOR ', ') AS `Invoice References`
      FROM `Order` O
      LEFT JOIN Invoice I ON O.OrderID = I.OrderID
      LEFT JOIN Supplier S ON O.SupplierID = S.SupplierID
      GROUP BY O.OrderID
      ORDER BY `Order Total Amount` DESC
    ) AS orderInfo
    WHERE rowNumber = 3;

    SELECT
      orderRef AS `Order Reference`,
      orderDate AS `Order Date`,
      supplierName AS `Supplier Name`,
      orderAmount AS `Order Total Amount`,
      orderStatus AS `Order Status`,
      invoiceRefs AS `Invoice References`;
  END IF;
END //

DELIMITER ;

--CALL GetThirdHighestOrderDetails();