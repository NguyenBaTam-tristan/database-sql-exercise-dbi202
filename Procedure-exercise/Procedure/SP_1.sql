create procedure SP_1
	@LuongMin float
as
begin
 select * from NHANVIEN
 where LUONG > @LuongMin;
end;
go

exec SP_1 30000;