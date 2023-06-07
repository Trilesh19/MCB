CREATE OR REPLACE PROCEDURE MigrateData AS
BEGIN
    -- Insert supplier data into the Supplier table
    INSERT INTO Supplier (SupplierName, ContactName, Address, ContactNumber, Email)
    SELECT DISTINCT SUPPLIER_NAME, SUPP_CONTACT_NAME, SUPP_ADDRESS, SUPP_CONTACT_NUMBER, SUPP_EMAIL
    FROM XXBCM_ORDER_MGT;

    -- Insert order data into the "Order" table
    INSERT INTO "Order" (OrderRef, OrderDate, SupplierID, TotalAmount, Description, OrderStatus)
    SELECT ORDER_REF, ORDER_DATE, s.SupplierID, ORDER_TOTAL_AMOUNT, ORDER_DESCRIPTION, ORDER_STATUS
    FROM XXBCM_ORDER_MGT o
    INNER JOIN Supplier s ON o.SUPPLIER_NAME = s.SupplierName;

    -- Insert invoice data into the Invoice table
    INSERT INTO Invoice (InvoiceRef, InvoiceDate, OrderID, InvoiceStatus, HoldReason, Amount, Description)
    SELECT INVOICE_REFERENCE, INVOICE_DATE, o.OrderID, INVOICE_STATUS, INVOICE_HOLD_REASON, INVOICE_AMOUNT, INVOICE_DESCRIPTION
    FROM XXBCM_ORDER_MGT o
    INNER JOIN "Order" ord ON o.ORDER_REF = ord.OrderRef;
END;
/