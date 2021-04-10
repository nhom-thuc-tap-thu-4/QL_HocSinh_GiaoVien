USE [master]
GO
--drop database QL_HocSinh_GiaoVien
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
	[Ma] [varchar](20) PRIMARY KEY  NOT NULL,
	[Ten] [varchar](50),
	[Diadiem] [varchar](200),
 )
 GO
CREATE TABLE [dbo].[Monhoc](
	[Ma] [varchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Sotiet] [int],
	[Gioithieu] [text],
	[Hinhthucthi] [nvarchar](20)
)
GO
CREATE TABLE [dbo].[Giaovien](
	[Ma] [varchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Gioitinh] [bit],
	[Ngaysinh] [date],
	[Email] [nvarchar](50),
	[Sodienthoai] [nvarchar](30),
	[Luong] [int],
	[Nhiemvu] [nvarchar](30),
	[Bomonma] [varchar](20),
	FOREIGN KEY([Bomonma]) REFERENCES [dbo].[Bomon] ([Ma])
 )
GO
CREATE TABLE [dbo].[Lophocphan](
	[Ma] [varchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Hocki] [char](5),
	[NgayBD] [date],
	[NgayKT] [date],
	[Ngaythi] [date],
	[Siso] [int],
	[Thu] [varchar](10),
	[Tiet] [int],
	[Namhoc] [varchar](5),
	[Monma] [varchar](20),
	[Giaovienma] [varchar](20),
	FOREIGN KEY([Giaovienma]) REFERENCES [dbo].[Giaovien] ([Ma]),
	FOREIGN KEY([Monma]) REFERENCES [dbo].[Monhoc] ([Ma])
 )
 GO
CREATE TABLE [dbo].[Hocsinh](
	[Ma] [varchar](20) PRIMARY KEY NOT NULL,
	[Ten] [nvarchar](50),
	[Lopma] [varchar](20),
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
	[Lopma] [varchar](20),
	[Hocsinhma] [varchar](20),
	FOREIGN KEY([Hocsinhma]) REFERENCES [dbo].[Hocsinh] ([Ma]),
	FOREIGN KEY([Lopma]) REFERENCES [dbo].[Lophocphan] ([Ma])
)
GO
select* from hocsinh 
go
select l.ma, l.Hocki, l.Namhoc, l.Siso,l.Tiet, l.Thu, mh.ma as monma, mh.ten as monten,
gv.ma as giaovienma, gv.ten as giaovienten from Lophocphan l inner  join monhoc mh on l.monma = mh.ma
inner join giaovien gv on gv.ma = l.Giaovienma
go
select l.ma, l.Hocki, l.Namhoc, l.Siso, l.Thu, l.NgayBD, l.NgayKT, l.Ngaythi,
mh.ma as N'Mã Môn', mh.Ten as N'Tên Môn', gv.ma as N'Mã Giáo Viên', gv.ten as N'Tên Giáo Viên' 
from Lophocphan l inner join monhoc mh on l.monma = mh.ma
 inner join giaovien gv on gv.ma = l.Giaovienma
 go
 select * from lophocphan
 select * from Monhoc
/*
insert into HocSinh(Ma, Ten, LopMa, NgaySinh, DanToc,GioiTinh, DiaChi,Email, SoDienThoai ) values
('HS0004', N'Trần Văn Dũng', 'Toan001', getdate(), 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0005', N'Trần Văn A', 'Toan001', getdate(), 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0006', N'Trần Văn B', 'Toan001', getdate(), 'Kinh', 1, N'Nam Định', 'Dxtran8@gmail.com','0337108530'),
('HS0007', N'Trần Văn C', 'Ly001', getdate(), 'Kinh', 1, N'Hà Nội', 'Dxtran2@gmail.com','0337108530'),
('HS0009', N'Trần Văn D', 'Ly001', getdate(), 'Kinh', 1, N'Nam Định', 'Dxtran3@gmail.com','0337108530'),
('HS0010', N'Trần Văn E', 'Hoa001', getdate(), 'Kinh', 1, N'Nam Định', 'Dxtran5@gmail.com','0337108530'),
('HS0011', N'Trần Văn F', 'Hoa001', getdate(), 'Kinh', 1, N'Nam Định', 'Dxtran7@gmail.com','0337108530')
*/
