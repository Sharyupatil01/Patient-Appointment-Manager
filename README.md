# Hospital Management System (MySQL)

## 📋 Project Overview

This is a **Hospital Management System** implemented entirely using **MySQL**. The database manages patient information, doctor details, appointments, treatments, and billing processes in a healthcare setting. The project demonstrates real-world use cases through efficient data handling using SQL features like joins, aggregation, triggers, and stored procedures.

The focus is on designing and implementing a robust database structure that supports essential hospital operations while providing actionable insights through queries and reports.

---

## 🗂️ Features

✔ Store and manage patient records  
✔ Manage doctor profiles with specialization, fees, and departments  
✔ Schedule and track appointments between patients and doctors  
✔ Record treatments, prescriptions, and medical remarks  
✔ Handle billing information, including payments and outstanding balances  
✔ Analyze data using queries for appointments, revenue reports, and patient history

---

## 📦 Database Structure

### ✅ Tables

- **Department** – Contains information about hospital departments.  
- **Doctor** – Stores details about doctors, their specializations, and associated departments.  
- **Patient** – Contains patient personal details including contact and address.  
- **Appointment** – Tracks appointments between patients and doctors with scheduling information.  
- **Treatment** – Records medicines, dosages, and remarks related to specific appointments.  
- **Billing** – Tracks billing details such as amount and payment status.

### ✅ Relationships

- A **doctor** belongs to a **department**.  
- A **patient** can have multiple **appointments**.  
- An **appointment** can have multiple **treatments**.  
- **Billing** is linked to a particular appointment and patient.

---
### ⚒️ Reverse Engineering 

<img width="1364" height="868" alt="Screenshot 2025-09-06 143754" src="https://github.com/user-attachments/assets/3e004278-b6b5-4d53-b0a2-c17cdd2b2ece" />


## ✅ Sample Queries

### List of All Patients
```bash sql
SELECT * FROM Patient;

** Folder Structure ** 

hospital-management-system/
├── hospital-management-system.sql            # Contains table definitions and sample data inserts
├── query-results/        # Folder with CSV files and screenshots of executed queries
├── README.md             # This file, explaining the project setup and features

