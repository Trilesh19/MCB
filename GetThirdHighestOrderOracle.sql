CREATE OR REPLACE PROCEDURE GetThirdHighestOrderDetails AS
  orderCount INT;
  orderRef VARCHAR2(255);
  orderDate DATE;
  supplierName VARCHAR2(255);
  orderAmount NUMBER(10, 2);
  orderStatus VARCHAR2(255);
  invoiceRefs VARCHAR2(255);

  rowNumber NUMBER := 0;
BEGIN
  SELECT COUNT(*) INTO orderCount FROM "Order";

  IF orderCount < 3 THEN
    DBMS_OUTPUT.PUT_LINE('No third highest order found.');
  ELSE
    SELECT
      "Order Reference",
      "Order Date",
      "Supplier Name",
      "Order Total Amount",
      "Order Status",
      "Invoice References"
    INTO
      orderRef,
      orderDate,
      supplierName,
      orderAmount,
      orderStatus,
      invoiceRefs
    FROM (
      SELECT 
        row_number() over (ORDER BY "Order Total Amount" DESC) AS rowNumber,
        SUBSTR(OrderRef, 3) AS "Order Reference",
        TO_CHAR(OrderDate, 'Month dd, YYYY') AS "Order Date",
        UPPER(SupplierName) AS "Supplier Name",
        TO_CHAR(TotalAmount, 'FM999999990.00') AS "Order Total Amount",
        OrderStatus,
        LISTAGG(InvoiceRef, ', ') WITHIN GROUP (ORDER BY InvoiceRef) AS "Invoice References"
      FROM "Order" O
      LEFT JOIN Invoice I ON O.OrderID = I.OrderID
      LEFT JOIN Supplier S ON O.SupplierID = S.SupplierID
      GROUP BY O.OrderID, OrderRef, OrderDate, SupplierName, TotalAmount, OrderStatus
    )
    WHERE rowNumber = 3;

    DBMS_OUTPUT.PUT_LINE('Order Reference: ' || orderRef);
    DBMS_OUTPUT.PUT_LINE('Order Date: ' || TO_CHAR(orderDate, 'Month dd, YYYY'));
    DBMS_OUTPUT.PUT_LINE('Supplier Name: ' || supplierName);
    DBMS_OUTPUT.PUT_LINE('Order Total Amount: ' || TO_CHAR(orderAmount, 'FM999999990.00'));
    DBMS_OUTPUT.PUT_LINE('Order Status: ' || orderStatus);
    DBMS_OUTPUT.PUT_LINE('Invoice References: ' || invoiceRefs);
  END IF;
END;
/
