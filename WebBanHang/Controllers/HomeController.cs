using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;

namespace WebBanHang.Controllers
{
    public class HomeController : Controller
    {
        WebBanDoDienTuEntities data = new WebBanDoDienTuEntities();
        public ActionResult Index()
        {

            ViewBag.banner = data.MatHangs.Take(3).OrderByDescending(x => x.NgayNhapHang).ToList();

            ViewBag.newProduct = data.MatHangs.Take(8).OrderByDescending(x => x.NgayNhapHang).ToList();

            // lấy danh sách mặt hàng có nhiều hóa đơn nhất
            List<BestSeller> bestSellerList = new List<BestSeller>();
            foreach(MatHang item in data.MatHangs)
            {
                int soluong = data.ChiTietDonDatHangs.Count(c => c.IDMH == item.IDMH);
                bestSellerList.Add(new BestSeller(item, soluong));
            }
            bestSellerList.Sort((a, b) => a.soluongmua.CompareTo(b.soluongmua));

            List<MatHang> ListMatHang = new List<MatHang>();
            foreach(BestSeller item in bestSellerList)
            {
                ListMatHang.Add(item.matHang);
            }
            ViewBag.bestSeller = ListMatHang.Take(8);
            // kết thúc lấy 8 sản phẩm bán chạy nhất

            return View(data.MatHangs.ToList());
            
        }        
    }

    public class BestSeller
    {
        public MatHang matHang { get; set; }
        public int soluongmua  { get; set; }

        public BestSeller(MatHang matHang, int soluongmua)
        {
            this.matHang = matHang;
            this.soluongmua = soluongmua;
        }        
    }
}