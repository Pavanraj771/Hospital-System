CREATE DATABASE IF NOT EXISTS hospital_system;
USE hospital_system;

-- 1) Hospitals
CREATE TABLE hospitals (
  hospital_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  phone VARCHAR(30),
  email VARCHAR(150),
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2) Departments (per hospital)
CREATE TABLE departments (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  hospital_id INT NOT NULL,
  name VARCHAR(120) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3) Doctors
CREATE TABLE doctors (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  hospital_id INT NOT NULL,
  department_id INT NOT NULL,
  full_name VARCHAR(150) NOT NULL,
  specialization VARCHAR(150),
  phone VARCHAR(30),
  email VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4) Patients
CREATE TABLE patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(150) NOT NULL,
  dob DATE,
  gender VARCHAR(20),
  phone VARCHAR(30),
  email VARCHAR(150),
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5) Appointments
CREATE TABLE appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  hospital_id INT NOT NULL,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_datetime DATETIME NOT NULL,
  status VARCHAR(30) NOT NULL DEFAULT 'SCHEDULED',
  reason VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6) Medical records (per appointment / visit)
CREATE TABLE medical_records (
  record_id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NOT NULL,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  hospital_id INT NOT NULL,
  visit_datetime DATETIME NOT NULL,
  chief_complaint VARCHAR(255),
  diagnosis VARCHAR(255),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7) Lab orders + results
CREATE TABLE lab_tests (
  lab_test_id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NULL,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  hospital_id INT NOT NULL,
  test_name VARCHAR(150) NOT NULL,
  ordered_at DATETIME NOT NULL,
  status VARCHAR(30) NOT NULL DEFAULT 'ORDERED',
  result_value VARCHAR(255) NULL,
  result_unit VARCHAR(50) NULL,
  normal_range VARCHAR(100) NULL,
  reported_at DATETIME NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8) Prescriptions (header + items)
CREATE TABLE prescriptions (
  prescription_id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NULL,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  hospital_id INT NOT NULL,
  prescribed_at DATETIME NOT NULL,
  notes VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prescription_items (
  prescription_item_id INT AUTO_INCREMENT PRIMARY KEY,
  prescription_id INT NOT NULL,
  medicine_name VARCHAR(150) NOT NULL,
  dosage VARCHAR(100),
  frequency VARCHAR(100),
  duration VARCHAR(100),
  instructions VARCHAR(255)
);

-- 9) Billing (invoice + line items + payments)
CREATE TABLE billing_invoices (
  invoice_id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NULL,
  patient_id INT NOT NULL,
  hospital_id INT NOT NULL,
  invoice_date DATE NOT NULL,
  status VARCHAR(30) NOT NULL DEFAULT 'UNPAID',
  total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE billing_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT NOT NULL,
  item_type VARCHAR(50) NOT NULL,
  description VARCHAR(255) NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL,
  line_total DECIMAL(10,2) NOT NULL
);

CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT NOT NULL,
  payment_date DATETIME NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  method VARCHAR(30) NOT NULL,
  reference_no VARCHAR(100)
);
