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
	NgaySinh date,
	UserName nvarchar(50)  , 
	Password nvarchar(50)  ,
	DiemTichLuy int,
	DiemTichLuyConLai int,
	LoaiKhachHang nvarchar(10), -- 'Bac' , 'Vang', 'Kim cuong'
)
go
create table Admin
(
	IDAdmin int primary key Identity(1,1),
	TenAdmin nvarchar(50), 
	SDT nvarchar(50) ,
	DiaChi nvarchar(50) ,
	NgaySinh date,
	UserName nvarchar(50)  , 
	Password nvarchar(50)  ,
)
go
create table LoaiMatHang
(
	IDLoaiMH int primary key Identity(1,1),
	TenLoaiMH NVARCHAR(50),
)
go
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
go
create table PhuongThucThanhToan
(
	IDPT int primary key Identity(1,1),
	TenPT nvarchar(50),
)
go
create table TrangThai
(
	IDTrangThai int primary key identity(1,1),
	TenTrangThai nvarchar(20),
)


-- Bảng nhân viên
go
create table NhanVien(
	IDNhanVien int primary key identity(1,1),
	TenNhanVien nvarchar(100),
	SDT nvarchar(20),
	Email nvarchar(100),
	DiaChi nvarchar(100),
	ChucVu nvarchar(100),--Admin, chủ cửa hàng, nhân viên bán hàng, nhân viên giao hàng, nhân viên kho
)


go
create table DonDatHang
(
	IDDDH int primary key Identity(1,1),  
	NgayMua date,
	DiaChiNhanHang nvarchar(max),
	TongSoluong int,
	TongTien int,	
	IDKH int null, -- có thể rỗng để ứng với khách hàng vãng lai
	TrangThaiThanhToan bit, -- 0 là chứa thanh toán, 1 là đã thanh toán 
	NgayThanhToan date,
	IDPT int, -- phương thức thanh toán or hình thức thanh toán 
	IDTrangThai int,-- trạng thái hóa đơn	
	IDNhanVien int, -- nhân viên giao hàng
	GhiChu nvarchar(max),
	CONSTRAINT FK_DONDATHANG_KHACHHANG FOREIGN KEY (IDKH) REFERENCES KhachHang(IDKH),
	CONSTRAINT FK_DONDATHANG_PHUONGTHUC FOREIGN KEY (IDPT) REFERENCES PhuongThucThanhToan(IDPT),
	CONSTRAINT FK_DONDATHANG_TRANGTHAI FOREIGN KEY (IDTrangThai) REFERENCES TrangThai(IDTrangThai),
	CONSTRAINT FK_DONDATHANG_NHANVIEN FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(IDNhanVien),

	TenKHKhongAccount nvarchar(300), -- tên khách hàng không có tài khoản khi mua
	DienThoaiKhongAccount nvarchar(20), -- trạng thái mua khi không có tài khoản
)

go
create table ChiTietDonDatHang
(
	IDChiTietDDH int primary key Identity(1,1),  
	IDDDH int,
	IDMH int,
	DonGia float,
	DanhGiaSanPham int,
	BinhLuan nvarchar(max),
	SoluongMH int,	
	CONSTRAINT FK_CHITIETDONDATHANG_DONDATHANG FOREIGN KEY (IDDDH) REFERENCES DonDatHang(IDDDH),
	CONSTRAINT FK_CHITIETDONDATHANG_MATHANG FOREIGN KEY (IDMH) REFERENCES MatHang(IDMH),
)

-- Bảng mã giảm giá
go
create table MaGiamGia(
	IDMaGiamGia nvarchar(100) primary key,	
	TenMaGiamGia nvarchar(100),

	NgayBatDauGiamGia date,
	NgayKetThucGiamGia date,
	SoTienGiam int,
)

