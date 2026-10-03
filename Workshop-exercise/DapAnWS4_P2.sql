USE QuanLyDiemSV;
GO

/* ==========================================================================
   D. TRUY VẤN SỬ DỤNG HÀM TỔNG HỢP & GOM NHÓM (TIẾP THEO)
   ========================================================================== */

-- Câu 40: Cho biết số lượng sinh viên theo từng độ tuổi
SELECT 
    DATEDIFF(YEAR, NgaySinh, GETDATE()) AS Tuoi, 
    COUNT(MaSV) AS SoLuongSV
FROM DMSV
GROUP BY DATEDIFF(YEAR, NgaySinh, GETDATE());

-- Câu 41: Cho biết những năm sinh nào có 2 sinh viên đang theo học tại trường
SELECT 
    YEAR(NgaySinh) AS NamSinh, 
    COUNT(MaSV) AS SoLuongSV
FROM DMSV
GROUP BY YEAR(NgaySinh)
HAVING COUNT(MaSV) = 2;

-- Câu 42: Cho biết những nơi nào có hơn 2 sinh viên đang theo học tại trường
SELECT 
    NoiSinh, 
    COUNT(MaSV) AS SoLuongSV
FROM DMSV
GROUP BY NoiSinh
HAVING COUNT(MaSV) > 2;

-- Câu 43: Cho biết những môn nào có trên 3 sinh viên dự thi
SELECT 
    mh.MaMH, 
    mh.TenMH, 
    COUNT(DISTINCT kq.MaSV) AS SoLuongSVDuThi
FROM DMMH mh
JOIN KetQua kq ON mh.MaMH = kq.MaMH
GROUP BY mh.MaMH, mh.TenMH
HAVING COUNT(DISTINCT kq.MaSV) > 3;

-- Câu 44: Cho biết những sinh viên thi lại trên 2 lần (LanThi > 2 hoặc số lần thi > 2)
SELECT 
    sv.MaSV, 
    sv.HoSV + ' ' + sv.TenSV AS HoTen, 
    kq.MaMH, 
    COUNT(kq.LanThi) AS SoLanThi
FROM DMSV sv
JOIN KetQua kq ON sv.MaSV = kq.MaSV
GROUP BY sv.MaSV, sv.HoSV, sv.TenSV, kq.MaMH
HAVING COUNT(kq.LanThi) > 2;

-- Câu 45: Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0
SELECT 
    sv.MaSV, 
    sv.HoSV + ' ' + sv.TenSV AS HoTen, 
    AVG(kq.Diem) AS DTB_Lan1
FROM DMSV sv
JOIN KetQua kq ON sv.MaSV = kq.MaSV
WHERE sv.Phai = N'Nam' AND kq.LanThi = 1
GROUP BY sv.MaSV, sv.HoSV, sv.TenSV
HAVING AVG(kq.Diem) > 7.0;

-- Câu 46: Cho biết danh sách các sinh viên rớt trên 2 môn ở lần thi 1 (Điểm < 5)
SELECT 
    sv.MaSV, 
    sv.HoSV + ' ' + sv.TenSV AS HoTen, 
    COUNT(kq.MaMH) AS SoMonRot
FROM DMSV sv
JOIN KetQua kq ON sv.MaSV = kq.MaSV
WHERE kq.LanThi = 1 AND kq.Diem < 5
GROUP BY sv.MaSV, sv.HoSV, sv.TenSV
HAVING COUNT(kq.MaMH) > 2;

-- Câu 47: Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
SELECT 
    kh.MaKhoa, 
    kh.TenKhoa, 
    COUNT(sv.MaSV) AS SoSVNam
FROM DMKhoa kh
JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
WHERE sv.Phai = N'Nam'
GROUP BY kh.MaKhoa, kh.TenKhoa
HAVING COUNT(sv.MaSV) > 2;

-- Câu 48: Cho biết những khoa có 2 sinh viên đạt học bổng từ 200.000 đến 300.000
SELECT 
    kh.MaKhoa, 
    kh.TenKhoa, 
    COUNT(sv.MaSV) AS SoSV
