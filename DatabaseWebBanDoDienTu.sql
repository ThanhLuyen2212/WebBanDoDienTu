use master
IF exists(select * from sysdatabases where name='WebBanDoDienTu')
	drop database WebBanDoDienTu
go
create database WebBanDoDienTu
go
use WebBanDoDienTu
go 

create table KhachHang
(
	IDKH int primary key Identity(1,1),
	TenKH nvarchar(50), 
	SDT nvarchar(50) ,
	DiaChiGiaoHang1 nvarchar(50) ,
	DiaChiGiaoHang2 nvarchar(50) ,
	Email nvarchar(50),
	NgaySinh datetime,
	UserName nvarchar(50)  , 
	Password nvarchar(50)  ,
	DiemTichLuy int,
	DiemTichLuyDaDung int,
	LoaiKhachHang nvarchar(10), -- 'Bac' , 'Vang', 'Kim cuong'
)

create table Admin
(
	IDAdmin int primary key Identity(1,1),
	TenAdmin nvarchar(50), 
	SDT nvarchar(50) ,
	DiaChi nvarchar(50) ,
	NgaySinh datetime,
	UserName nvarchar(50)  , 
	Password nvarchar(50)  ,
)

create table LoaiMatHang
(
	IDLoaiMH int primary key Identity(1,1),
	TenLoaiMH NVARCHAR(50),
)

create table MatHang
(
	IDMH int primary key Identity(1,1),
	TenMH NVARCHAR(50)  ,
	IDLoaiMH int,
	MoTa NVARCHAR(max),
	DonGia int,		
	NgayNhapHang datetime,
	SoLuong int,
	HinhAnh1 image,
	HinhAnh2 image,
	HinhAnh3 image,
	HinhAnh4 image,
	MoTaChiTiet nvarchar(MAX),
	CONSTRAINT FK_MATHANG_LOAIMATHANG FOREIGN KEY (IDLoaiMH) REFERENCES LoaiMatHang(IDLoaiMH),
)

create table PhuongThucThanhToan
(
	IDPT int primary key Identity(1,1),
	TenPT nvarchar(50),
)


create table TrangThai
(
	IDTrangThai int primary key identity(1,1),
	TenTrangThai nvarchar(20),
)



create table DonDatHang
(
	IDHD int primary key Identity(1,1),  
	NgayMua datetime,
	DiaChiNhanHang nvarchar(max),
	TongSoluong int,
	TongTien int,	
	IDKH int null, -- có thể rỗng để ứng với khách hàng vãng lai
	TrangThaiThanhToan bit, -- 0 là chứa thanh toán, 1 là đã thanh toán 
	NgayThanhToan date,
	IDPT int, -- phương thức thanh toán or hình thức thanh toán 
	IDTrangThai int,-- trạng thái hóa đơn

	
	GhiChu nvarchar(max),
	CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (IDKH) REFERENCES KhachHang(IDKH),
	CONSTRAINT FK_HOADON_PHUONGTHUC FOREIGN KEY (IDPT) REFERENCES PhuongThucThanhToan(IDPT),
	CONSTRAINT FK_HOADON_TRANGTHAI FOREIGN KEY (IDTrangThai) REFERENCES TrangThai(IDTrangThai),

	TenKHKhongAccount nvarchar(300), -- tên khách hàng không có tài khoản khi mua
	DienThoaiKhongAccount nvarchar(20), -- trạng thái mua khi không có tài khoản
)



create table ChiTietDonDatHang
(
	IDChiTietHD int primary key Identity(1,1),  
	IDHD int,
	IDMH int,
	DanhGiaSanPham nvarchar(100),
	BinhLuan nvarchar(100),
	SoluongMH int,	
	CONSTRAINT FK_CHITIETDONDATHANG_HOADON FOREIGN KEY (IDHD) REFERENCES DonDatHang(IDHD),
	CONSTRAINT FK_CHITIETDONDATHANG_MATHANG FOREIGN KEY (IDMH) REFERENCES MatHang(IDMH),
)

