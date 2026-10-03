create database Bai_3;
go
use Bai_3;
go

create table MonHoc (
	MaMH varchar(20) primary key,
	SoTinChi int not null,
	TenMH nvarchar(50) not null
);

create table TienQuyet (
	MaMH varchar(20),
	MaMTQ varchar(20),

	primary key (MaMH, MaMTQ),
	foreign key (MaMH) references MonHoc(MaMH),
	foreign key (MaMTQ) references MonHoc(MaMH)
);

create table KhoaHoc (
	MaMH varchar(20),
	MaKH int,
	NamHoc int not null,
	HocKy int not null,

	primary key (MaMH, MaKH),
	foreign key (MaMH) references MonHoc(MaMH)
);

	


