create database Bai1_SU26_Paper8;
go
use Bai1_SU26_Paper8;
go

create table Members (
	memberID int primary key,
	firstName nvarchar(50),
	lastName nvarchar(50)
);

create table MembersPhone (
	memberID int,
	phone nvarchar(20),
	primary key (memberID, phone),
	foreign key (memberID) references Members(memberID)
);

create table Librarian (
	librarianID int primary key,
	name nvarchar(100)
);

create table Books (
	bookCode nvarchar(20) primary key,
	title nvarchar(100),
	author nvarchar(60)
);

create table Loans (
	borrowDate date,
	returnDate date,
	memberID int,
	librarianID int,
	bookCode nvarchar(20),

	primary key (borrowDate, memberID, bookCode),
	foreign key (memberID) references Members(memberID),
	foreign key (librarianID) references Librarian(librarianID),
	foreign key (bookCode) references Books(bookCode)
);


