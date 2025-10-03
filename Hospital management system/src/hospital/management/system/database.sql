CREATE DATABASE hospital_management_system;
USE hospital_management_system;

-- 1) login / users
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin','reception','doctor','nurse','pharmacist','account') DEFAULT 'reception',
  full_name VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2) department
CREATE TABLE department (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  description VARCHAR(255)
) ENGINE=InnoDB;

-- 3) employees
CREATE TABLE emp_info (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  age INT,
  gender ENUM('Male','Female','Other'),
  phone VARCHAR(20),
  email VARCHAR(150),
  dept_id INT,
  position VARCHAR(100),
  salary DECIMAL(12,2),
  joined_date DATE,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 4) rooms
CREATE TABLE room (
  room_no VARCHAR(20) PRIMARY KEY,
  type VARCHAR(50),
  price DECIMAL(10,2),
  availability ENUM('Available','Occupied') DEFAULT 'Available',
  details VARCHAR(255)
) ENGINE=InnoDB;

-- 5) patient info
CREATE TABLE patient_info (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(30) UNIQUE,
  name VARCHAR(150) NOT NULL,
  age INT,
  gender ENUM('Male','Female','Other'),
  address VARCHAR(255),
  phone VARCHAR(30),
  disease VARCHAR(255),
  admit_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  room_no VARCHAR(20),
  deposit DECIMAL(10,2) DEFAULT 0.00,
  price DECIMAL(12,2) DEFAULT 0.00,
  discharge_date DATETIME,
  time_in_ward VARCHAR(100),
  FOREIGN KEY (room_no) REFERENCES room(room_no) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 6) discharge records
CREATE TABLE discharge_info (
  discharge_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT,
  discharge_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(12,2),
  paid_amount DECIMAL(12,2),
  note TEXT,
  FOREIGN KEY (patient_id) REFERENCES patient_info(patient_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7) ambulance
CREATE TABLE ambulance (
  amb_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150),
  driver_name VARCHAR(150),
  driver_phone VARCHAR(30),
  vehicle_no VARCHAR(50),
  availability ENUM('Available','Busy') DEFAULT 'Available',
  details VARCHAR(255)
) ENGINE=InnoDB;

