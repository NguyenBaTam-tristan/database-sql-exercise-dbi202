create database Bai_7;
go
use Bai_7;
go

create table ChiNhanh (
	TenCN nvarchar(50) primary key,
	DiaDiem nvarchar(255) not null
);

create table KhachHang (
	MaKH varchar(20) primary key,
	Hoten nvarchar(50) not null,
	SoDT varchar(20),
	DiaChi nvarchar(255),
	TenCN nvarchar(50),

	foreign key (TenCN) references ChiNhanh(TenCN)
);

create table TramDien (
	TenTramDien nvarchar(50),
	TenCN nvarchar(50),

	primary key (TenTramDien, TenCN),
	foreign key (TenCN) references ChiNhanh(TenCN)
);

create table DienKe (
	SoDienKe varchar(50) primary key,
	Chiso float not null,
	MaKH varchar(20),
	TenTramDien nvarchar(50),
	TenCN nvarchar(50),

	foreign key (MaKH) references KhachHang(MaKH),
	foreign key (TenTramDien, TenCN) references TramDien(TenTramDien, TenCN)
);

create table BanGhiDien (
	Sobanghi varchar(50),
	Thangnam date,
	TenNV nvarchar(50),
	Chisotrongthang decimal(10, 2),
	SoDienKe varchar(50),

	primary key (Sobanghi, SoDienKe),
	foreign key (SoDienKe) references DienKe(SoDienKe)
);


