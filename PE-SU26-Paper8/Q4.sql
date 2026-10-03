select g.GuestID,
	g.FirstName,
	g.LastName,
	b.BookingID,
	b.BookingDate,
	s.ServiceName,
	s.Category,
	bs.ServiceDate
from Guest g
left join Booking b on g.GuestID = b.GuestID
left join BookingService bs on b.BookingID = bs.BookingID
left join Service s on bs.ServiceID = s.ServiceID
where g.Nationality = 'Japanese'
order by s.ServiceName asc, b.BookingDate desc
			