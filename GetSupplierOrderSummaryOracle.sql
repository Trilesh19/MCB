CREATE OR REPLACE PROCEDURE GetSupplierOrderSummary AS
BEGIN
  SELECT
    SupplierName AS "Supplier Name",
    ContactName AS "Supplier Contact Name",
    CONCAT(
      SUBSTR(ContactNumber, 1, 4),
      '-',
      SUBSTR(ContactNumber, 5, 4)
    ) AS "Supplier Contact No. 1",
    CONCAT(
      SUBSTR(ContactNumber, 1, 4),
      '-',
      SUBSTR(ContactNumber, 5, 4)
    ) AS "Supplier Contact No. 2",
    COUNT(OrderID) AS "Total Orders",
    TO_CHAR(SUM(TotalAmount), 'FM999999990.00') AS "Order Total Amount"
  FROM
    Supplier S
  JOIN
    "Order" O ON S.SupplierID = O.SupplierID
  WHERE
    O.OrderDate BETWEEN TO_DATE('2017-01-01', 'YYYY-MM-DD') AND TO_DATE('2017-08-31', 'YYYY-MM-DD')
  GROUP BY
    S.SupplierID;
END;
/
