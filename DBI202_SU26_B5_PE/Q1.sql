create table Bank (
	bankCode varchar(25) primary key,
	name nvarchar(200)
);

create table Branch (
	branchNo varchar(20),
	andress text,
	bankCode varchar(25),
	primary key (branchNo, bankCode),
	foreign key (bankCode) references Bank(bankCode)
);

create table Customers (
	custID int primary key,
	Name nvarchar(100)
);

create table Account (
	accNo varchar(20) primary key,
	balance money,
	openTime Datetime,
	branchNo varchar(20),
	bankCode varchar(25),
	foreign key (branchNo, bankCode) references Branch(branchNo, bankCode)
);

create table Owns (
	custID int,
	accNo varchar(20),
	role nvarchar(50),
	
	primary key (custID, accNo, role),
	foreign key (custID) references Customers(custID),
	foreign key (accNo) references Account(accNo)
);