FROM DMKhoa kh
JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
WHERE sv.HocBong BETWEEN 200000 AND 300000
GROUP BY kh.MaKhoa, kh.TenKhoa
HAVING COUNT(sv.MaSV) = 2;

-- Câu 49: Cho biết số lượng sinh viên đậu và số lượng sinh viên rớt của từng môn trong lần thi 1
SELECT 
    mh.MaMH, 
    mh.TenMH,
    SUM(CASE WHEN kq.Diem >= 5 THEN 1 ELSE 0 END) AS SoSVDau,
    SUM(CASE WHEN kq.Diem < 5 THEN 1 ELSE 0 END) AS SoSVRot
FROM DMMH mh
JOIN KetQua kq ON mh.MaMH = kq.MaMH
WHERE kq.LanThi = 1
GROUP BY mh.MaMH, mh.TenMH;

-- Câu 50: Cho biết số lượng sinh viên nam và số lượng sinh viên nữ của từng khoa (Trùng câu 39)
SELECT 
    kh.MaKhoa, 
    kh.TenKhoa,
    SUM(CASE WHEN sv.Phai = N'Nam' THEN 1 ELSE 0 END) AS SoSVNam,
    SUM(CASE WHEN sv.Phai = N'Nữ' THEN 1 ELSE 0 END) AS SoSVNu
FROM DMKhoa kh
LEFT JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
GROUP BY kh.MaKhoa, kh.TenKhoa;


/* ==========================================================================
   F. TRUY VẤN CON TRẢ VỀ MỘT GIÁ TRỊ (SCALAR SUBQUERY)
   ========================================================================== */

-- Câu 51: Cho biết sinh viên nào có học bổng cao nhất
SELECT *
FROM DMSV
WHERE HocBong = (SELECT MAX(HocBong) FROM DMSV);

-- Câu 52: Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
SELECT sv.*, kq.Diem
FROM DMSV sv
JOIN KetQua kq ON sv.MaSV = kq.MaSV
JOIN DMMH mh ON kq.MaMH = mh.MaMH
WHERE kq.LanThi = 1 
  AND mh.TenMH = N'Cơ Sở Dữ Liệu'
  AND kq.Diem = (
      SELECT MAX(kq2.Diem) 
      FROM KetQua kq2 
      JOIN DMMH mh2 ON kq2.MaMH = mh2.MaMH 
      WHERE mh2.TenMH = N'Cơ Sở Dữ Liệu' AND kq2.LanThi = 1
  );

-- Câu 53: Cho biết sinh viên khoa Anh văn có tuổi lớn nhất (Ngày sinh nhỏ nhất)
SELECT TOP 1 WITH TIES *
FROM DMSV
WHERE MaKhoa = 'AV'
ORDER BY NgaySinh ASC;

-- Câu 54: Cho biết khoa nào có đông sinh viên nhất
-- Cách 1: Sử dụng ALL
SELECT kh.MaKhoa, kh.TenKhoa, COUNT(sv.MaSV) AS SoLuongSV
FROM DMKhoa kh
JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
GROUP BY kh.MaKhoa, kh.TenKhoa
HAVING COUNT(sv.MaSV) >= ALL (
    SELECT COUNT(MaSV) 
    FROM DMSV 
    GROUP BY MaKhoa
);

-- Câu 55: Cho biết khoa nào có đông sinh viên nữ nhất
SELECT kh.MaKhoa, kh.TenKhoa, COUNT(sv.MaSV) AS SoLuongSVNu
FROM DMKhoa kh
JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
WHERE sv.Phai = N'Nữ'
GROUP BY kh.MaKhoa, kh.TenKhoa
HAVING COUNT(sv.MaSV) >= ALL (
    SELECT COUNT(MaSV) 
    FROM DMSV 
    WHERE Phai = N'Nữ' 
    GROUP BY MaKhoa
);

