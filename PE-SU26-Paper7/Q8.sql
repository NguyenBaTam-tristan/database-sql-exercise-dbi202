CREATE PROCEDURE addService @bookingID INT, @serviceID INT, @quantity INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Booking WHERE BookingID = @bookingID)
       OR NOT EXISTS (SELECT 1 FROM Service WHERE ServiceID = @serviceID)
       OR @quantity <= 0
    BEGIN
        PRINT 'Input values are not valid.'
        RETURN 1
    END

    INSERT INTO BookingService(BookingID, ServiceID, Quantity, TotalCost)
    SELECT @bookingID, @serviceID, @quantity, @quantity * UnitPrice 
    FROM Service WHERE ServiceID = @serviceID

    RETURN 0
END
