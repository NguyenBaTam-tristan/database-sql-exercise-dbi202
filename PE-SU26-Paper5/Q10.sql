UPDATE Booking 
SET TotalAmount = ISNULL((SELECT SUM(SubTotal) FROM BookingDetail bd WHERE bd.BookingID = Booking.BookingID), 0)
                + ISNULL((SELECT SUM(TotalCost) FROM BookingService bs WHERE bs.BookingID = Booking.BookingID), 0)
WHERE BookingID BETWEEN 1 AND 10;