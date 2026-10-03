create procedure SP_9
	@City nvarchar
as begin
 UPDATE NHANVIEN
 SET LUONG = LUONG * 1.10
 WHERE DCHI like '%' + @City + '%';
end;
go