-- Câu 56: Cho biết môn nào có nhiều sinh viên rớt lần 1 nhất
SELECT mh.MaMH, mh.TenMH, COUNT(kq.MaSV) AS SoSVRot
FROM DMMH mh
JOIN KetQua kq ON mh.MaMH = kq.MaMH
WHERE kq.LanThi = 1 AND kq.Diem < 5
GROUP BY mh.MaMH, mh.TenMH
HAVING COUNT(kq.MaSV) >= ALL (
    SELECT COUNT(MaSV) 
    FROM KetQua 
    WHERE LanThi = 1 AND Diem < 5 
    GROUP BY MaMH
);

-- Câu 57: Cho biết sinh viên không học khoa Anh văn có điểm thi môn Văn phạm lớn hơn điểm thi môn Văn phạm của sinh viên học khoa Anh văn
SELECT DISTINCT sv.MaSV, sv.HoSV + ' ' + sv.TenSV AS HoTen, kq.Diem
FROM DMSV sv
JOIN KetQua kq ON sv.MaSV = kq.MaSV
JOIN DMMH mh ON kq.MaMH = mh.MaMH
WHERE sv.MaKhoa <> 'AV' 
  AND mh.TenMH = N'Văn Phạm'
  AND kq.Diem > ANY (
      SELECT kq2.Diem 
      FROM KetQua kq2 
      JOIN DMSV sv2 ON kq2.MaSV = sv2.MaSV 
      JOIN DMMH mh2 ON kq2.MaMH = mh2.MaMH 
      WHERE sv2.MaKhoa = 'AV' AND mh2.TenMH = N'Văn Phạm'
  );


/* ==========================================================================
   G. TRUY VẤN CON TRẢ VỀ NHIỀU GIÁ TRỊ (ALL, ANY, UNION, TOP,...)
   ========================================================================== */

-- Câu 58: Cho biết sinh viên có nơi sinh cùng với Hải
SELECT *
FROM DMSV
WHERE NoiSinh IN (
    SELECT NoiSinh 
    FROM DMSV 
    WHERE TenSV = N'Hải'
) AND TenSV <> N'Hải';

-- Câu 59: Cho biết những sinh viên có học bổng lớn hơn tất cả học bổng của sinh viên thuộc khoa Anh văn
SELECT *
FROM DMSV
WHERE HocBong > ALL (
    SELECT ISNULL(HocBong, 0) 
    FROM DMSV 
    WHERE MaKhoa = 'AV'
);

-- Câu 60: Cho biết những sinh viên có học bổng lớn hơn bất kỳ học bổng của sinh viên học khoa Anh văn
SELECT *
FROM DMSV
WHERE HocBong > ANY (
    SELECT ISNULL(HocBong, 0) 
    FROM DMSV 
    WHERE MaKhoa = 'AV'
);

-- Câu 61: Cho biết sinh viên có điểm thi môn Cơ sở dữ liệu lần 2 lớn hơn tất cả điểm thi lần 1 môn Cơ sở dữ liệu của những sinh viên khác
SELECT sv.MaSV, sv.HoSV + ' ' + sv.TenSV AS HoTen, kq.Diem AS DiemLan2
FROM DMSV sv
JOIN KetQua kq ON sv.MaSV = kq.MaSV
JOIN DMMH mh ON kq.MaMH = mh.MaMH
WHERE mh.TenMH = N'Cơ Sở Dữ Liệu' 
  AND kq.LanThi = 2
  AND kq.Diem > ALL (
      SELECT Diem 
      FROM KetQua kq1 
      JOIN DMMH mh1 ON kq1.MaMH = mh1.MaMH 
      WHERE mh1.TenMH = N'Cơ Sở Dữ Liệu' 
        AND kq1.LanThi = 1 
        AND kq1.MaSV <> kq.MaSV
  );

-- Câu 62: Cho biết những sinh viên đạt điểm cao nhất trong từng môn
SELECT kq.MaMH, mh.TenMH, sv.MaSV, sv.HoSV + ' ' + sv.TenSV AS HoTen, kq.Diem
FROM KetQua kq
JOIN DMSV sv ON kq.MaSV = sv.MaSV
JOIN DMMH mh ON kq.MaMH = mh.MaMH
WHERE kq.Diem = (
    SELECT MAX(Diem) 
    FROM KetQua kq2 
    WHERE kq2.MaMH = kq.MaMH
);

