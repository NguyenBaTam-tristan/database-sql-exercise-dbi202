USE QuanLyDiemSV;
GO

/* ==========================================================================
   A. CẬP NHẬT THÔNG TIN & TRIGGER
   ========================================================================== */

-- Câu 2: Cập nhật số tiết môn học có mã 05 thành 45[cite: 1]
UPDATE DMMH
SET SoTiet = 45
WHERE MaMH = '05';
GO

-- Trigger 1 câu 2: Không cho phép số tiết vượt quá 100[cite: 1]
CREATE TRIGGER trg_CheckSoTiet_Max100
ON DMMH
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE SoTiet > 100)
    BEGIN
        RAISERROR (N'Số tiết không được vượt quá 100!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Trigger 2 câu 2: Không cho phép cập nhật số tiết vượt quá 150% so với trước khi sửa[cite: 1]
CREATE TRIGGER trg_CheckSoTiet_Max150Percent
ON DMMH
FOR UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i 
        JOIN deleted d ON i.MaMH = d.MaMH 
        WHERE i.SoTiet > d.SoTiet * 1.5
    )
    BEGIN
        RAISERROR (N'Số tiết không được vượt quá 150% số tiết cũ!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Câu 3, 4: Cập nhật sinh viên có mã B01 với TenSV là Kỳ, Phai là Nam[cite: 1]
UPDATE DMSV
SET TenSV = N'Kỳ', Phai = N'Nam'
WHERE MaSV = 'B01';
GO

-- Câu 5: Thay đổi ngày sinh sinh viên có mã B02 thành '05/07/1990'[cite: 1]
SET DATEFORMAT DMY;
UPDATE DMSV
SET NgaySinh = '05/07/1990'
WHERE MaSV = 'B02';
GO

-- Trigger câu 5: Ngày sinh <= ngày hiện tại[cite: 1]
CREATE TRIGGER trg_CheckNgaySinh
ON DMSV
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE NgaySinh > GETDATE())
    BEGIN
        RAISERROR (N'Ngày sinh phải nhỏ hơn hoặc bằng ngày hiện tại!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Câu 6: Tăng học bổng sinh viên có MaKhoa 'AV' thêm 100000[cite: 1]
UPDATE DMSV
SET HocBong = HocBong + 100000
WHERE MaKhoa = 'AV';
GO

-- Câu 7: Xóa danh sách kết quả có lần thi = 2 và điểm < 5[cite: 1]
DELETE FROM KetQua
WHERE LanThi = 2 AND Diem < 5;
GO

-- Trigger câu 8: Xóa sinh viên thì tự động xóa các bảng liên quan (bảng nhiều - KetQua) trước[cite: 1]
CREATE TRIGGER trg_DeleteSinhVien
ON DMSV
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM KetQua 
    WHERE MaSV IN (SELECT MaSV FROM deleted);

    DELETE FROM DMSV 
    WHERE MaSV IN (SELECT MaSV FROM deleted);
END;
GO

-- Câu 8: Xóa danh sách sinh viên không có học bổng (HocBong = 0 hoặc NULL)[cite: 1]
DELETE FROM DMSV
WHERE HocBong = 0 OR HocBong IS NULL;
GO


/* ==========================================================================
   B. TRUY VẤN ĐƠN GIẢN
   ========================================================================== */

-- Câu 9: Liệt kê MaSV, HoSV, TenSV, HocBong. Sắp xếp MaSV tăng dần[cite: 1].
SELECT MaSV, HoSV, TenSV, HocBong
FROM DMSV
ORDER BY MaSV ASC;

-- Câu 10: Liệt kê MaSV, Họ tên, Phai, NgaySinh. Sắp xếp theo Phái[cite: 1].
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai, NgaySinh
FROM DMSV
ORDER BY Phai;

-- Câu 11: Họ tên, NgaySinh, HocBong. Sắp xếp NgaySinh tăng dần, HocBong giảm dần[cite: 1].
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, HocBong
FROM DMSV
ORDER BY NgaySinh ASC, HocBong DESC;

-- Câu 12: Môn học có tên bắt đầu bằng chữ 'T': MaMH, TenMH, SoTiet[cite: 1].
SELECT MaMH, TenMH, SoTiet
FROM DMMH
WHERE TenMH LIKE N'T%';

-- Câu 13: Sinh viên có chữ cái cuối cùng trong tên là 'I': Họ tên, NgaySinh, Phai[cite: 1].
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, Phai
FROM DMSV
WHERE TenSV LIKE N'%i';

-- Câu 14: Khoa có ký tự thứ hai của tên khoa là 'N': MaKhoa, TenKhoa[cite: 1].
SELECT MaKhoa, TenKhoa
FROM DMKhoa
WHERE TenKhoa LIKE N'_n%';

-- Câu 15: Sinh viên mà họ có chứa chữ 'Thị'[cite: 1].
SELECT *
FROM DMSV
WHERE HoSV LIKE N'%Thị%';

-- Câu 16: Ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm': MaSV, Họ tên, Phai, HocBong[cite: 1].
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai, HocBong
FROM DMSV
WHERE TenSV LIKE N'[a-m]%';

-- Câu 17: Tên có chứa ký tự nằm trong khoảng từ 'a' đến 'm': Họ tên, NgaySinh, NoiSinh, HocBong. Sắp xếp tăng dần theo họ tên[cite: 1].
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, NoiSinh, HocBong
FROM DMSV
WHERE TenSV LIKE N'%[a-m]%'
ORDER BY HoTen ASC;

-- Câu 18: Học bổng > 100,000: MaSV, Họ tên, MaKhoa, HocBong. Sắp xếp MaKhoa giảm dần[cite: 1].
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, MaKhoa, HocBong
FROM DMSV
WHERE HocBong > 100000
ORDER BY MaKhoa DESC;

-- Câu 19: Học bổng >= 150,000 và sinh ở Hà Nội: Họ tên, MaKhoa, NoiSinh, HocBong[cite: 1].
SELECT HoSV + ' ' + TenSV AS HoTen, MaKhoa, NoiSinh, HocBong
FROM DMSV
WHERE HocBong >= 150000 AND NoiSinh = N'Hà Nội';

-- Câu 20: Sinh viên khoa Anh văn và Vật lý: MaSV, MaKhoa, Phai[cite: 1].
SELECT MaSV, MaKhoa, Phai
FROM DMSV
WHERE MaKhoa IN ('AV', 'VL');

-- Câu 21: Sinh viên có ngày sinh từ 01/01/1991 đến 05/06/1992: MaSV, NgaySinh, NoiSinh, HocBong[cite: 1].
SELECT MaSV, NgaySinh, NoiSinh, HocBong
FROM DMSV
WHERE NgaySinh BETWEEN '1991-01-01' AND '1992-06-05';

-- Câu 22: Sinh viên có học bổng từ 80,000 đến 150,000: MaSV, NgaySinh, Phai, MaKhoa[cite: 1].
SELECT MaSV, NgaySinh, Phai, MaKhoa
FROM DMSV
WHERE HocBong BETWEEN 80000 AND 150000;

-- Câu 23: Môn học có số tiết > 30 và < 45: MaMH, TenMH, SoTiet[cite: 1].
SELECT MaMH, TenMH, SoTiet
FROM DMMH
WHERE SoTiet > 30 AND SoTiet < 45;

-- Câu 24: Sinh viên nam khoa Anh văn và Tin học: MaSV, Họ tên, TenKhoa, Phai[cite: 1].
SELECT sv.MaSV, sv.HoSV + ' ' + sv.TenSV AS HoTen, kh.TenKhoa, sv.Phai
FROM DMSV sv
JOIN DMKhoa kh ON sv.MaKhoa = kh.MaKhoa
WHERE sv.Phai = N'Nam' AND sv.MaKhoa IN ('AV', 'TH');

-- Câu 25: Sinh viên nữ có tên chứa chữ 'N'[cite: 1].
SELECT *
FROM DMSV
WHERE Phai = N'Nữ' AND TenSV LIKE N'%n%';


/* ==========================================================================
   C. TRUY VẤN SỬ DỤNG HÀM (YEAR, MONTH, DAY, GETDATE, CASE,...)
   ========================================================================== */

-- Câu 26: Nơi sinh ở Hà Nội và sinh vào tháng 02: Họ, Tên, Nơi sinh, Ngày sinh[cite: 1].
SELECT HoSV, TenSV, NoiSinh, NgaySinh
FROM DMSV
WHERE NoiSinh = N'Hà Nội' AND MONTH(NgaySinh) = 2;

-- Câu 27: Tuổi lớn hơn 20: Họ tên, Tuổi, Học bổng[cite: 1].
SELECT HoSV + ' ' + TenSV AS HoTen, DATEDIFF(YEAR, NgaySinh, GETDATE()) AS Tuoi, HocBong
FROM DMSV
WHERE DATEDIFF(YEAR, NgaySinh, GETDATE()) > 20;

-- Câu 28: Tuổi từ 20 đến 25: Họ tên, Tuổi, Tên khoa[cite: 1].
SELECT sv.HoSV + ' ' + sv.TenSV AS HoTen, DATEDIFF(YEAR, sv.NgaySinh, GETDATE()) AS Tuoi, kh.TenKhoa
FROM DMSV sv
JOIN DMKhoa kh ON sv.MaKhoa = kh.MaKhoa
WHERE DATEDIFF(YEAR, sv.NgaySinh, GETDATE()) BETWEEN 20 AND 25;

-- Câu 29: Sinh vào mùa xuân năm 1990 (Tháng 1, 2, 3): Họ tên, Phái, Ngày sinh[cite: 1].
SELECT HoSV + ' ' + TenSV AS HoTen, Phai, NgaySinh
FROM DMSV
WHERE YEAR(NgaySinh) = 1990 AND MONTH(NgaySinh) IN (1, 2, 3);

-- Câu 30: Phân loại học bổng (> 500,000 là "Học bổng cao", ngược lại là "Mức trung bình")[cite: 1]
SELECT 
    MaSV, 
    Phai, 
    MaKhoa, 
    CASE 
        WHEN HocBong > 500000 THEN N'Học bổng cao' 
        ELSE N'Mức trung bình' 
    END AS MucHocBong
FROM DMSV;


/* ==========================================================================
   D. TRUY VẤN SỬ DỤNG HÀM TỔNG HỢP & GOM NHÓM (GROUP BY)
   ========================================================================== */

-- Câu 32: Tổng số sinh viên của toàn trường[cite: 1]
SELECT COUNT(MaSV) AS TongSoSinhVien
FROM DMSV;

-- Câu 33: Tổng sinh viên và tổng sinh viên nữ[cite: 1]
SELECT 
    COUNT(MaSV) AS TongSoSinhVien,
    SUM(CASE WHEN Phai = N'Nữ' THEN 1 ELSE 0 END) AS TongSinhVienNu
FROM DMSV;

-- Câu 34: Tổng số sinh viên của từng khoa[cite: 1]
SELECT kh.MaKhoa, kh.TenKhoa, COUNT(sv.MaSV) AS TongSoSV
FROM DMKhoa kh
LEFT JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
GROUP BY kh.MaKhoa, kh.TenKhoa;

-- Câu 35: Số lượng sinh viên học từng môn[cite: 1]
SELECT mh.MaMH, mh.TenMH, COUNT(DISTINCT kq.MaSV) AS SoLuongSV
FROM DMMH mh
LEFT JOIN KetQua kq ON mh.MaMH = kq.MaMH
GROUP BY mh.MaMH, mh.TenMH;

-- Câu 36: Số lượng môn học mà sinh viên đã học[cite: 1]
SELECT COUNT(DISTINCT MaMH) AS TongSoMonDaHoc
FROM KetQua;

-- Câu 37: Tổng số tiền học bổng của mỗi khoa[cite: 1]
SELECT kh.MaKhoa, kh.TenKhoa, SUM(ISNULL(sv.HocBong, 0)) AS TongHocBong
FROM DMKhoa kh
LEFT JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
GROUP BY kh.MaKhoa, kh.TenKhoa;

-- Câu 38: Học bổng cao nhất của mỗi khoa[cite: 1]
SELECT kh.MaKhoa, kh.TenKhoa, MAX(ISNULL(sv.HocBong, 0)) AS HocBongCaoNhat
FROM DMKhoa kh
LEFT JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
GROUP BY kh.MaKhoa, kh.TenKhoa;

-- Câu 39: Tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa[cite: 1]
SELECT 
    kh.MaKhoa, 
    kh.TenKhoa,
    SUM(CASE WHEN sv.Phai = N'Nam' THEN 1 ELSE 0 END) AS SoSVNam,
    SUM(CASE WHEN sv.Phai = N'Nữ' THEN 1 ELSE 0 END) AS SoSVNu
FROM DMKhoa kh
LEFT JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
GROUP BY kh.MaKhoa, kh.TenKhoa;
GO