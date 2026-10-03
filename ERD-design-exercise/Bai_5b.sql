create database Bai_5b;
go
use Bai_5b;
go

create table TuyenBay (
	MaTB varchar(50) primary key,
	DonGiaVe float not null,
	SoGioBay float,
	TPkhoihanh nvarchar(50) not null,
	TPden nvarchar(50) not null
);

create table DonViBay (
	MaDonViBay varchar(50) primary key,
	TenDonVi nvarchar(50) not null
);

create table ChuyenBay (
	MaChuyenBay varchar(50) primary key,
	LoaiMayBay nvarchar(50),
	MaTB varchar(50),
	foreign key (MaTB) references TuyenBay(MaTB)
);

create table PhiCong (
	MaPhiCong varchar(50) primary key,
	HoTen nvarchar(50) not null,
	Phai nvarchar(20) not null,
	NgaySinh date not null,
	MaDonViBay varchar(50),
	foreign key (MaDonViBay) references DonViBay(MaDonViBay)
);

create table DieuKhien (
	MaPhiCong varchar(50),
	MaChuyenBay varchar(50),
	primary key (MaPhiCong, MaChuyenBay),
	foreign key (MaPhiCong) references PhiCong(MaPhiCong),
	foreign key (MaChuyenBay) references ChuyenBay(MaChuyenBay)
);

create table HanhKhach (
	MaHK varchar(20) primary key,
	NgaySinh date,
	Phai nvarchar(20),
	HoTen nvarchar(50) not null
);

create table VeMayBay (
	MaVeMayBay varchar(20) primary key,
	MaChuyenBay varchar(50),
	MaHK varchar(20),

	foreign key (MaChuyenBay) references ChuyenBay(MaChuyenbay),
	foreign key (MaHK) references HanhKhach(MaHK)
);


