create database Bai_1;
go
use Bai_1;
go

create table Nhanvien (
	MaNV VARCHAR(20) PRIMARY KEY,
	TenNV NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100),
	NgaySinh Date,
);
GO

create table DuAn (
	MaDA VARCHAR(20) PRIMARY KEY,
	TenDA NVARCHAR(50) NOT NULL,
	NgayBD Date,
);
GO

create table ThamGia (
	MaNV VARCHAR(20),
	MaDA VARCHAR(20),
	Luong DECIMAL(18, 2),
	
	Primary key (MaNV, MaDA),

	foreign key (MaNV) references Nhanvien(MaNV),
	foreign key (MaDA) references DuAn(MaDA)
);
GO
	