-- tạo dữ liệu mã giảm giá
go
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('AAA', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('BBB', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('CCC', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('DDD', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('EEE', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('FFF', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('GGG', N'Mã giảm giá','2022/10/10','2022/12/30',10000)
insert into MaGiamGia (IDMaGiamGia, TenMaGiamGia,NgayBatDauGiamGia,NgayKetThucGiamGia,SoTienGiam) values('HHH', N'Mã giảm giá','2022/10/10','2022/12/30',10000)


-- tạo dữ liệu nhân viên giao hàng
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Lanni McCurtain', '8526666898', 'lmccurtain0@list-manage.com', '24297 Bluestem Park', N'Chủ của hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Nerte Havesides', '3019308613', 'nhavesides1@shutterfly.com', '748 Talisman Circle', N'Nhân viên giao hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Jereme Rawstorn', '6753025979', 'jrawstorn2@china.com.cn', '9923 Fulton Road', N'Nhân viên giao hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Luigi Stubbin', '2699449206', 'lstubbin3@patch.com', '1564 Debs Parkway', N'Nhân viên giao hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Delmore Kidder', '1987132273', 'dkidder4@harvard.edu', '2 Hayes Way', N'Nhân viên giao hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Archer Rowet', '9093490097', 'arowet5@forbes.com', '3 Sunfield Circle', N'Nhân viên giao hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Dorisa Lemmen', '5666169237', 'dlemmen6@wikispaces.com', '93868 Thierer Trail', N'Nhân viên giao hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Whitney Roughey', '5862446653', 'wroughey7@washingtonpost.com', '78093 Mcbride Point', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Boycie O'' Loughran', '8154757352', 'bo8@answers.com', '54311 Norway Maple Plaza', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Broddie Ostler', '7522658434', 'bostler9@archive.org', '093 Corben Parkway', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Ninnette Gonnin', '9961050482', 'ngonnina@yandex.ru', '29452 Little Fleur Drive', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Tasha Gwinnell', '3496679367', 'tgwinnellb@answers.com', '78122 Katie Hill', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Ulises Mc Meekin', '5218937001', 'umcc@umn.edu', '065 David Trail', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Lani Siebert', '4861675984', 'lsiebertd@rediff.com', '02498 Old Shore Place', N'Nhân viên bán hàng');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Deloris Robberts', '3482209454', 'drobbertse@mtv.com', '607 Orin Crossing', N'Nhân viên kho');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Chase Duffield', '2062064315', 'cduffieldf@china.com.cn', '5 Twin Pines Terrace', N'Nhân viên kho');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Esme Beaver', '1632858039', 'ebeaverg@merriam-webster.com', '2 Glacier Hill Terrace', N'Nhân viên kho');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Jory Bentson', '9402634095', 'jbentsonh@guardian.co.uk', '47 Muir Plaza', N'Nhân viên kho');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Thalia MacNeilage', '2487229492', 'tmacneilagei@shareasale.com', '0 Namekagon Court', N'Nhân viên kho');
insert into NhanVien ( TenNhanVien, SDT, Email, DiaChi, ChucVu) values ('Lorrie Beller', '6503055626', 'lbellerj@e-recht24.de', '8 Derek Place', N'Nhân viên kho');

go 
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
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Thai Tuan', '261 508 7572', '3083 Marquette Plaza', '15390 Sundown Circle', 'lrapaportt@usa.gov', '2022/08/23', 'tuan', '123');
insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password) values ('Hai Dien', '261 508 7572', '3083 Marquette Plaza', '15390 Sundown Circle', 'lrapaportt@usa.gov', '2022/08/23', 'dien', '123');
go
update KhachHang set DiemTichLuy = 10
update KhachHang set DiemTichLuyConLai = 10
update KhachHang set LoaiKhachHang = N'Bạc'
go
-- Tạo dữ liệu Admin
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Squirrel, arctic ground', '332-214-3276', 'fcurmi0@t.co', '6/14/2021', 'afrogley0', 'pa7LMY');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Squirrel, uinta ground', '828-747-2394', 'ttarver1@ovh.net', '1/1/2022', 'atoon1', 'hPuzMZ2p');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Cockatoo, red-breasted', '329-923-8024', 'mjubert2@indiatimes.com', '9/23/2021', 'vworld2', 'PeKMRMIdlU');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Gulls (unidentified)', '205-416-7076', 'pwinchcum3@multiply.com', '11/25/2021', 'lstrangeways3', 'JiGwoTtKbB');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Weaver, red-billed buffalo', '956-321-1004', 'agerssam4@bravesites.com', '4/5/2022', 'fcordelle4', 'ipszvqEFciwN');
insert into Admin (TenAdmin, SDT, DiaChi, NgaySinh, UserName, Password) values ('Thanh Luyen','1234567890', 'Nha', '4/5/2022', '123', '123');

