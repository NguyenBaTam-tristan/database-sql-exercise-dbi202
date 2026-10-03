select rt.RoomTypeID,
	rt.TypeName,
	rt.Description,
	r.RoomNumber,
	r.Floor,
	j.DetailID,
	j.BookingGuestID,
	j.FirstName,
	j.LastName,
	j.Nationality
from RoomType rt
left join Room r on rt.RoomTypeID = r.RoomTypeID
left join ( select bd.DetailID,
				bd.RoomID,
				bg.BookingGuestID,
				g.FirstName,
				g.LastName,
				g.Nationality
	from BookingDetail bd
	join BookingGuest bg on bd.DetailID = bg.DetailID
	join Guest g on bg.GuestID = g.GuestID
	where g.Nationality = 'Japanese') j
on r.RoomID = j.RoomID
where rt.TypeName in ('Suite', 'Standard')
order by rt.TypeName desc, j.DetailID desc, j.BookingGuestID asc
