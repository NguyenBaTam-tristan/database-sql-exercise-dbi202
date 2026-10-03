create database Bai_6;
go
use Bai_6;
go

create table Bacsi (
	MaBs varchar(20) primary key,
	TenBs nvarchar(50) not null,
	Chuyenmon nvarchar(50) 
);

create table Benhnhan (
	MaBn varchar(20) primary key,
	TenBn nvarchar(50) not null,
	MaBs varchar(20),

	foreign key (MaBs) references Bacsi(MaBs)
);

create table DieuTri (
	MaBs varchar(20),
	MaBn varchar(20),
	Ngay date,
	Tgian time,
	Ketqua nvarchar(255),

	primary key (MaBs, MaBn, Ngay, Tgian),
	foreign key (MaBs) references Bacsi(MaBs),
	foreign key (MaBn) references Benhnhan(MaBn)
);





