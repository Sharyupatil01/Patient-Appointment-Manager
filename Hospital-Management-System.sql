-- Main entities:
-- Patient (patient_id, name, age, gender, contact, address)
-- Doctor (doctor_id, name, specialization, contact, fees)
-- Department (dept_id, dept_name)
-- Appointment (appt_id, patient_id, doctor_id, appt_date, status, room_no)
-- Treatment / Prescription (treat_id, appt_id, medicine, dosage, remarks)
-- Billing (bill_id, patient_id, appt_id, amount, payment_status, date)

-- Relationships:
-- One doctor belongs to one department.
-- One patient can have many appointments.
-- One appointment generates many treatments/prescriptions.
-- One appointment → one bill.
create database HospitalDb;
use HospitalDb;

-- department table-- 
create table Department(
   dept_id int auto_increment primary key ,
   dept_name varchar(100) not null 
);

-- Doctor table-- 
create table Doctor(
    doctor_id int auto_increment primary key ,
    doctor_name varchar(100) not null ,
    specialization varchar(100),
    contact_no varchar(15),
    fees decimal(10,2),
    dept_id int,
    foreign key (dept_id) references Department (dept_id)
    
    
);

-- Patient table --
create table Patient(
    patient_id int auto_increment primary key ,
    patient_name varchar(150) not null,
    age int,
    gender enum('Male','Female','Other'),
    contact varchar(15),
    address text 
);

-- Appointment table -- 
create table Appointment(
   app_id int auto_increment primary key ,
   patient_id int,
   doctor_id int,
   app_date datetime,
   room_no varchar(10),
   status enum('Scheduled','Completed','Cancelled') default 'Scheduled',
   foreign key (patient_id) references Patient(patient_id),
   foreign key (doctor_id) references Doctor(doctor_id)
   
);

-- Treatment table --
create table Treatment(
      treat_id int auto_increment primary key,
      app_id int,
      medicine varchar(100) ,
      dosage varchar(50) ,
      remarks text,
      foreign key (app_id) references Appointment(app_id)
      
);

-- Billing table -- 
create table Billing (
	  bill_id int auto_increment primary key,
      patient_id int ,
	  app_id int,
      amount decimal(10,2),
      payment_status enum ('Pending','Paid') default 'Pending',
      date datetime default current_timestamp,
      foreign key (patient_id) references Patient(patient_id),
      foreign key (app_id) references Appointment(app_id)
);

-- dml (data manipulation ) -- 
-- Inserting the data -- 
-- Departments

INSERT INTO Department (dept_name) 
VALUES ('Cardiology'), ('Neurology'), ('Orthopedics'), ('Pediatrics'), ('Dermatology'), ('General Surgery');

-- Doctors
INSERT INTO Doctor (doctor_name, specialization, contact_no, fees, dept_id)
VALUES ('Dr. Sharma','Cardiologist','9876543210',500,1),
       ('Dr. Mehta','Neurologist','9876501234',700,2),
       ('Dr. Kapoor','Orthopedic','9876123456',600,3),
       ('Dr. Verma','Pediatrician','9876112233',400,4),
       ('Dr. Jain','Dermatologist','9876778899',450,5),
       ('Dr. Sinha','Surgeon','9876998877',800,6);

-- Patients
INSERT INTO Patient (patient_name, age, gender, contact, address)
VALUES ('Amit Kumar', 32, 'Male','9123456780','Delhi'),
       ('Priya Singh', 45, 'Female','9988776655','Mumbai'),
       ('Neha Gupta', 28, 'Female','9876541122','Pune'),
       ('Rohit Yadav', 38, 'Male','9876432211','Chennai'),
       ('Sonal Patil', 50, 'Female','9876512345','Bangalore'),
       ('Manish Joshi', 60, 'Male','9876456789','Kolkata'),
       ('Sharyu Patil' ,21,'Female','7447377577' , 'Mumbai');

