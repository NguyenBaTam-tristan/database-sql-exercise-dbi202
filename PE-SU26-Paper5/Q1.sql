create table Patients (
	patientID int primary key,
	firstName nvarchar(50),
	surName nvarchar(50),
)

create table Patientsemail (
	email nvarchar(20),
	patientID int,
	primary key (email, patientID),
	foreign key (patientID) references Patients(patientID)
)

create table Departments (
	departmentID int primary key,
	name nvarchar(100),
)

create table Doctors (
	SSN nvarchar(20) primary key,
	FullName nvarchar(100),
	Specialty nvarchar(60),
	departmentID int,
	foreign key (departmentID) references Departments(departmentID)
)

create table Appointments (
	appointmentTime datetime,
	status nvarchar(50),
	patientID int,
	SSN nvarchar(20),
	primary key (appointmentTime, patientID, SSN),
	foreign key (patientID) references Patients(patientID),
	foreign key (SSN) references Doctors(SSN)
)