go
--Tạo loại mặt hàng
insert into LoaiMatHang (TenLoaiMH) values (N'Lap top');
insert into LoaiMatHang (TenLoaiMH) values (N'Màn hình');
insert into LoaiMatHang (TenLoaiMH) values (N'Âm thanh');
insert into LoaiMatHang (TenLoaiMH) values (N'Bàn phím');
insert into LoaiMatHang (TenLoaiMH) values (N'Chuột');
insert into LoaiMatHang (TenLoaiMH) values (N'Máy chơi game');
insert into LoaiMatHang (TenLoaiMH) values (N'Phụ kiện Apple');
insert into LoaiMatHang (TenLoaiMH) values (N'PC');
insert into LoaiMatHang (TenLoaiMH) values (N'Ram');
insert into LoaiMatHang (TenLoaiMH) values (N'Ổ cứng');
insert into LoaiMatHang (TenLoaiMH) values (N'Tai nghe');
insert into LoaiMatHang (TenLoaiMH) values (N'Loa');

go
-- Tạo dữ liệu cho trạng thái đơn hàng
insert into TrangThai (TenTrangThai) values(N'Đặt hàng thành công')
insert into TrangThai (TenTrangThai) values(N'Đã duyệt đơn')
insert into TrangThai (TenTrangThai) values(N'Đóng gói')
insert into TrangThai (TenTrangThai) values(N'Giao hàng thành công')
insert into TrangThai (TenTrangThai) values(N'Giao hàng thất bại')
insert into TrangThai (TenTrangThai) values(N'Đơn hàng đã hủy')

go
-- tạo dữ liệu cho phương thức thanh toán 
insert into PhuongThucThanhToan(TenPT) values(N'Thanh toán trực tiếp - Trả tiền mặt')
insert into PhuongThucThanhToan(TenPT) values(N'Chuyển khoản')
insert into PhuongThucThanhToan(TenPT) values(N'Thẻ tín dụng, thẻ ghi nợ quốc tế')
insert into PhuongThucThanhToan(TenPT) values(N'Quét mã QR')
insert into PhuongThucThanhToan(TenPT) values(N'Thẻ nội địa, banking ')
insert into PhuongThucThanhToan(TenPT) values(N'Ví momo')
insert into PhuongThucThanhToan(TenPT) values(N'ship code – thanh toán khi nhận hàng')
insert into PhuongThucThanhToan(TenPT) values(N'Thanh toán khi nhận tiền')
DBCC CHECKIDENT('PhuongThucThanhToan', RESEED, 0)
select * from PhuongThucThanhToan
delete PhuongThucThanhToan
-- tạo dữ liệu đơn hàng
go
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/04/25', 2, 2, 2, 1, '2022/08/10', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2021/11/08', 2, 2, 2, 1, '2022/02/04', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/10/15', 2, 2, 2, 1, '2022/04/29', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/10/20', 2, 2, 2, 1, '2022/02/15', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/02/18', 2, 2, 2, 1, '2021/11/10', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/09/17', 2, 2, 2, 1, '2022/04/10', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/07/16', 2, 2, 2, 1, '2021/12/30', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/10/13', 2, 2, 2, 1, '2022/08/11', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/04/08', 2, 2, 2, 1, '2022/10/21', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/06/10', 2, 2, 2, 1, '2022/06/10', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (2,'2022/07/28', 2, 2, 2, 1, '2022/01/11', 1, 1);
insert into DonDatHang (IDKH,NgayMua, DiaChiNhanHang, TongSoluong, TongTien, TrangThaiThanhToan, NgayThanhToan, IDPT, IDTrangThai) values (3,'2022/05/23', 2, 2, 2, 1, '2022/06/21', 1, 1);

 ---------------------------------------------------------------
