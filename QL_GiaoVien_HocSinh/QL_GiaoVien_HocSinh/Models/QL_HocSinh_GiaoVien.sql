USE [master]
GO
IF EXISTS
(
	SELECT * 
	FROM   master..sysdatabases 
	WHERE  name = N'QL_HocSinh_GiaoVien'
)
DROP DATABASE QL_HocSinh_GiaoVien
GO
CREATE DATABASE [QL_HocSinh_GiaoVien]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_HocSinh_GiaoVien', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QL_HocSinh_GiaoVien.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QL_HocSinh_GiaoVien_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QL_HocSinh_GiaoVien_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
USE [QL_HocSinh_GiaoVien]

GO
CREATE TABLE [dbo].[Bomon](
	[Ma] [nvarchar](20) PRIMARY KEY  NOT NULL,
	[Ten] [nvarchar](50),
	[Diadiem] [nvarchar](200),
 )
 GO
CREATE TABLE [dbo].[Monhoc](
	[Ma] [nvarchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Sotiet] [int],
	[Gioithieu] [text],
	[Hinhthucthi] [nvarchar](20)
)
GO
CREATE TABLE [dbo].[Giaovien](
	[Ma] [nvarchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Gioitinh] [bit],
	[Ngaysinh] [date],
	[Email] [nvarchar](50),
	[Sodienthoai] [nvarchar](30),
	[Luong] [int],
	[Nhiemvu] [nvarchar](30),
	[Bomonma] [nvarchar](20),
	FOREIGN KEY([Bomonma]) REFERENCES [dbo].[Bomon] ([Ma])
 )
GO
CREATE TABLE [dbo].[Lophocphan](
	[Ma] [nvarchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Hocki] [nchar](20),
	[NgayBD] [date],
	[NgayKT] [date],
	[Ngaythi] [date],
	[Siso] [int],
	[Thu] [nvarchar](20),
	[Tiet] [nvarchar](20),
	[Namhoc] [nvarchar](50),
	[Monma] [nvarchar](20),
	[Giaovienma] [nvarchar](20),
	FOREIGN KEY([Giaovienma]) REFERENCES [dbo].[Giaovien] ([Ma]),
	FOREIGN KEY([Monma]) REFERENCES [dbo].[Monhoc] ([Ma])
 )
 GO
CREATE TABLE [dbo].[Hocsinh](
	[Ma] [nvarchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Lopma] [nvarchar](20),
	[Ngaysinh] [date],
	[Gioitinh] [bit],
	[Dantoc] [nvarchar](30),
	[Diachi] [nvarchar](50),
	[Email] [nvarchar](30),
	[Sodienthoai] [nvarchar](30),
	FOREIGN KEY([Lopma]) REFERENCES [dbo].[Lophocphan] ([Ma])
 )
GO
CREATE TABLE [dbo].[Diem](
	[Diem1] [float],
	[Diem2] [float],
	[Diem3] [float],
	[Tongket] [float],
	[Lopma] [nvarchar](20),
	[Hocsinhma] [nvarchar](20),
	FOREIGN KEY([Hocsinhma]) REFERENCES [dbo].[Hocsinh] ([Ma]),
	FOREIGN KEY([Lopma]) REFERENCES [dbo].[Lophocphan] ([Ma])
)
GO
ALTER DATABASE QL_HocSinh_GiaoVien SET  READ_WRITE 
go
select* from hocsinh 
select* from Giaovien
select * from Bomon
select * from Monhoc
select * from Lophocphan
insert into Bomon values
('BMTOAN', N'Toán', N'Phòng 201 tầng 2 dãy A'),
('BMLY', N'Lý', N'Phòng 203 tầng 2 dãy A'),
('BMHOA', N'Toán', N'Phòng 202 tầng 2 dãy A')
insert into Monhoc values
('Toan10', N'Toán', 30, N'Môn toán dành cho học sinh lớp 10', N'Tự luận'),
('Toan11', N'Toán', 30, N'Môn toán dành cho học sinh lớp 11', N'Tự luận'),
('Hoa12', N'Hóa', 30, N'Môn hóa dành cho học sinh lớp 12', N'Tự luận')

