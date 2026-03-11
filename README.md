## Hospital System (MySQL)

Multi-hospital healthcare management database project (3NF) with tables, constraints, views, triggers, procedures, and seed data.

### What this project includes

- **Core masters**: hospitals, departments, doctors, patients
- **Operations**: appointments, medical records
- **Clinical**: lab tests, prescriptions (+ prescription items)
- **Billing**: invoices, invoice items, payments
- **Database objects**: foreign keys + indexes, triggers, stored procedures, views

### Project structure

- `Schema/`
  - `create_tables.sql`: database + table definitions
  - `constraints_indexes.sql`: foreign keys + indexes
  - `triggers.sql`: billing totals/line totals triggers
  - `procedures.sql`: stored procedures (invoice creation, report lab result)
  - `views.sql`: reporting views
- `Data/seed_data.sql`: sample data for testing and screenshots
- `Docs/requirements.md`: requirements and scope

### Run order

1. `Schema/create_tables.sql`
2. `Schema/constraints_indexes.sql`
3. `Schema/triggers.sql`
4. `Schema/procedures.sql`
5. `Schema/views.sql`
6. `Data/seed_data.sql`

### How to run (MySQL Workbench)

1. Open MySQL Workbench and connect to your MySQL server.
2. Open each `.sql` file (in the run order above) and execute it.

### How to run (Cursor + SQLTools)

1. Install extensions: `SQLTools` and `SQLTools MySQL/MariaDB`.
2. Add a MySQL connection (host `127.0.0.1`, port `3306`, user like `root`).
3. Open each `.sql` file and run the query.

### Quick test queries

```sql
USE hospital_system;
SHOW TABLES;
SELECT * FROM v_daily_appointments ORDER BY appointment_datetime;
SELECT * FROM v_pending_lab_results;
SELECT * FROM v_billing_totals_by_date;
```

### Useful stored procedures

```sql
-- Create an invoice for an appointment (adds a consultation item)
CALL sp_create_invoice_for_appointment(1, 500.00);

-- Report a lab result
CALL sp_report_lab_result(1, 'Normal', NULL, NULL);
```

### Git + GitHub (basic)

```bash
git add .
git commit -m "Update database project"
git push
```