----------------- KHU VUC DANH CHO MẶT HÀNG --------------------
----------------------------------------------------------------

 go
 -- tìm kiếm mặt hàng create procedure tìm kiếm theo một ký tự bất kỳ bằng tên sản phẩm
 create proc sp_TimKiemSanPham @KyTuTimKiem nvarchar(max)
 as
	select * from MatHang where TenMH like '%'+@KyTuTimKiem+'%'
 
 ---------------------------------------------------------------
-----------KẾT THÚC KHU VUC DÀNH CHO MẶT HÀNG ------------------
----------------------------------------------------------------

---------------------------------------------------------------
---------------- KHU VUC DANH CHO KHÁCH HÀNG-------------------
---------------------------------------------------------------
-- thêm thông tin điểm tích lũy khi thêm khách hàng
go
create trigger tg_ThemDiemKhiThemKhachHang
on khachHang
after insert as
begin 
	update KhachHang 
	set DiemTichLuy = 0, DiemTichLuyConLai = 0, LoaiKhachHang = N'Bạc'
end

select * from DonDatHang
select * from TrangThai
go
-- Tạo một khách hàng mới
-- tạm thời không dùng
 create proc sp_ThemKhachHangMoi @TenKH nvarchar(50), @SDT nvarchar(50) , @DiaChiGiaoHang1 nvarchar(50), @DiaChiGiaoHang2 nvarchar(50),	@Email nvarchar(50), @NgaySinh datetime, @UserName nvarchar(50), @Password nvarchar(50)
as 
begin
	if(select count(8) from KhachHang where TenKH = @TenKH and SDT = @SDT and DiaChiGiaoHang1 = @DiaChiGiaoHang1 and DiaChiGiaoHang2 = @DiaChiGiaoHang2
												and Email = @Email and NgaySinh = @NgaySinh and UserName = @UserName and Password = @Password) > 0 
	return
	insert into KhachHang (TenKH, SDT, DiaChiGiaoHang1, DiaChiGiaoHang2, Email, NgaySinh, UserName, Password,DiemTichLuy,DiemTichLuyConLai,LoaiKhachHang) 
	values (@TenKH, @SDT, @DiaChiGiaoHang1, @DiaChiGiaoHang2, @Email, @NgaySinh, @UserName, @Password, 0,0,N'Bac')
end


-- cập nhật lại thông tin loại khách hàng khi sửa đổi thông tin khách hàng
go
create trigger CapNhatThongTinLoaiKhachHang
on KhachHang
after update as
begin
	declare @diemtichLuy int 
	declare @idkh int
	select @diemtichLuy = DiemTichLuy, @idkh = IDKH from inserted
	if(@diemtichLuy >= 0 and @diemtichLuy < 1000)
		begin update KhachHang set LoaiKhachHang = N'Bạc' where IDKH = @idkh end
	else if(@diemtichLuy >= 100 and @diemtichLuy < 5000)
		begin update KhachHang set LoaiKhachHang = N'Vàng' where IDKH = @idkh end
	else
		begin update KhachHang set LoaiKhachHang = N'Kim cương' where IDKH = @idkh end
end

go
-- cập nhật mật khẩu
create proc sp_ThayDoiMatKhau @MaKH int, @MatKhauMoi nvarchar(100)
as
begin 
	if not exists (select * from KhachHang where IDKH = @MaKH)
	begin 
		raiserror ('Khong co khach hang nay',16,1)
		rollback
		return
	end
	update KhachHang set Password = @MatKhauMoi where IDKH = @MaKH
end


-- cập nhật thông tin điểm khách hàng khi mua hàng thì điểm sẽ giảm
go
create proc sp_GiamDiemKhachHangKhiMuaHangSuDungDiem @idkh int, @diemdadung int
as
begin 
	if not exists (select * from KhachHang where IDKH = @idkh)
	begin 
		rollback
		return
	end
	if(@diemdadung < 0 or @diemdadung > (select DiemTichLuyConLai from KhachHang where IDKH = @idkh))
	rollback
	update KhachHang set DiemTichLuyConLai = DiemTichLuyConLai - @diemdadung where IDKH = @idkh
end



