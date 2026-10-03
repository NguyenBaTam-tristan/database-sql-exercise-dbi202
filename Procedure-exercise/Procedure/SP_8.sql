create procedure SP_8
	@N int
as 
begin
	select top(@N) * from NHANVIEN
	order by LUONG desc;
end;
go

