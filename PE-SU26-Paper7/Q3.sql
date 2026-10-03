select b.BookingID,
	g.FirstName + ' ' + g.LastName as 'GuestName',
	g.Nationality,
	b.CheckInDate,
	bs.BookingServiceID,
	s.ServiceName,
	s.Category
from Booking b
join Guest g on b.GuestID = g.GuestID
join BookingService bs on b.BookingID = bs.BookingID
join Service s on bs.ServiceID = s.ServiceID
where year(b.CheckInDate) = 2025
and s.Category = 'Food & Beverage'
