USE hospital_system;

DELIMITER $$

-- Create an invoice for an appointment with a consultation fee
CREATE PROCEDURE sp_create_invoice_for_appointment(
  IN p_appointment_id INT,
  IN p_consultation_fee DECIMAL(10,2)
)
BEGIN
  DECLARE v_patient_id INT;
  DECLARE v_hospital_id INT;
  DECLARE v_invoice_id INT;

  SELECT patient_id, hospital_id
  INTO v_patient_id, v_hospital_id
  FROM appointments
  WHERE appointment_id = p_appointment_id;

  INSERT INTO billing_invoices (appointment_id, patient_id, hospital_id, invoice_date, status, total_amount)
  VALUES (p_appointment_id, v_patient_id, v_hospital_id, CURDATE(), 'UNPAID', 0.00);

  SET v_invoice_id = LAST_INSERT_ID();

  INSERT INTO billing_items (invoice_id, item_type, description, quantity, unit_price, line_total)
  VALUES (v_invoice_id, 'CONSULTATION', 'Doctor consultation', 1, p_consultation_fee, p_consultation_fee);
END$$

-- Mark lab test as reported
CREATE PROCEDURE sp_report_lab_result(
  IN p_lab_test_id INT,
  IN p_result_value VARCHAR(255),
  IN p_result_unit VARCHAR(50),
  IN p_normal_range VARCHAR(100)
)
BEGIN
  UPDATE lab_tests
  SET status = 'REPORTED',
      result_value = p_result_value,
      result_unit = p_result_unit,
      normal_range = p_normal_range,
      reported_at = NOW()
  WHERE lab_test_id = p_lab_test_id;
END$$

DELIMITER ;
