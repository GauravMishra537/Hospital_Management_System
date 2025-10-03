# Hospital_Management_System
🏥 Hospital Management System (Java + MySQL)

A Hospital Management System (HMS) built with Java Swing (GUI) and MySQL database.
This project helps manage patients, employees, rooms, ambulances, billing, and discharge records in a hospital.

🚀 Features

User Login System

Roles: Admin, Reception, Doctor, Nurse, Pharmacist, Accountant

Patient Management

Add new patients with disease, room type, deposit, etc.

View all patients (Admitted / Discharged status shown).

Discharge patient (frees room automatically + saves history).

Room Management

Add 100+ rooms with types: General, Private, ICU.

Track availability & pricing.

Employee Management

Doctors for 25+ specialties (Cardiology, Neurology, Oncology, etc.)

Nurses, Pharmacists, Receptionists, and Accountants.

Ambulance Management

View ambulances, drivers, and status.

Book / Free ambulances (with rates and availability).

Billing System

Calculates patient bills based on stay duration, room rate, and deposit.

Records payments and discharge history.

🛠 Tech Stack

Java (Swing) → Frontend GUI

MySQL → Backend Database

JDBC → Database connection

Eclipse/IntelliJ → IDE

📂 Database Schema

users → Login accounts

department → 25+ medical departments

emp_info → Employees (Doctors, Nurses, Staff)

room → Hospital rooms (General, Private, ICU)

patient_info → Patients (admit & discharge records)

discharge_info → History of discharged patients

ambulance → Ambulances with availability

medicine & prescription → Basic pharmacy module

payments → Billing records

🎯 Future Enhancements

Online appointment booking system

SMS/Email notifications

Reports & analytics dashboard

Insurance claims integration

⚡ How to Run

Clone this repository

Import the project into Eclipse/IntelliJ

Import the SQL file into MySQL (hospital_management_system database)

Update your DB credentials in conn.java

Run Login.java → Start the system
