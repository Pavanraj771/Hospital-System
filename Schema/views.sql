USE hospital_system;

-- Daily appointments list
CREATE OR REPLACE VIEW v_daily_appointments AS
SELECT
  a.appointment_id,
  a.appointment_datetime,
  a.status,
  h.name AS hospital_name,
  d.full_name AS doctor_name,
  p.full_name AS patient_name,
  a.reason
FROM appointments a
JOIN hospitals h ON h.hospital_id = a.hospital_id
JOIN doctors d ON d.doctor_id = a.doctor_id
JOIN patients p ON p.patient_id = a.patient_id;

-- Patient history summary (appointments + medical notes)
CREATE OR REPLACE VIEW v_patient_history AS
SELECT
  p.patient_id,
  p.full_name AS patient_name,
  mr.visit_datetime,
  mr.chief_complaint,
  mr.diagnosis,
  mr.notes,
  doc.full_name AS doctor_name,
  h.name AS hospital_name
FROM medical_records mr
JOIN patients p ON p.patient_id = mr.patient_id
JOIN doctors doc ON doc.doctor_id = mr.doctor_id
JOIN hospitals h ON h.hospital_id = mr.hospital_id;

-- Pending lab results
CREATE OR REPLACE VIEW v_pending_lab_results AS
SELECT
  lt.lab_test_id,
  lt.test_name,
  lt.ordered_at,
  lt.status,
  p.full_name AS patient_name,
  d.full_name AS doctor_name,
  h.name AS hospital_name
FROM lab_tests lt
JOIN patients p ON p.patient_id = lt.patient_id
JOIN doctors d ON d.doctor_id = lt.doctor_id
JOIN hospitals h ON h.hospital_id = lt.hospital_id
WHERE lt.status IN ('ORDERED', 'IN_PROGRESS');

-- Billing totals by date/hospital
CREATE OR REPLACE VIEW v_billing_totals_by_date AS
SELECT
  bi.invoice_date,
  h.name AS hospital_name,
  COUNT(*) AS invoices_count,
  SUM(bi.total_amount) AS total_billed
FROM billing_invoices bi
JOIN hospitals h ON h.hospital_id = bi.hospital_id
GROUP BY bi.invoice_date, h.name;