insert into GiaoVien(ma, ten, Gioitinh, Ngaysinh, Nhiemvu, Sodienthoai, Email,Luong, Bomonma) values
 ('GV0001', N'Trần Văn Dũng', 1, '2000-05-01',N'Giáo Viên','0337108530','gmail.com', 5000000, 'BMTOAN'),
 ('GV0002', N'Bùi Xuân Hiệp', 1, '2000-04-05',N'Giáo Viên','0234567654','gmail.com', 5000000, 'BMTOAN'),
 ('GV0003', N'Trần Quốc Bảo', 1, '2000-04-05',N'Giáo Viên','2345634444','gmail.com', 6000000, 'BMLY'),
 ('GV0004', N'Ngụy Thị Gấm', 0, '2000-04-05',N'Giáo Viên','0234988854','gmail.com', 8000000, 'BMHOA'),
 ('GV0005', N'Đặng Quang Minh', 1, '2000-04-05',N'Giáo Viên','0987767654','gmail.com', 4000000, 'BMTOAN')

insert into Lophocphan(Ma, Ten, Hocki, NgayBD, NgayKT, Ngaythi, Siso, Thu, Tiet, Namhoc, Monma, Giaovienma) values
('Toan10Lop0001', N'Toán 10', 'Hoc Ky I', '2020-09-01', '2020-11-30', '2020-11-29', 30, N'Thứ 2', '2-3','2020-2021', 'Toan10', 'GV0001'),
('Toan11Lop0001', N'Toán 11', 'Hoc Ky I', '2020-09-01', '2020-11-30', '2020-11-29', 30, N'Thứ 3', '1-2','2020-2021', 'Toan11', 'GV0002'),
('Hoa12Lop0001', N'Hóa 12', 'Hoc Ky I', '2020-09-01', '2020-11-30', '2020-11-29', 30, N'Thứ 3', '3-4','2020-2021', 'Hoa12', 'GV0003')
 
insert into HocSinh(Ma, Ten, LopMa, NgaySinh, DanToc,GioiTinh, DiaChi,Email, SoDienThoai ) values
('HS0001', N'Đặng Quang Minh', 'Toan10Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0002', N'Ngụy Thị Gấm', 'Toan10Lop0001', '2000-05-01', 'Kinh', 0, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0003', N'Trần Văn Dũng', 'Toan11Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0004', N'Trần Quốc Bảo', 'Toan11Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0005', N'Trần Thị A', 'Hoa12Lop0001', '2000-05-01', 'Kinh', 0, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0006', N'Trần Văn B', 'Toan10Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0008', N'Trần Văn B', 'Toan10Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0007', N'Trần Thị C', 'Toan10Lop0001', '2000-05-01', 'Kinh', 0, N'Hà Nội', 'Dxtran2@gmail.com','0337108530'),
('HS0009', N'Trần Thị D', 'Hoa12Lop0001', '2000-05-01', 'Kinh', 0, N'Nam Định', 'Dxtran3@gmail.com','0337108530'),
('HS0010', N'Trần Văn E', 'Hoa12Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran5@gmail.com','0337108530'),
('HS0011', N'Trần Văn F', 'Toan10Lop0001', '2000-05-01', 'Kinh', 1, N'Nam Định', 'Dxtran7@gmail.com','0337108530')

select * from HocSinh
select * from hocsinh where ten like N'%ă%'
select * from LopHocPhan
select l.ma, l.Hocki, l.Namhoc, l.Siso,l.Tiet, l.Thu, l.NgayBD, l.NgayKT, l.Ngaythi, 
                 mh.ma as MonMa, mh.Ten as Ten, gv.ten as GiaoVienTen, gv.ma as GiaoVienMa 
                 from Lophocphan l inner join monhoc mh on l.monma = mh.ma 
                 inner join giaovien gv on gv.ma = l.Giaovienma