-- Appointments
INSERT INTO Appointment (patient_id, doctor_id, app_date, room_no)
VALUES (1,1,'2025-09-06 10:00:00','101'),
       (2,2,'2025-09-07 12:00:00','202'),
       (3,3,'2025-09-08 11:30:00','303'),
       (4,4,'2025-09-09 14:00:00','404'),
       (5,5,'2025-09-10 09:00:00','505'),
       (6,6,'2025-09-11 13:00:00','606'),
       (7,1,'2025-09-06 16:39:00','201');
       

-- Treatments
INSERT INTO Treatment (app_id, medicine, dosage, remarks)
VALUES (1,'Aspirin','1 tablet/day','For heart checkup'),
       (2,'Paracetamol','2 tablets/day','Headache relief'),
       (3,'Calcium','1 tablet/day','Bone strengthening'),
       (4,'Vitamin D','1 capsule/day','For child health'),
       (5,'Antibiotic Cream','Apply twice a day','Skin rash treatment'),
       (6,'Painkiller','2 tablets/day','Post-surgery pain management');

-- Billing
INSERT INTO Billing (app_id, patient_id, amount, payment_status)
VALUES (1,1,500,'Paid'),
       (2,2,700,'Pending'),
       (3,3,600,'Paid'),
       (4,4,400,'Paid'),
       (5,5,450,'Pending'),
       (6,6,800,'Paid');
       
       
--  List all patients with their assigned doctor’s name --
select p.patient_name as Patient , d.doctor_name as Doctor , d.specialization
from Patient p 
join Appointment  a on p.patient_id=a.patient_id 
join Doctor d on a.doctor_id=d.doctor_id;


-- List all the appointment Scheduled within next 7 days 

select a.app_id as Appointment , p.patient_name as Patient , d.doctor_name as Doctor , a.app_date 
from Appointment  a 
join Patient  p on a.patient_id=p.patient_id
join Doctor  d on a.doctor_id=d.doctor_id 
where a.app_date between now() and date_add(now(), interval 7 day);

-- Find doctors who have more than 1 appointment -- 

select d.doctor_name as Doctor ,count(a.app_id) as total_Appointments 
from Doctor d
join Appointment a on a.doctor_id = d.doctor_id 
group by d.doctor_id 
having count(a.app_id) > 1;

-- Find patients who have pending bills --
select p.patient_name as Patient , b.amount as Billing , b.payment_status
from Billing as b 
join Patient as p  on p.patient_id=b.patient_id 
where b.payment_status='Pending';

-- Show total billing amount collected for each department -- 
select de.dept_name as Department , sum(b.amount) as TotalBilling 
from Billing as b 
join Appointment as a on a.app_id=b.app_id 
join Doctor as d on d.doctor_id = a.doctor_id 
join Department as de on de.dept_id=d.dept_id 
where b.payment_status='Paid'
group by de.dept_name;

-- generating patient bill report -- 

SELECT p.patient_name, b.amount, b.payment_status
FROM Billing b
JOIN Patient p ON b.patient_id = p.patient_id
WHERE p.patient_id = 1;

-- Get all upcoming appointments for a doctor

select d.doctor_name as Doctor , count(*) as Visits
from Appointment as a 
join Doctor as d on d.doctor_id=a.doctor_id 
where a.doctor_id = 1 and a.app_date >= NOW();

-- Find most visited doctor --
SELECT d.doctor_name, COUNT(*) AS visits
FROM Appointment a
JOIN Doctor d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY visits DESC
LIMIT 1;


-- auto generating the bill when appointment is completed -- 
DELIMITER $$
CREATE TRIGGER after_appt_completed
AFTER UPDATE ON Appointment
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' THEN
        INSERT INTO Billing (app_id, patient_id, amount, payment_status)
        VALUES (NEW.app_id, NEW.patient_id,
            (SELECT fees FROM Doctor WHERE doctor_id = NEW.doctor_id),
            'Pending');
    END IF;
END$$
DELIMITER ;

select * from Billing;
