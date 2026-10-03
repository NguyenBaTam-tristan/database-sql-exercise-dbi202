create procedure SP_5
as
begin
	select 
	concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV),
	nv.MANV,
	pc.THOIGIAN
	from NHANVIEN nv
	join PHANCONG pc on nv.MANV = pc.MA_NVIEN;
end;
go

exec SP_5;

