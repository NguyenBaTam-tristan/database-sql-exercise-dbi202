create procedure SP_2
	@StartDate date,
	@EndDate date
as
begin
	select 
		nv.MANV,
		concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as HOTEN_NV,
		pb.NG_NHANCHUC,
		nv.MA_NQL,
		concat(nql.HONV, ' ', nql.TENLOT, ' ', nql.TENNV) as HOTEN_NQL
	from NHANVIEN nv
	left join NHANVIEN nql on nv.MA_NQL = nql.MANV
	left join PHONGBAN pb on nv.PHG = pb.MAPHG
	where pb.NG_NHANCHUC between @StartDate and @EndDate;
end;
go

EXEC SP_2 @StartDate = '1980-01-01', @EndDate = '1987-12-31';


