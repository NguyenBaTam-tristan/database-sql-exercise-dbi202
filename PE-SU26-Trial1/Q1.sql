create table Hotels (
	HotelNo int primary key,
	hotelName nvarchar(100),
	andress nvarchar(255)
);

create table Types (
	typeid int primary key,
	name nvarchar(50),
	bedNo int,
	guestNo int,
	size float
);

create table RoomPrice (
	HotelNo int,
	typeid int,
	price money,
	primary key (HotelNo, typeid, price),
	foreign key (HotelNo) references Hotels(HotelNo),
	foreign key (typeid) references Types(typeid)
);


