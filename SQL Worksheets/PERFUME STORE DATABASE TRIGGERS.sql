CREATE OR REPLACE TRIGGER trg_auto_fill_inventory
BEFORE INSERT ON PerfumeInventory
FOR EACH ROW
DECLARE
    v_current_stock INT;
BEGIN
    -- Get current stock of the perfume
    SELECT PerfumeStock INTO v_current_stock
    FROM PERFUME
    WHERE PerfumeID = :NEW.PerfumeID;

    -- Set previous quantity based on current stock
    :NEW.PreviousQuantity := v_current_stock;

    -- Determine if quantity is added or subtracted
    IF UPPER(:NEW.ChangesLog) IN ('RESTOCKED', 'INITIALLY STOCKED') THEN
        :NEW.UpdatedQuantity := v_current_stock + :NEW.QuantityChanged;
    ELSIF UPPER(:NEW.ChangesLog) IN ('SOLD VIA ORDER', 'DAMAGED/EXPIRED', 'RETURNED BY CUSTOMER') THEN
        :NEW.UpdatedQuantity := v_current_stock - :NEW.QuantityChanged;
    ELSE
        -- Default case: no change to stock
        :NEW.UpdatedQuantity := v_current_stock;
    END IF;
    UPDATE Perfume
    SET PerfumeStock = :NEW.UpdatedQuantity
    WHERE PerfumeID = :NEW.PerfumeID;
END;
/

CREATE OR REPLACE TRIGGER trg_check_manager_permission
BEFORE INSERT OR UPDATE OR DELETE ON PerfumeInventory
FOR EACH ROW
DECLARE
    v_manager_id NUMBER;
BEGIN
    -- Assuming a context/session variable or use :NEW/OLD.ManagerID
    IF INSERTING OR UPDATING THEN
        IF :NEW.ManagerID != 1 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Only Manager with ID = 1 can modify inventory.');
        END IF;
    ELSIF DELETING THEN
        IF :OLD.ManagerID != 1 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Only Manager with ID = 1 can delete inventory.');
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_order_id
BEFORE INSERT ON PERFUMESORDER
FOR EACH ROW
WHEN (NEW.ORDERID IS NULL)
BEGIN
  SELECT order_seq.NEXTVAL
  INTO :NEW.ORDERID
  FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_user_id
BEFORE INSERT ON PERFUMESTOREUSERS
FOR EACH ROW
WHEN (NEW.USERID IS NULL)
BEGIN
  SELECT User_SEQ.NEXTVAL
  INTO :NEW.USERID
  FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_perfume_id
BEFORE INSERT ON PERFUME
FOR EACH ROW
WHEN (NEW.PERFUMEID IS NULL)
BEGIN
  SELECT PERFUME_SEQ.NEXTVAL
  INTO :NEW.PERFUMEID
  FROM dual;
END;

/
CREATE OR REPLACE TRIGGER trg_inventory_id
BEFORE INSERT ON PERFUMEINVENTORY
FOR EACH ROW
WHEN (NEW.INVENTORYID IS NULL)
BEGIN
  SELECT INVENTRY_SEQ.NEXTVAL
  INTO :NEW.INVENTORYID
  FROM dual;
END;
/