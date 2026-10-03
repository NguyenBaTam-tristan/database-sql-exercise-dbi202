create procedure SP_10
AS
BEGIN
	delete from DIADIEM_PHG
	where MAPHG not in (select distinct PHG from NHANVIEN where PHG is not null);
	delete from PHONGBAN
	where MAPHG not in (select distinct PHG from NHANVIEN where PHG is not null);
end;
go
