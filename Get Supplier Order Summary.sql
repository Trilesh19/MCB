DELIMITER //

CREATE PROCEDURE GetSupplierOrderSummary()
BEGIN
  SELECT
    SupplierName AS `Supplier Name`,
    ContactName AS `Supplier Contact Name`,
    CONCAT(
      SUBSTRING(ContactNumber, 1, 4),
      '-',
      SUBSTRING(ContactNumber, 5, 4)
    ) AS `Supplier Contact No. 1`,
    CONCAT(
      SUBSTRING(ContactNumber, 1, 4),
      '-',
      SUBSTRING(ContactNumber, 5, 4)
    ) AS `Supplier Contact No. 2`,
    COUNT(OrderID) AS `Total Orders`,
    FORMAT(SUM(TotalAmount), 2) AS `Order Total Amount`
  FROM
    Supplier S
  JOIN
    `Order` O ON S.SupplierID = O.SupplierID
  WHERE
    O.OrderDate BETWEEN '2017-01-01' AND '2017-08-31'
  GROUP BY
    S.SupplierID;
END //

DELIMITER ;

--CALL GetSupplierOrderSummary();