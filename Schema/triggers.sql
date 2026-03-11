USE hospital_system;

DELIMITER $$

-- Keep billing_items.line_total consistent
CREATE TRIGGER trg_billing_items_before_insert
BEFORE INSERT ON billing_items
FOR EACH ROW
BEGIN
  SET NEW.line_total = NEW.quantity * NEW.unit_price;
END$$

CREATE TRIGGER trg_billing_items_before_update
BEFORE UPDATE ON billing_items
FOR EACH ROW
BEGIN
  SET NEW.line_total = NEW.quantity * NEW.unit_price;
END$$

-- Recompute invoice total after item changes
CREATE TRIGGER trg_billing_items_after_insert
AFTER INSERT ON billing_items
FOR EACH ROW
BEGIN
  UPDATE billing_invoices
  SET total_amount = (
    SELECT COALESCE(SUM(line_total), 0.00) FROM billing_items WHERE invoice_id = NEW.invoice_id
  )
  WHERE invoice_id = NEW.invoice_id;
END$$

CREATE TRIGGER trg_billing_items_after_update
AFTER UPDATE ON billing_items
FOR EACH ROW
BEGIN
  UPDATE billing_invoices
  SET total_amount = (
    SELECT COALESCE(SUM(line_total), 0.00) FROM billing_items WHERE invoice_id = NEW.invoice_id
  )
  WHERE invoice_id = NEW.invoice_id;
END$$

CREATE TRIGGER trg_billing_items_after_delete
AFTER DELETE ON billing_items
FOR EACH ROW
BEGIN
  UPDATE billing_invoices
  SET total_amount = (
    SELECT COALESCE(SUM(line_total), 0.00) FROM billing_items WHERE invoice_id = OLD.invoice_id
  )
  WHERE invoice_id = OLD.invoice_id;
END$$

DELIMITER ;