-- Câu 63: Cho biết những khoa không có sinh viên học
SELECT *
FROM DMKhoa
WHERE MaKhoa NOT IN (SELECT DISTINCT MaKhoa FROM DMSV WHERE MaKhoa IS NOT NULL);

-- Câu 64: Cho biết sinh viên chưa thi môn Cơ sở dữ liệu
SELECT *
FROM DMSV
WHERE MaSV NOT IN (
    SELECT MaSV 
    FROM KetQua kq 
    JOIN DMMH mh ON kq.MaMH = mh.MaMH 
    WHERE mh.TenMH = N'Cơ Sở Dữ Liệu'
);

-- Câu 65: Cho biết sinh viên không thi lần 1 mà có dự thi lần 2
SELECT DISTINCT MaSV
FROM KetQua kq
WHERE LanThi = 2 
  AND NOT EXISTS (
      SELECT 1 
      FROM KetQua kq2 
      WHERE kq2.MaSV = kq.MaSV AND kq2.MaMH = kq.MaMH AND kq2.LanThi = 1
  );

-- Câu 66: Cho biết môn nào không có sinh viên khoa Anh văn học
SELECT *
FROM DMMH
WHERE MaMH NOT IN (
    SELECT DISTINCT kq.MaMH
    FROM KetQua kq
    JOIN DMSV sv ON kq.MaSV = sv.MaSV
    WHERE sv.MaKhoa = 'AV'
);

-- Câu 67: Cho biết những sinh viên khoa Anh văn chưa học môn Văn phạm
SELECT *
FROM DMSV sv
WHERE sv.MaKhoa = 'AV'
  AND sv.MaSV NOT IN (
      SELECT kq.MaSV
      FROM KetQua kq
      JOIN DMMH mh ON kq.MaMH = mh.MaMH
      WHERE mh.TenMH = N'Văn Phạm'
  );

-- Câu 68: Cho biết những sinh viên không rớt môn nào (Điểm các lần thi đều >= 5)
SELECT *
FROM DMSV
WHERE MaSV NOT IN (
    SELECT DISTINCT MaSV 
    FROM KetQua 
    WHERE Diem < 5
) AND MaSV IN (SELECT DISTINCT MaSV FROM KetQua);

-- Câu 69: Cho biết những sinh viên học khoa Anh văn có học bổng và những sinh viên chưa bao giờ rớt môn nào
SELECT MaSV, HoSV, TenSV, MaKhoa, HocBong
FROM DMSV
WHERE MaKhoa = 'AV' AND HocBong > 0
UNION
SELECT MaSV, HoSV, TenSV, MaKhoa, HocBong
FROM DMSV
WHERE MaSV NOT IN (SELECT DISTINCT MaSV FROM KetQua WHERE Diem < 5)
  AND MaSV IN (SELECT DISTINCT MaSV FROM KetQua);

-- Câu 70: Cho biết khoa có đông sinh viên nhận học bổng nhất và khoa có ít sinh viên nhận học bổng nhất
-- Khoa có đông sinh viên nhận học bổng nhất
SELECT TOP 1 kh.MaKhoa, kh.TenKhoa, COUNT(sv.MaSV) AS SoLuongSV_NhanHB, N'Đông nhất' AS Loai
FROM DMKhoa kh
JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
WHERE sv.HocBong > 0
GROUP BY kh.MaKhoa, kh.TenKhoa
ORDER BY COUNT(sv.MaSV) DESC
UNION ALL
-- Khoa có ít sinh viên nhận học bổng nhất
SELECT TOP 1 kh.MaKhoa, kh.TenKhoa, COUNT(sv.MaSV) AS SoLuongSV_NhanHB, N'Ít nhất' AS Loai
FROM DMKhoa kh
JOIN DMSV sv ON kh.MaKhoa = sv.MaKhoa
WHERE sv.HocBong > 0
GROUP BY kh.MaKhoa, kh.TenKhoa
ORDER BY COUNT(sv.MaSV) ASC;
GO