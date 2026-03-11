USE hospital_system;

-- Foreign keys
ALTER TABLE departments
  ADD CONSTRAINT fk_departments_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE doctors
  ADD CONSTRAINT fk_doctors_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_doctors_department
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE appointments
  ADD CONSTRAINT fk_appointments_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_appointments_patient
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_appointments_doctor
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE medical_records
  ADD CONSTRAINT fk_medrec_appointment
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_medrec_patient
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_medrec_doctor
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_medrec_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE lab_tests
  ADD CONSTRAINT fk_lab_appointment
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
  ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT fk_lab_patient
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_lab_doctor
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_lab_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE prescriptions
  ADD CONSTRAINT fk_rx_appointment
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
  ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT fk_rx_patient
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_rx_doctor
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_rx_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE prescription_items
  ADD CONSTRAINT fk_rx_items_prescription
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE billing_invoices
  ADD CONSTRAINT fk_invoice_appointment
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
  ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT fk_invoice_patient
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
  ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT fk_invoice_hospital
  FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE billing_items
  ADD CONSTRAINT fk_billing_items_invoice
  FOREIGN KEY (invoice_id) REFERENCES billing_invoices(invoice_id)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE payments
  ADD CONSTRAINT fk_payments_invoice
  FOREIGN KEY (invoice_id) REFERENCES billing_invoices(invoice_id)
  ON UPDATE CASCADE ON DELETE CASCADE;

-- Helpful indexes
CREATE INDEX idx_departments_hospital ON departments(hospital_id);
CREATE INDEX idx_doctors_hospital ON doctors(hospital_id);
CREATE INDEX idx_doctors_dept ON doctors(department_id);

CREATE INDEX idx_appt_hospital_dt ON appointments(hospital_id, appointment_datetime);
CREATE INDEX idx_appt_doctor_dt ON appointments(doctor_id, appointment_datetime);
CREATE INDEX idx_appt_patient_dt ON appointments(patient_id, appointment_datetime);

CREATE INDEX idx_medrec_patient_dt ON medical_records(patient_id, visit_datetime);
CREATE INDEX idx_lab_patient_ordered ON lab_tests(patient_id, ordered_at);

CREATE INDEX idx_invoice_patient_date ON billing_invoices(patient_id, invoice_date);
