create procedure SP_7
as
begin
	select nv.MANV,
		concat(nv.HONV, ' ',nv.TENLOT, ' ', nv.TENNV),
		nv.LUONG
		from NHANVIEN nv
		where nv.LUONG > (select AVG(LUONG) FROM NHANVIEN);
end;
go


	