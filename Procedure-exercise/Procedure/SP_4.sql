create procedure SP_4
as
begin
	select * from NHANVIEN
	where MA_NQL is null;
end;
go

exec SP_4;
