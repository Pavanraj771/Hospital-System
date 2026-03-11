## Hospital System (MySQL)

Multi-hospital healthcare management database project (3NF) with tables, constraints, views, triggers, procedures, and seed data.

### Run order

1. `Schema/create_tables.sql`
2. `Schema/constraints_indexes.sql`
3. `Schema/triggers.sql`
4. `Schema/procedures.sql`
5. `Schema/views.sql`
6. `Data/seed_data.sql`

### Quick test queries

```sql
USE hospital_system;
SELECT * FROM v_daily_appointments ORDER BY appointment_datetime;
SELECT * FROM v_pending_lab_results;
SELECT * FROM v_billing_totals_by_date;
```
