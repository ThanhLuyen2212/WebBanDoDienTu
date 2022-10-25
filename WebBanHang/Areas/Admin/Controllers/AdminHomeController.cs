using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;
using WebBanHang.Areas.Admin.Models;

namespace WebBanHang.Areas.Admin.Controllers
{
    public class AdminHomeController : Controller
    {
        WebBanDoDienTuEntities db = new WebBanDoDienTuEntities();
        // GET: Admin/AdminHome
        public ActionResult Index()
        {
            if (Session["Admin"] == null)
            {
                return RedirectToAction("Index", "AdminLogin");
            }
            Session["HoaDonCho"] = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            ViewBag.SoHoaDonDangCho = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            ViewBag.TongSoHoaDon = db.DonDatHangs.Count();            
            ViewBag.TongSoMatHang = db.MatHangs.Count();
            ViewBag.TongSoTheLoai = db.LoaiMatHangs.Count();
            ViewBag.TongSoKhachHang = db.KhachHangs.Count();
            // thongke
            List<KhachHang> khachHangList = db.KhachHangs.ToList();
            List<ThongKeTheoKhachHang> listThongKe = new List<ThongKeTheoKhachHang>();
            foreach (var item in khachHangList)
            {
                if (db.DonDatHangs.FirstOrDefault(c => c.IDKH == item.IDKH) == null) continue;
                ThongKeTheoKhachHang tk = new ThongKeTheoKhachHang();
                tk.TenKhachHang = item.TenKH;
                tk.SoLuongHangHoaDaMua = int.Parse(db.DonDatHangs.Where(c => c.IDKH == item.IDKH).Sum(c => c.TongSoluong).ToString());
                tk.SoTienThuVeTuKhachHang = int.Parse(db.DonDatHangs.Where(c => c.IDKH == item.IDKH).Sum(c => c.TongTien).ToString());
                tk.DoanhThuChoKhachHang = int.Parse(db.DonDatHangs.Where(c => c.IDKH == item.IDKH).Sum(c => c.TongTien).ToString());
                listThongKe.Add(tk);
            }
            ViewBag.TktheoKhachHang = listThongKe;
            // thong ke theo san pham
            List<MatHang> matHangs = db.MatHangs.ToList();
            List<ThongKeTheoSanPham> listThongKe1 = new List<ThongKeTheoSanPham>();
            foreach (var item in matHangs)
            {
                if (db.ChiTietDonDatHangs.FirstOrDefault(c => c.IDMH == item.IDMH) == null) continue;
                ThongKeTheoSanPham sp = new ThongKeTheoSanPham();
                sp.TenSanPham = item.TenMH;
                int tmp = int.Parse(db.ChiTietDonDatHangs.Where(c => c.IDMH == item.IDMH).Sum(c => c.SoluongMH).ToString());
                sp.SoLuongHangHoaBanDuoc = int.Parse(db.ChiTietDonDatHangs.Where(c => c.IDMH == item.IDMH).Sum(c => c.SoluongMH).ToString());
                sp.SoTienHangHoaThuVe = (int)(item.DonGia * tmp);
                sp.DoanhThuChoHangHoa = sp.SoTienHangHoaThuVe;
                listThongKe1.Add(sp);
            }
            ViewBag.TkTheoSanPham = listThongKe1;
            return View();
        }
    }
}