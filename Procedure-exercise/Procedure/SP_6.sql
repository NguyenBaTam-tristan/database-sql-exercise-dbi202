create procedure SP_6
as
begin
	select pb.MAPHG,
		pb.TENPHG,
		count(nv.MANV) as SO_NV
	from PHONGBAN pb
	left join NHANVIEN nv on pb.MAPHG = nv.PHG
	group by pb.MAPHG, pb.TENPHG;
end;
go



