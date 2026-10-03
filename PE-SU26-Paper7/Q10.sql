update Booking 
set TotalAmount = isnull((select sum(SubTotal) from BookingDetail bd where bd.BookingID = Booking.BookingID),0)
				+ isnull((select sum(TotalCost) from BookingService bs where bs.BookingID = Booking.BookingID),0)
where BookingID between 1 and 10

