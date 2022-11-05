using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;
using WebBanHang.Areas.Admin.Models;

namespace WebBanHang.Areas.Admin.Controllers
{
    public class AdminThongKeController : Controller
    {
        WebBanDoDienTuEntities data = new WebBanDoDienTuEntities();
        // GET: Admin/AdminThongKe
        public ActionResult Index()
        {
            return View();
        }

        // thống kê doanh thu theo khách hàng
        public ActionResult ThongKeDoanhThuTheoKhachHang()
        {

            if (Session["Admin"] == null)
            {
                return RedirectToAction("Index", "AdminLogin");
            }

            List<KhachHang> khachHangList = data.KhachHangs.ToList();
            List<ThongKeTheoKhachHang> listThongKe = new List<ThongKeTheoKhachHang>();           
            
            foreach (var item in khachHangList)
            {
                if (data.DonDatHangs.FirstOrDefault(c => c.IDKH == item.IDKH) == null) continue;
                ThongKeTheoKhachHang tk = new ThongKeTheoKhachHang();               
                tk.TenKhachHang = item.TenKH;
                tk.SoLuongHangHoaDaMua = int.Parse(data.DonDatHangs.Where(c => c.IDKH == item.IDKH).Sum(c => c.TongSoluong).ToString());
                tk.SoTienThuVeTuKhachHang = int.Parse(data.DonDatHangs.Where(c => c.IDKH == item.IDKH).Sum(c => c.TongTien).ToString());
                tk.DoanhThuChoKhachHang = int.Parse(data.DonDatHangs.Where(c => c.IDKH == item.IDKH).Sum(c => c.TongTien).ToString());
                listThongKe.Add(tk);
            }
             
            return View(listThongKe);           
           
        }

        // Thống kê doang thu theo sản phẩm
        public ActionResult ThongKeDoanhThuTheoSanPham(DateTime? NgayBatDau, DateTime? NgayKetThuc)
        {
            if (Session["Admin"] == null)
            {
                return RedirectToAction("Index", "AdminLogin");
            }


            /* List<MatHang> matHangs = data.ThongKeTheoDoanhThuTheoSanPham(NgayBatDau, NgayKetThuc).ToList();
             List<ThongKeTheoSanPham> listThongKe = new List<ThongKeTheoSanPham>();
             foreach (var item in matHangs)
             {
                 if (matHangs == null) continue;
                 ThongKeTheoSanPham sp = new ThongKeTheoSanPham();

                 List<MatHang> mh = data.MatHangs.Where(s => s.IDMH == item.IDMH).ToList();

                 int tmp = int.Parse(data.ChiTietDonDatHangs.Where(c => c.IDMH == item.IDMH ).Sum(c => c.SoluongMH).ToString());

                 sp.SoLuongHangHoaBanDuoc = int.Parse(data.ChiTietDonDatHangs.Where(c => c.IDMH == item.IDMH).Sum(c => c.SoluongMH).ToString());      

                 sp.SoTienHangHoaThuVe = (int)(mh[0].DonGia * tmp);

                 sp.DoanhThuChoHangHoa = sp.SoTienHangHoaThuVe;

                 listThongKe.Add(sp);
             }

             return View(listThongKe);*/
            return View();
        }
    }
}