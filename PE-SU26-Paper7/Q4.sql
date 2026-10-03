SELECT 
    rt.RoomTypeID,
    rt.TypeName,
    rt.Description,
    r.RoomNumber,
    r.Floor,
    j.DetailID,
    j.BookingGuestID,
    j.FirstName,
    j.LastName,
    j.Nationality
FROM RoomType rt
LEFT JOIN Room r 
    ON rt.RoomTypeID = r.RoomTypeID
LEFT JOIN (
    SELECT 
        bd.DetailID,
        bd.RoomID,
        bg.BookingGuestID,
        g.FirstName,
        g.LastName,
        g.Nationality
    FROM BookingDetail bd
    JOIN BookingGuest bg 
        ON bd.DetailID = bg.DetailID
    JOIN Guest g 
        ON bg.GuestID = g.GuestID 
        AND g.Nationality = 'Japanese'
) j 
    ON r.RoomID = j.RoomID
WHERE rt.TypeName IN ('Standard', 'Suite')
ORDER BY 
    rt.TypeName DESC, 
    j.DetailID DESC, 
    j.BookingGuestID ASC;