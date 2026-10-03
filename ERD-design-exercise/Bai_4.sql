create database Bai_4 
go
use Bai_4;
go

create table Khoa (
	MaKhoa nvarchar(50) primary key,
	Ten nvarchar(50)
);

create table HocKi (
	MaHocKi nvarchar(50) primary key,
	Nam int,
	Dot int
);

create table MonHoc (
	MaMH int primary key,
	Ten nvarchar(50),
	HeSoDKT varchar(20),
	HeSoDT varchar(20),
	SoTinChi int
);

create table NhomMonHocMo (
	NhomTo nvarchar(50),
	MaMH int,
	MaHocKi nvarchar(50),

	primary key (NhomTo, MaMH, MaHocKi),
	foreign key (MaMH) references MonHoc(MaMH),
	foreign key (MaHocKi) references HocKi(MaHocKi)
);

create table SinhVien (
	MaSV int primary key,
	Ten nvarchar(50),
	DiaChi nvarchar(200),
	MaKhoa nvarchar(50),
	foreign key (MaKhoa) references Khoa(MaKhoa)
);

create table CoDiem (
	MaSV int,
	NhomTo nvarchar(50),
	MaHocKi nvarchar(50),
	MaMH int,
	DiemThi float,
	DiemKT float,
	
	primary key (MaSV, NhomTo, MaMH, MaHocKi),
	foreign key (MaSV) references SinhVien(MaSV),
	foreign key (NhomTo, MaMH, MaHocKi) references NhomMonHocMo(NhomTo,MaMH, MaHocKi)
);



	


