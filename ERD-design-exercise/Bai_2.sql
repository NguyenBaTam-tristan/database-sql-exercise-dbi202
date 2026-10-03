create database Bai_2;
go
use Bai_2;
go

create table KhachHang (
	MaKH varchar(20) primary key,
	TenKH nvarchar(50),
	DiaChi nvarchar(100)
);

create table LoaiMH (
	MaloaiMH varchar(20) primary key,
	TenLoai nvarchar(50) not null
);

create table MH (
	MaMH varchar(20) primary key,
	MaloaiMH varchar(20),
	TinhTrang nvarchar(200),
	Mota nvarchar(200),
	Gia float not null,

	foreign key (MaloaiMH) references LoaiMH(MaloaiMH)
);

create table Mua (
	MaMH varchar(20) primary key,
	MaKH varchar(20) not null,
	TinhTrang nvarchar(200),
	GiaMua float not null,
	NgayMua date,

	foreign key (MaKH) references KhachHang(MaKH),
	foreign key (MaMH) references MH(MaMH)
);

create table Ban (
	MaMH varchar(20) primary key,
	MaKH varchar(20) not null,
	GiaBan float not null,
	TienHoaHong float not null,
	NgayBan date,
	Thue float not null,

	foreign key (MaKH) references KhachHang(MaKH),
	foreign key (MaMH) references MH(MaMH)
);
	


	