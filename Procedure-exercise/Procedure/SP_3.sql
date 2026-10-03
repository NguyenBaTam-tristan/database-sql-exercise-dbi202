create procedure SP_3
	@MaPhongBan int
as
begin
	select * from NHANVIEN
	where PHG = @MaPhongBan;
end;
go

