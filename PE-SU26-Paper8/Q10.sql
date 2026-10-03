update Booking
set TotalAmount = isnull((select sum(SubTotal) from BookingDetail where BookingDetail.BookingID = Booking.BookingID), 0)
				+ isnull((select sum(TotalCost) from BookingService where BookingService.BookingID = Booking.BookingID), 0)
where BookingID between 10 and 20