--Thêm điểm khách hàng khi mua hàng 
go
create proc sp_ThemDiemKhachHangKhiMuaHang @idkh int, @DiemThem int
as
begin 
	if not exists (select * from KhachHang where IDKH = @idkh)
	begin 
		rollback
		return
	end	
	update KhachHang set DiemTichLuyConLai = DiemTichLuyConLai + @DiemThem where IDKH = @idkh
	update KhachHang set DiemTichLuy = DiemTichLuy + @DiemThem where IDKH = @idkh
end
---------------------------------------------------------------
----------KẾT THÚC KHU VUC DANH CHO KHÁCH HÀNG ----------------
---------------------------------------------------------------

---------------------------------------------------------------
------------KHU VUC DÀNH CHO ĐƠN ĐẶT HÀNG ---------------------
---------------------------------------------------------------

-- sp_thông tin đơn đặt hàng từ ngày ... đến ngày ...
-- tìm kiếm đơn đặt hàng theo ngày 

go
create proc sp_TimKiemDonDatHang @NgayBatDau date, @NgayKetThuc date
as
begin
	if(@NgayBatDau not like null and @NgayKetThuc like null)	
	begin
		(select * from DonDatHang where NgayMua = @NgayBatDau)
	end
	else if (@NgayBatDau like null and @NgayKetThuc not like null)	
	begin
		(select * from DonDatHang where NgayMua = @NgayKetThuc)
	end
	else
	begin
	(select * from DonDatHang where NgayMua between @NgayBatDau and @NgayKetThuc)
	end
end

exec sp_TimKiemDonDatHang '2022/10/26',null

 -- cập nhật địa chỉ đặt hàng cho đơn đặt hàng -- 

 go
 -- xóa đơn đặt hàng
 -- cộng số lượng đã mua lại vào trong mặt hàng
 Create proc sp_XoaDonDatHangChuaDuyet @IDDDH int
 as
 begin 	
	if not exists (select IDTrangThai from DonDatHang where IDDDH = @IDDDH)
	begin
		raiserror ('Don dat hang này không được xóa',16,1)
		rollback 		
	end	

	-- tăng số lượng các mặt hàng lại vào trong mặt hàng
	-- bắt đầu cursor
	
	declare @idchitietDDH int
	declare ChiTietDonDatHangCursor cursor 
	for select IDChiTietDDH from ChiTietDonDatHang where IDDDH = @IDDDH

	open ChiTietDonDatHangCursor -- mở cursor
	
		fetch next from ChiTietDonDatHangCursor into @idchitietDDH

		while @@FETCH_STATUS = 0
		begin
			declare @idmh int 
			declare @soluong int

			select @idmh = IDMH, @soluong = SoluongMH from ChiTietDonDatHang where IDChiTietDDH = @idchitietDDH

			update MatHang set SoLuong = SoLuong + @soluong where IDMH = @idmh

			fetch next from ChiTietDonDatHangCursor into @idchitietDDH
		end
	close ChiTietDonDatHangCursor
	deallocate ChiTietDonDatHangCursor 
	-- kết thúc cursor
	delete ChiTietDonDatHang where IDDDH = @IDDDH
	delete DonDatHang where IDDDH = @IDDDH
 end


 -- phần Admin
 -- Xóa đơn đặt hàng 
 go
 create proc sp_XoaDonDatHangADMIN @IDDDH int
 as 
 begin 	
	if (select IDTrangThai from DonDatHang where IDDDH = @IDDDH) != 6  
	begin
		declare @idchitietDDH int
		declare ChiTietDonDatHangCursor cursor 
		for select IDChiTietDDH from ChiTietDonDatHang where IDDDH = @IDDDH

		open ChiTietDonDatHangCursor -- mở cursor
	
			fetch next from ChiTietDonDatHangCursor into @idchitietDDH

			while @@FETCH_STATUS = 0
			begin
				declare @idmh int 
				declare @soluong int

				select @idmh = IDMH, @soluong = SoluongMH from ChiTietDonDatHang where IDChiTietDDH = @idchitietDDH

				update MatHang set SoLuong = SoLuong + @soluong where IDMH = @idmh

				fetch next from ChiTietDonDatHangCursor into @idchitietDDH
			end
		close ChiTietDonDatHangCursor
		deallocate ChiTietDonDatHangCursor 
	end	
	-- kết thúc cursor
	delete ChiTietDonDatHang where IDDDH = @IDDDH
	delete DonDatHang where IDDDH = @IDDDH
 end