-- tạo dữ liệu khách hàng
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Paulie Edelheid', '398 627 8492', '3173 Gale Street', '8053 Logan Street', 'pedelheid0@redcross.org', '2022/01/15', 'pedelheid0', 'aZOEzkHeUx');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Tedman Levings', '585 200 8188', '312 John Wall Point', '820 Washington Hill', 'tlevings1@bloglovin.com', '2022/08/15', 'tlevings1', '9CnoLEi1VW');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Demetra Symers', '870 448 3945', '63 Rigney Way', '7840 Superior Plaza', 'dsymers2@addthis.com', '2022/06/20', 'dsymers2', '4I9bT80aWEb');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Caresa Vinden', '398 186 2336', '7324 Esker Way', '0 Haas Alley', 'cvinden3@timesonline.co.uk', '2022/01/31', 'cvinden3', 'xPU47vKye3JG');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Moyna Giraudel', '505 764 5503', '9935 Reindahl Crossing', '7016 Duke Park', 'mgiraudel4@europa.eu', '2022/04/21', 'mgiraudel4', 'bvas8lHHz');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Natividad Twelvetree', '634 750 5841', '604 Butterfield Avenue', '408 Hudson Crossing', 'ntwelvetree5@istockphoto.com', '2022/01/23', 'ntwelvetree5', 'jdrPw2r');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Pail Dunsire', '626 600 4718', '0616 Stuart Place', '329 Vahlen Point', 'pdunsire6@usgs.gov', '2022/08/26', 'pdunsire6', 'QNfCKVGT8');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Hamel Leatham', '281 329 2073', '95246 Nova Parkway', '494 Eliot Point', 'hleatham7@bandcamp.com', '2022/03/04', 'hleatham7', 'UAvnCZR9nTJD');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Grayce Bansal', '576 849 5797', '94377 Elka Lane', '3769 Cody Drive', 'gbansal8@twitter.com', '2022/07/04', 'gbansal8', 'zXzemx');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Bondie Brumhead', '257 848 2949', '44 Portage Park', '30 Morningstar Street', 'bbrumhead9@amazon.co.uk', '2022/09/27', 'bbrumhead9', 'CcNgnQYEN9PD');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Hesther O'' Molan', '929 387 6155', '758 Parkside Point', '4301 Lillian Court', 'hoa@netvibes.com', '2022/07/06', 'hoa', 'zFOWBsCT5e');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Loleta Hostan', '333 196 2038', '05 Glacier Hill Crossing', '3614 Northwestern Trail', 'lhostanb@europa.eu', '2022/06/26', 'lhostanb', 'nyGxRR3lqHJ');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Nappie McGarvie', '443 958 9549', '143 Schlimgen Drive', '59983 Lien Center', 'nmcgarviec@oaic.gov.au', '2022/10/20', 'nmcgarviec', 'cz1XfVOKp');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Fleur Norquoy', '244 733 5138', '03 Morningstar Court', '3 Arizona Street', 'fnorquoyd@gmpg.org', '2021/10/28', 'fnorquoyd', '6QCDArOeh');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Filbert Gravett', '255 295 1280', '9915 Forest Dale Park', '8 Killdeer Parkway', 'fgravette@cnn.com', '2022/06/25', 'fgravette', 'ayGRr2Ir8');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Cristy Tavinor', '756 154 6720', '12 High Crossing Center', '795 Miller Avenue', 'ctavinorf@psu.edu', '2022/06/29', 'ctavinorf', 'mBnEum9oS');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Minette Coupar', '917 206 2105', '9 Northport Parkway', '490 Vahlen Alley', 'mcouparg@skype.com', '2022/02/14', 'mcouparg', 'tQqH4LILG');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Falito Mac Geaney', '483 374 7520', '676 Becker Point', '5 Calypso Junction', 'fmach@tinyurl.com', '2022/06/29', 'fmach', 'pGfPNuSj');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Teddie Calderhead', '136 897 5113', '91987 Prentice Road', '97 Burning Wood Junction', 'tcalderheadi@cocolog-nifty.com', '2021/10/28', 'tcalderheadi', '7pVTpyGJHkS8');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Desirae Brackstone', '166 254 9139', '21817 Morningstar Drive', '39 Stone Corner Court', 'dbrackstonej@indiegogo.com', '2022/06/04', 'dbrackstonej', 'KRRlma7B');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Scarlet McArthur', '868 967 9466', '28 Buena Vista Junction', '4699 Washington Court', 'smcarthurk@baidu.com', '2021/11/19', 'smcarthurk', '1GTLmYjnx9');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Fan Syder', '300 276 3804', '84 Bowman Hill', '60 Packers Drive', 'fsyderl@yellowpages.com', '2022/02/27', 'fsyderl', 'yVmEfr');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Miguelita Acors', '367 114 9521', '9 Waywood Junction', '8 Golf Course Point', 'macorsm@yale.edu', '2022/02/19', 'macorsm', 'A84lRhTwb');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Winnie Jervoise', '519 966 2154', '87570 Dayton Avenue', '88430 Carey Drive', 'wjervoisen@discuz.net', '2022/07/18', 'wjervoisen', 'wsBmmz2f1pci');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Wait Lush', '577 878 8241', '4389 Fisk Road', '3 Autumn Leaf Circle', 'wlusho@oracle.com', '2022/03/26', 'wlusho', 'jT5Z9y4wWqJ1');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Noelani Chavrin', '357 992 2734', '0036 Butterfield Way', '298 Oakridge Alley', 'nchavrinp@multiply.com', '2022/02/04', 'nchavrinp', 'sHSuTNW');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Marylou Schrinel', '977 445 6322', '31064 Almo Lane', '196 Iowa Crossing', 'mschrinelq@vinaora.com', '2022/07/07', 'mschrinelq', 'rnJqVmHk');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Corella Aleveque', '876 103 9496', '91691 Pearson Court', '2209 Superior Avenue', 'calevequer@weather.com', '2022/02/01', 'calevequer', 'FfBIw2');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Micheline Garratty', '516 887 5420', '344 Raven Park', '1850 Coolidge Alley', 'mgarrattys@fc2.com', '2022/03/14', 'mgarrattys', 'oLJcYp7Q');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Lothaire Rapaport', '261 508 7572', '3083 Marquette Plaza', '15390 Sundown Circle', 'lrapaportt@usa.gov', '2022/08/23', 'lrapaportt', 'VHYfV1');
update KhachHang set DiemTichLuy = 10
update KhachHang set DiemTichLuyDaDung = 0
update KhachHang set LoaiKhachHang = 'Bac'