-- 8) medicines + prescriptions
CREATE TABLE medicine (
  med_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150),
  manufacturer VARCHAR(150),
  price DECIMAL(10,2),
  stock INT DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE prescription (
  presc_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT,
  prescribed_by INT,
  med_id INT,
  dosage VARCHAR(100),
  instructions TEXT,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patient_info(patient_id) ON DELETE CASCADE,
  FOREIGN KEY (prescribed_by) REFERENCES emp_info(emp_id) ON DELETE SET NULL,
  FOREIGN KEY (med_id) REFERENCES medicine(med_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 9) payments
CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT,
  amount DECIMAL(12,2),
  method ENUM('Cash','Card','UPI','Insurance') DEFAULT 'Cash',
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  note VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patient_info(patient_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Default admin user
INSERT INTO users (username,password,role,full_name) VALUES ('admin','adminpass','admin','Administrator');

-- 25 Departments
INSERT INTO department (name, phone, description) VALUES
('Cardiology', '0111000001', 'Heart diseases'),
('Neurology', '0111000002', 'Brain & Nervous system'),
('Oncology', '0111000003', 'Cancer treatment'),
('Dermatology', '0111000004', 'Skin diseases'),
('ENT', '0111000005', 'Ear, Nose, Throat'),
('Endocrinology', '0111000006', 'Hormonal disorders'),
('Nephrology', '0111000007', 'Kidney diseases'),
('Gastroenterology', '0111000008', 'Digestive system'),
('Pulmonology', '0111000009', 'Lung diseases'),
('Rheumatology', '0111000010', 'Joint and autoimmune'),
('Orthopedics', '0111000011', 'Bones and joints'),
('Pediatrics', '0111000012', 'Children healthcare'),
('Ophthalmology', '0111000013', 'Eye diseases'),
('Psychiatry', '0111000014', 'Mental health'),
('Urology', '0111000015', 'Urinary system'),
('Gynecology', '0111000016', 'Women health'),
('Hepatology', '0111000017', 'Liver diseases'),
('Allergy & Immunology', '0111000018', 'Allergies'),
('General Surgery', '0111000019', 'Surgical care'),
('Hematology', '0111000020', 'Blood disorders'),
('Infectious Diseases', '0111000021', 'Infections'),
('Immunology', '0111000022', 'Immune system'),
('Plastic Surgery', '0111000023', 'Reconstructive surgery'),
('Geriatrics', '0111000024', 'Elderly care'),
('Internal Medicine', '0111000025', 'General medicine'),
('Pharmacy', '0111000026', 'Medicine distribution');

-- Rooms sample
INSERT INTO room (room_no,type,price,availability) VALUES ('R-101','General',500.00,'Available');

-- Doctors (25 specialties)
INSERT INTO emp_info (name, age, gender, phone, email, dept_id, position, salary, joined_date) VALUES
('Dr. Arjun Mehta', 45, 'Male', '9876500001', 'arjun.cardiology@hospital.com', 1, 'Cardiologist', 150000, '2020-03-01'),
('Dr. Kavita Sharma', 50, 'Female', '9876500002', 'kavita.neuro@hospital.com', 2, 'Neurologist', 140000, '2019-06-15'),
('Dr. Ramesh Iyer', 42, 'Male', '9876500003', 'ramesh.oncology@hospital.com', 3, 'Oncologist', 155000, '2021-02-20'),
('Dr. Sunita Rao', 39, 'Female', '9876500004', 'sunita.derma@hospital.com', 4, 'Dermatologist', 120000, '2018-10-11'),
('Dr. Manoj Gupta', 55, 'Male', '9876500005', 'manoj.ent@hospital.com', 5, 'ENT Specialist', 130000, '2017-05-25'),
('Dr. Neha Kapoor', 41, 'Female', '9876500006', 'neha.endocrine@hospital.com', 6, 'Endocrinologist', 135000, '2021-08-12'),
('Dr. Rajesh Patil', 47, 'Male', '9876500007', 'rajesh.nephro@hospital.com', 7, 'Nephrologist', 145000, '2016-09-30'),
('Dr. Shalini Verma', 44, 'Female', '9876500008', 'shalini.gastro@hospital.com', 8, 'Gastroenterologist', 140000, '2019-12-01'),
('Dr. Vinod Bansal', 50, 'Male', '9876500009', 'vinod.pulmo@hospital.com', 9, 'Pulmonologist', 138000, '2018-01-20'),
('Dr. Meera Joshi', 38, 'Female', '9876500010', 'meera.rheuma@hospital.com', 10, 'Rheumatologist', 125000, '2020-11-15'),
('Dr. Deepak Khanna', 52, 'Male', '9876500011', 'deepak.ortho@hospital.com', 11, 'Orthopedic Surgeon', 160000, '2015-07-10'),
('Dr. Anita Mishra', 46, 'Female', '9876500012', 'anita.pedia@hospital.com', 12, 'Pediatrician', 130000, '2020-04-19'),
('Dr. Prakash Yadav', 40, 'Male', '9876500013', 'prakash.ophthal@hospital.com', 13, 'Ophthalmologist', 125000, '2019-08-09'),
('Dr. Lata Menon', 49, 'Female', '9876500014', 'lata.psychiatry@hospital.com', 14, 'Psychiatrist', 128000, '2017-11-17'),
('Dr. Ajay Kulkarni', 43, 'Male', '9876500015', 'ajay.urology@hospital.com', 15, 'Urologist', 137000, '2021-01-25'),
('Dr. Sneha Chatterjee', 35, 'Female', '9876500016', 'sneha.obgyn@hospital.com', 16, 'Gynecologist', 140000, '2020-09-02'),
('Dr. Nikhil Rathi', 48, 'Male', '9876500017', 'nikhil.hepato@hospital.com', 17, 'Hepatologist', 138000, '2018-02-12'),
('Dr. Pooja Singh', 37, 'Female', '9876500018', 'pooja.allergy@hospital.com', 18, 'Allergist', 115000, '2019-05-27'),
('Dr. Arvind Malhotra', 55, 'Male', '9876500019', 'arvind.surgeon@hospital.com', 19, 'General Surgeon', 165000, '2015-03-14'),
('Dr. Geeta Saxena', 42, 'Female', '9876500020', 'geeta.hema@hospital.com', 20, 'Hematologist', 142000, '2021-06-23'),
('Dr. Harish Shetty', 50, 'Male', '9876500021', 'harish.infect@hospital.com', 21, 'Infectious Disease Specialist', 135000, '2018-12-19'),
('Dr. Radha Pillai', 39, 'Female', '9876500022', 'radha.immuno@hospital.com', 22, 'Immunologist', 120000, '2020-07-01'),
('Dr. Vikram Desai', 51, 'Male', '9876500023', 'vikram.plastic@hospital.com', 23, 'Plastic Surgeon', 170000, '2017-09-05'),
('Dr. Priya Nair', 36, 'Female', '9876500024', 'priya.geriatric@hospital.com', 24, 'Geriatrician', 118000, '2021-03-11'),
('Dr. Suresh Jain', 47, 'Male', '9876500025', 'suresh.internal@hospital.com', 25, 'Internal Medicine', 140000, '2016-04-29');

-- Other Staff
INSERT INTO emp_info (name, age, gender, phone, email, dept_id, position, salary, joined_date) VALUES
('Nurse Anjali', 30, 'Female', '9876510001', 'anjali.nurse@hospital.com', 12, 'Nurse', 45000, '2021-09-10'),
('Nurse Rohit', 28, 'Male', '9876510002', 'rohit.nurse@hospital.com', 11, 'Nurse', 42000, '2020-05-21'),
('Pharmacist Ritu', 33, 'Female', '9876510003', 'ritu.pharma@hospital.com', 26, 'Pharmacist', 55000, '2019-12-12'),
('Receptionist Kavya', 25, 'Female', '9876510004', 'kavya.reception@hospital.com', NULL, 'Receptionist', 30000, '2022-01-01'),
('Accountant Sandeep', 40, 'Male', '9876510005', 'sandeep.account@hospital.com', NULL, 'Accountant', 60000, '2018-08-08');
-- Insert 100 rooms into the room table
INSERT INTO room (room_no, type, price, availability, details) VALUES

('R-102', 'General', 500, 'Available', 'General ward bed'),
('R-103', 'General', 500, 'Available', 'General ward bed'),
('R-104', 'General', 500, 'Available', 'General ward bed'),
('R-105', 'General', 500, 'Available', 'General ward bed'),
('R-106', 'General', 500, 'Available', 'General ward bed'),
('R-107', 'General', 500, 'Available', 'General ward bed'),
('R-108', 'General', 500, 'Available', 'General ward bed'),
('R-109', 'General', 500, 'Available', 'General ward bed'),
('R-110', 'General', 500, 'Available', 'General ward bed'),

('R-111', 'Private', 1000, 'Available', 'Private single room'),
('R-112', 'Private', 1000, 'Available', 'Private single room'),
('R-113', 'Private', 1000, 'Available', 'Private single room'),
('R-114', 'Private', 1000, 'Available', 'Private single room'),
('R-115', 'Private', 1000, 'Available', 'Private single room'),
('R-116', 'Private', 1000, 'Available', 'Private single room'),
('R-117', 'Private', 1000, 'Available', 'Private single room'),
('R-118', 'Private', 1000, 'Available', 'Private single room'),
('R-119', 'Private', 1000, 'Available', 'Private single room'),
('R-120', 'Private', 1000, 'Available', 'Private single room'),

('R-121', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-122', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-123', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-124', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-125', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-126', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-127', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-128', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-129', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-130', 'ICU', 2000, 'Available', 'Intensive Care Unit'),

-- Continue pattern up to R-200
('R-131', 'General', 500, 'Available', 'General ward bed'),
('R-132', 'General', 500, 'Available', 'General ward bed'),
('R-133', 'General', 500, 'Available', 'General ward bed'),
('R-134', 'General', 500, 'Available', 'General ward bed'),
('R-135', 'General', 500, 'Available', 'General ward bed'),
('R-136', 'General', 500, 'Available', 'General ward bed'),
('R-137', 'General', 500, 'Available', 'General ward bed'),
('R-138', 'General', 500, 'Available', 'General ward bed'),
('R-139', 'General', 500, 'Available', 'General ward bed'),
('R-140', 'General', 500, 'Available', 'General ward bed'),

('R-141', 'Private', 1000, 'Available', 'Private single room'),
('R-142', 'Private', 1000, 'Available', 'Private single room'),
('R-143', 'Private', 1000, 'Available', 'Private single room'),
('R-144', 'Private', 1000, 'Available', 'Private single room'),
('R-145', 'Private', 1000, 'Available', 'Private single room'),
('R-146', 'Private', 1000, 'Available', 'Private single room'),
('R-147', 'Private', 1000, 'Available', 'Private single room'),
('R-148', 'Private', 1000, 'Available', 'Private single room'),
('R-149', 'Private', 1000, 'Available', 'Private single room'),
('R-150', 'Private', 1000, 'Available', 'Private single room'),

('R-151', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-152', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-153', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-154', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-155', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-156', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-157', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-158', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-159', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-160', 'ICU', 2000, 'Available', 'Intensive Care Unit'),

('R-161', 'General', 500, 'Available', 'General ward bed'),
('R-162', 'General', 500, 'Available', 'General ward bed'),
('R-163', 'General', 500, 'Available', 'General ward bed'),
('R-164', 'General', 500, 'Available', 'General ward bed'),
('R-165', 'General', 500, 'Available', 'General ward bed'),
('R-166', 'General', 500, 'Available', 'General ward bed'),
('R-167', 'General', 500, 'Available', 'General ward bed'),
('R-168', 'General', 500, 'Available', 'General ward bed'),
('R-169', 'General', 500, 'Available', 'General ward bed'),
('R-170', 'General', 500, 'Available', 'General ward bed'),

('R-171', 'Private', 1000, 'Available', 'Private single room'),
('R-172', 'Private', 1000, 'Available', 'Private single room'),
('R-173', 'Private', 1000, 'Available', 'Private single room'),
('R-174', 'Private', 1000, 'Available', 'Private single room'),
('R-175', 'Private', 1000, 'Available', 'Private single room'),
('R-176', 'Private', 1000, 'Available', 'Private single room'),
('R-177', 'Private', 1000, 'Available', 'Private single room'),
('R-178', 'Private', 1000, 'Available', 'Private single room'),
('R-179', 'Private', 1000, 'Available', 'Private single room'),
('R-180', 'Private', 1000, 'Available', 'Private single room'),

('R-181', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-182', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-183', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-184', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-185', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-186', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-187', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-188', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-189', 'ICU', 2000, 'Available', 'Intensive Care Unit'),
('R-190', 'ICU', 2000, 'Available', 'Intensive Care Unit'),

('R-191', 'General', 500, 'Available', 'General ward bed'),
('R-192', 'General', 500, 'Available', 'General ward bed'),
('R-193', 'General', 500, 'Available', 'General ward bed'),
('R-194', 'General', 500, 'Available', 'General ward bed'),
('R-195', 'General', 500, 'Available', 'General ward bed'),
('R-196', 'General', 500, 'Available', 'General ward bed'),
('R-197', 'General', 500, 'Available', 'General ward bed'),
('R-198', 'General', 500, 'Available', 'General ward bed'),
('R-199', 'General', 500, 'Available', 'General ward bed'),
('R-200', 'General', 500, 'Available', 'General ward bed');

ALTER TABLE ambulance ADD COLUMN rate DECIMAL(10,2) DEFAULT 0;
INSERT INTO ambulance (name, driver_name, driver_phone, vehicle_no, availability, details, rate) VALUES
('Basic Ambulance', 'Rakesh Kumar', '9876111001', 'DL-01-AB-1234', 'Available', 'Basic ambulance with stretcher', 500),
('ICU Ambulance', 'Suresh Yadav', '9876111002', 'DL-01-IC-5678', 'Available', 'ICU ambulance with ventilator & oxygen', 2000),
('Cardiac Ambulance', 'Mahesh Singh', '9876111003', 'DL-02-CA-9999', 'Busy', 'Advanced life support (cardiac monitor)', 3000);