---------------------------------------------------------------
----------KẾT THÚC KHU VỰC DÀNH CHO ĐƠN ĐẶT HÀNG --------------
---------------------------------------------------------------

---------------------------------------------------------------
--------KHU VUC DANH CHO CHI TIẾT ĐƠN ĐẶT HÀNG ----------------
---------------------------------------------------------------
go
--	đánh giá mặt hàng đã mua
create proc sp_DanhGiaMatHangDaMua @idMH int, @SoSaoDanhGia int, @BinhLuan nvarchar(max)
as
	update ChiTietDonDatHang set DanhGiaSanPham = @SoSaoDanhGia, BinhLuan = @BinhLuan where IDChiTietDDH = @idMH

go
--khi thêm đơn đặt hàng thì trừ số lượng của mặt hàng đó
-- đã đúng
create trigger tg_TruKhiMuaDonHang 
on ChiTietDonDatHang after insert as
begin
	declare @IDMH int
	declare @soluongmua int
	select @IDMH = i.IDMH, @soluongmua = i.SoluongMH from inserted i 
	if(@soluongmua <= 0) begin
		raiserror ('So luong phai lon hon 0',16,1)
		rollback
		return 
	end
	declare @soluonghienco int
	select @soluonghienco = SoLuong from MatHang where IDMH = @IDMH 
	if(@soluonghienco < @soluongmua)
	begin	
		raiserror ('So luong hien co phai lon hon so luong mua',16,1)
		rollback
		return
	end
	update MatHang set SoLuong = SoLuong - @soluongmua where IDMH = @IDMH
end

---------------------------------------------------------------
------KẾT THÚC KHU VỰC DÀNH CHO CHI TIẾT ĐƠN ĐẶT HÀNG ---------
---------------------------------------------------------------

---------------------------------------------------------------
------------ KHU VUC DÀNH CHO THỐNG KÊ-------------------------
---------------------------------------------------------------
-- thống kê doanh thu theo sản phẩm
go
create proc sp_ThongKeTheoDoanhThuTheoSanPham @NgayBatDau date, @NgayKetThuc date
as
begin		
	if((@NgayBatDau is null or @NgayBatDau = '') and (@NgayKetThuc is null or @NgayKetThuc = ''))
	begin 
		select * from MatHang where IDMH in (select ct.IDMH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH )
		return
	end
	if(@NgayBatDau is null or @NgayBatDau = '')
	begin
		select * from MatHang where IDMH in (select ct.IDMH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH where NgayThanhToan between @NgayKetThuc and GETDATE())
		return
	end
	else if(@NgayKetThuc is null or @NgayKetThuc = '')
	begin
		select * from MatHang where IDMH in (select ct.IDMH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH where NgayThanhToan between @NgayBatDau and GETDATE())
		return
	end 
	else
 select * from MatHang where IDMH in (select ct.IDMH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH where NgayThanhToan between @NgayBatDau and @NgayKetThuc)
end


-- Liệt kê đơn đặt hàng theo ngày tháng năm
go
create proc sp_LietKeDonDatHangTheoNgay @NgayBatDau date, @NgayKetThuc date, @IDPhuongThucThanhToan int
as
begin 
	if(@IDPhuongThucThanhToan is null or @IDPhuongThucThanhToan = '' or @IDPhuongThucThanhToan = 8)
	begin
		if((@NgayBatDau is null or @NgayBatDau = '') and (@NgayKetThuc is null or @NgayKetThuc = ''))
		begin
			select * from DonDatHang 
			return
		end
		if(@NgayBatDau is null or @NgayBatDau = '')
		begin
			select * from DonDatHang where NgayThanhToan between @NgayKetThuc and GETDATE()
			return
		end
		else if(@NgayKetThuc is null or @NgayKetThuc = '')
		begin
			select * from DonDatHang where NgayThanhToan between @NgayBatDau and GETDATE()
			return
		end else
		select * from DonDatHang where NgayThanhToan between @NgayBatDau and @NgayKetThuc
	end
	else
	begin
		if((@NgayBatDau is null or @NgayBatDau = '') and (@NgayKetThuc is null or @NgayKetThuc = ''))
		begin
			select * from DonDatHang where IDPT = @IDPhuongThucThanhToan
			return
		end
		if(@NgayBatDau is null or @NgayBatDau = '')
		begin
			select * from DonDatHang where IDPT = @IDPhuongThucThanhToan and NgayThanhToan between @NgayKetThuc and GETDATE() 
			return
		end
		else if(@NgayKetThuc is null or @NgayKetThuc = '')
		begin
			select * from DonDatHang where IDPT = @IDPhuongThucThanhToan and NgayThanhToan between @NgayBatDau and GETDATE()
			return
		end else
		select * from DonDatHang where IDPT = @IDPhuongThucThanhToan and NgayThanhToan between @NgayBatDau and @NgayKetThuc
	end
