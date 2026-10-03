# Database SQL Exercises (DBI202)

A collection of exercises and solutions for the **Database Systems (DBI202)** course, covering ERD design, relational schema creation, SQL queries, stored procedures, and practical exam (PE) practice. All scripts are written for **Microsoft SQL Server (T-SQL)**.

## Repository Structure

```
database-sql-exercise-dbi202/
├── ERD-design-exercise/     # ERD-to-schema exercises (Bai 1-7)
├── Northwind-exercise/      # Query exercises on the Northwind database
├── Workshop-exercise/       # Workshop solutions
├── Procedure-exercise/      # Stored procedure lab (SP_1 - SP_10)
├── PE-SP26-Paper1/          # Practical exam practice (Spring 2026)
├── PE-SU26-Paper5/          # Practical exam practice (Summer 2026)
├── PE-SU26-Paper7/
├── PE-SU26-Paper8/
├── PE-SU26-Trial1/          # Trial exam
└── DBI202_SU26_B5_PE/       # Practical exam (Summer 2026, Block 5)
```

## Contents

| Folder | Topic | Description |
|--------|-------|-------------|
| `ERD-design-exercise` | Database design | Converts ERD problems into SQL Server schemas (tables, primary keys, foreign keys, composite keys, weak entities). Includes the problem statement `ERD.pdf`. Each exercise (`Bai_1` to `Bai_7`, with `5a` and `5b`) creates its own database. |
| `Northwind-exercise` | SELECT queries | Solutions for query exercises on the Northwind sample database. |
| `Workshop-exercise` | Workshop | Solutions for workshop sessions (`DapAnWS4`, `DapAnWS4_P2`). |
| `Procedure-exercise` | Stored procedures | Ten stored procedures (`SP_1` to `SP_10`) and the lab handout. |
| `PE-*` and `DBI202_SU26_B5_PE` | Practical exams | Exam papers with database scripts (`DBscript.sql`) and my solutions (`Q1.sql`, `Q2.sql`, ...). |

## Getting Started

### Requirements
- Microsoft SQL Server (2019 or later recommended)
- SQL Server Management Studio (SSMS)

### Running the scripts
1. Clone the repository:
```bash
   git clone https://github.com/NguyenBaTam-tristan/database-sql-exercise-dbi202.git
```
2. Open the desired `.sql` file in SSMS.
3. Execute it (press `F5`).

For the practical exam folders, run `DBscript.sql` first to create and populate the database, then run the question scripts (`Q1.sql`, `Q2.sql`, ...).

For the Northwind exercises, make sure the Northwind database is installed on your SQL Server instance before running the queries.

## Topics Covered

- Entity Relationship Diagram (ERD) design and ERD-to-relational mapping
- DDL: `CREATE DATABASE`, `CREATE TABLE`, constraints
- `SELECT` queries: joins, grouping, aggregation, subqueries
- Stored procedures (T-SQL)
- Exam-style problem solving

## Notes

- Solutions are my own work and are shared for learning and reference purposes. They may not be the only or the optimal answer.
- Problem statements and course materials belong to their respective authors and the course instructors.
- If you are a student, please try the problems yourself before looking at the solutions.

## Author

**Nguyen Ba Tam**
GitHub: [@NguyenBaTam-tristan](https://github.com/NguyenBaTam-tristan)
