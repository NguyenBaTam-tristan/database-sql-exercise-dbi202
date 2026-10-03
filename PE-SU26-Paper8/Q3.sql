select b.BookingID, 
	g.FirstName + ' ' + g.LastName as 'GuestName',
	g.Nationality,
	b.BookingDate,
	bd.DetailID,
	r.RoomNumber
from Booking b
join Guest g on b.GuestID = g.GuestID
join BookingDetail bd on b.BookingID = bd.BookingID
join Room r on bd.RoomID = r.RoomID
where g.Nationality in ('Chinese', 'Japanese')
and YEAR(b.BookingDate) = 2024
order by b.BookingID asc, bd.DetailID asc