-- Tạo dữ liệu Admin
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Squirrel, arctic ground', '332-214-3276', 'fcurmi0@t.co', '6/14/2021', 'afrogley0', 'pa7LMY');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Squirrel, uinta ground', '828-747-2394', 'ttarver1@ovh.net', '1/1/2022', 'atoon1', 'hPuzMZ2p');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Cockatoo, red-breasted', '329-923-8024', 'mjubert2@indiatimes.com', '9/23/2021', 'vworld2', 'PeKMRMIdlU');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Gulls (unidentified)', '205-416-7076', 'pwinchcum3@multiply.com', '11/25/2021', 'lstrangeways3', 'JiGwoTtKbB');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Weaver, red-billed buffalo', '956-321-1004', 'agerssam4@bravesites.com', '4/5/2022', 'fcordelle4', 'ipszvqEFciwN');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Thanh Luyen','1234567890', 'Nha', '4/5/2022', '123', '123');
update Admin set UserName ='123', Password = '123' where TenAdmin = 'Thanh Luyen'

--Tạo loại mặt hàng
insert into LoaiMatHang (TenLoaiMH) values ('Lap top');
insert into LoaiMatHang (TenLoaiMH) values ('Màn hình');
insert into LoaiMatHang (TenLoaiMH) values ('Âm thanh');
insert into LoaiMatHang (TenLoaiMH) values ('Bàn phím');
insert into LoaiMatHang (TenLoaiMH) values ('Chuột');
insert into LoaiMatHang (TenLoaiMH) values ('Máy chơi game');
insert into LoaiMatHang (TenLoaiMH) values ('Phụ kiện Apple');
insert into LoaiMatHang (TenLoaiMH) values ('PC');
insert into LoaiMatHang (TenLoaiMH) values ('Ram');
insert into LoaiMatHang (TenLoaiMH) values ('Ổ cứng');

-- Tạo dữ liệu cho trạng thái đơn hàng
insert into TrangThai (TenTrangThai) values(N'Đặt hàng thành công')
insert into TrangThai (TenTrangThai) values(N'Đã duyệt đơn')
insert into TrangThai (TenTrangThai) values(N'Đóng gói')
insert into TrangThai (TenTrangThai) values(N'Giao hàng thành công')
insert into TrangThai (TenTrangThai) values(N'Không giao/ Hủy đơn')

-- tạo dữ liệu cho phương thức thanh toán 
insert into PhuongThucThanhToan(TenPT) values(N'Tiền mặt')
insert into PhuongThucThanhToan(TenPT) values(N'Chuyển khoản')
insert into PhuongThucThanhToan(TenPT) values(N'Thẻ tín dụng, thẻ ghi nợ quốc tế')
insert into PhuongThucThanhToan(TenPT) values(N'Quét mã QR')
insert into PhuongThucThanhToan(TenPT) values(N'Thẻ nội địa, banking ')
insert into PhuongThucThanhToan(TenPT) values(N'Ví momo')
 
 go
 -- tìm kiếm mặt hàng create procedure tìm kiếm theo một ký tự bất kỳ bằng tên sản phẩm
 create proc sp_TimKiemSanPham @KyTuTimKiem nvarchar(max)
 as
	select * from MatHang where TenMH like '%'+@KyTuTimKiem+'%'
 

 go
 exec sp_TimKiemSanPham 'dell'

 declare @timkiem nvarchar(max)
 set @timkiem = 'pau'
 select * from KhachHang where TenKH like '%'+@timkiem+'%'

 select * from KhachHang