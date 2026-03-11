USE hospital_system;

-- Hospitals
INSERT INTO hospitals (name, phone, email, address) VALUES
('City Care Hospital', '040-111111', 'citycare@example.com', 'Hyderabad'),
('Green Valley Hospital', '040-222222', 'greenvalley@example.com', 'Secunderabad');

-- Departments
INSERT INTO departments (hospital_id, name) VALUES
(1, 'Cardiology'),
(1, 'General Medicine'),
(1, 'Orthopedics'),
(2, 'Pediatrics'),
(2, 'Dermatology');

-- Doctors
INSERT INTO doctors (hospital_id, department_id, full_name, specialization, phone, email) VALUES
(1, 1, 'Dr. Asha Reddy', 'Cardiologist', '900000001', 'asha.reddy@example.com'),
(1, 2, 'Dr. Vikram Rao', 'Physician', '900000002', 'vikram.rao@example.com'),
(1, 3, 'Dr. Neha Singh', 'Orthopedic Surgeon', '900000003', 'neha.singh@example.com'),
(2, 4, 'Dr. Arjun Kumar', 'Pediatrician', '900000004', 'arjun.kumar@example.com'),
(2, 5, 'Dr. Meera Iyer', 'Dermatologist', '900000005', 'meera.iyer@example.com');

-- Patients
INSERT INTO patients (full_name, dob, gender, phone, email, address) VALUES
('Sai Teja', '2001-02-14', 'Male', '800000001', 'saiteja@example.com', 'Hyderabad'),
('Ananya Sharma', '1999-08-21', 'Female', '800000002', 'ananya@example.com', 'Hyderabad'),
('Rahul Verma', '1988-01-10', 'Male', '800000003', 'rahul@example.com', 'Secunderabad'),
('Kavya Nair', '2005-06-05', 'Female', '800000004', 'kavya@example.com', 'Secunderabad');

-- Appointments
INSERT INTO appointments (hospital_id, patient_id, doctor_id, appointment_datetime, status, reason) VALUES
(1, 1, 2, '2026-03-12 10:00:00', 'SCHEDULED', 'Fever and cold'),
(1, 2, 1, '2026-03-12 11:30:00', 'SCHEDULED', 'Chest pain'),
(2, 3, 4, '2026-03-12 12:15:00', 'SCHEDULED', 'Child vaccination consultation'),
(2, 4, 5, '2026-03-12 15:00:00', 'SCHEDULED', 'Skin rash');

-- Medical records (example for completed visit)
UPDATE appointments SET status = 'COMPLETED' WHERE appointment_id = 2;
INSERT INTO medical_records (appointment_id, patient_id, doctor_id, hospital_id, visit_datetime, chief_complaint, diagnosis, notes)
VALUES
(2, 2, 1, 1, '2026-03-12 11:45:00', 'Chest pain', 'Gastritis', 'Advised ECG and basic blood tests. Started medication.');

-- Lab tests
INSERT INTO lab_tests (appointment_id, patient_id, doctor_id, hospital_id, test_name, ordered_at, status)
VALUES
(2, 2, 1, 1, 'ECG', '2026-03-12 11:50:00', 'ORDERED'),
(2, 2, 1, 1, 'CBC', '2026-03-12 11:50:00', 'ORDERED');

-- Prescription
INSERT INTO prescriptions (appointment_id, patient_id, doctor_id, hospital_id, prescribed_at, notes)
VALUES
(2, 2, 1, 1, '2026-03-12 12:05:00', 'After food');

INSERT INTO prescription_items (prescription_id, medicine_name, dosage, frequency, duration, instructions)
VALUES
(1, 'Omeprazole', '20mg', 'Once daily', '7 days', 'Take after breakfast'),
(1, 'Antacid syrup', '10ml', 'Twice daily', '5 days', 'After meals');

-- Billing: create an invoice manually (you can also use stored procedure later)
INSERT INTO billing_invoices (appointment_id, patient_id, hospital_id, invoice_date, status, total_amount)
VALUES (2, 2, 1, '2026-03-12', 'UNPAID', 0.00);

INSERT INTO billing_items (invoice_id, item_type, description, quantity, unit_price, line_total)
VALUES
(1, 'CONSULTATION', 'Doctor consultation', 1, 500.00, 500.00),
(1, 'LAB', 'ECG', 1, 300.00, 300.00),
(1, 'LAB', 'CBC', 1, 250.00, 250.00);

INSERT INTO payments (invoice_id, payment_date, amount, method, reference_no)
VALUES (1, '2026-03-12 12:30:00', 1050.00, 'CASH', 'CASH-0001');
