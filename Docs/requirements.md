## Multi-Hospital Healthcare Management System (DB)

### Goal
Centralized database to manage operations across multiple hospitals.

### Modules / Entities
- Hospitals
- Departments
- Doctors
- Patients
- Appointments
- Medical records (encounters/diagnoses/notes)
- Lab tests (orders + results)
- Prescriptions
- Billing (invoice + line items + payments)

### Key Rules
- A hospital has many departments.
- A department belongs to one hospital.
- A doctor belongs to one hospital and one department.
- A patient can book many appointments.
- An appointment links patient + doctor + hospital with date/time and status.
- Medical record entries are created from appointments (or visits).
- Lab tests are ordered for a patient (often from an appointment) and have results.
- Prescriptions are issued by a doctor for a patient (often from an appointment).
- Billing invoice is created per appointment/visit and can have multiple line items and payments.

### Reports Needed
- Daily appointments per hospital/doctor
- Patient history summary
- Pending lab results
- Billing totals by date/hospital