end


-- Thống kê doanh thu theo khách hàng
go
create proc sp_ThongKeDoanhThuTheoKhachHang @NgayBatDau date, @NgayKetThuc date
as
begin 
	if((@NgayBatDau is null or @NgayBatDau = '') and (@NgayKetThuc is null or @NgayKetThuc = ''))
	begin 
		select * from KhachHang where IDKH in (select dh.IDKH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH )
		return
	end
	if(@NgayBatDau is null or @NgayBatDau = '')
	begin
		select * from KhachHang where IDKH in (select dh.IDKH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH where NgayThanhToan between @NgayKetThuc and GETDATE())
		return
	end
	else if(@NgayKetThuc is null or @NgayKetThuc = '')
	begin
		select * from KhachHang where IDKH in (select dh.IDKH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH where NgayThanhToan between @NgayBatDau and GETDATE())
		return
	end 
	else
 select * from KhachHang where IDKH in (select dh.IDKH from ChiTietDonDatHang ct inner join DonDatHang dh on ct.IDDDH = dh.IDDDH where NgayThanhToan between @NgayBatDau and @NgayKetThuc)

end



-- thống kê doanh thu theo khách hàng khách lẽ
go
create proc sp_ThongKeTheoDoanhThuTheoKhachHangLe @NgayBatDau date, @NgayKetThuc date
as
begin		
	if((@NgayBatDau is null or @NgayBatDau = '') and (@NgayKetThuc is null or @NgayKetThuc = ''))
	begin 
		select * from  DonDatHang where IDKH is null or IDKH = null 
		return
	end
	if(@NgayBatDau is null or @NgayBatDau = '')
	begin
		select * from DonDatHang dh  where NgayThanhToan between @NgayKetThuc and GETDATE() and IDKH is null or IDKH = null 
		return
	end
	else if(@NgayKetThuc is null or @NgayKetThuc = '')
	begin
		select * from DonDatHang where NgayThanhToan between @NgayBatDau and GETDATE() and IDKH is null or IDKH = null
		return
	end 
	else
 select * from DonDatHang dh where NgayThanhToan between @NgayBatDau and @NgayKetThuc and IDKH is null or IDKH = null
end



---------------------------------------------------------------
-------------- KẾT THÚC KHU VUC DÀNH CHO THỐNG KÊ -------------
---------------------------------------------------------------

select * from DonDatHang
select * from LoaiMatHang
select * from Admin
select * from KhachHang 
select * from PhuongThucThanhToan
select * from ChiTietDonDatHang
select * from TrangThai
select * from MatHang
--update DonDatHang set IDTrangThai =4 
--update ChiTietDonDatHang set DanhGiaSanPham is null

select * from DonDatHang
select * from ChiTietDonDatHang
delete DonDatHang
delete ChiTietDonDatHang
select * from MatHang
--delete MatHang where IDMH = 5
update KhachHang set DiemTichLuyConLai = 30000 where IDKH = 63

delete MatHang where idmh =3
	delete ChiTietDonDatHang where IDDDH = 72
	delete DonDatHang where IDDDH = 72
select * from DonDatHang
update ChiTietDonDatHang set DanhGiaSanPham = null , BinhLuan = null

select * from LoaiMatHang
select * from LoaiMatHang where TenLoaiMH = N'Bàn phím'
