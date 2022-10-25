using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;

namespace WebBanHang.Controllers
{
    public class ThongBaoController : Controller
    {
        WebBanDoDienTuEntities data = new WebBanDoDienTuEntities();
        // GET: ThongBao
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult MuaThanhCong()
        {

            return View();
        }
       
        public ActionResult CacMatHangDaMua()
        {
            if (Session["KhachHang"] != null)
            {
                KhachHang khachhang = (KhachHang)Session["KhachHang"];
                List<DonDatHang> listhoadon = data.DonDatHangs.Where(c => c.IDKH == khachhang.IDKH).ToList();
                List<ChiTietDonDatHang> listchitiethoadon = new List<ChiTietDonDatHang>();
                foreach (DonDatHang item in listhoadon)
                {
                    List<ChiTietDonDatHang> temp = data.ChiTietDonDatHangs.Where(c => c.IDHD == item.IDHD).ToList();
                    listchitiethoadon = listchitiethoadon.Concat(temp).ToList();
                }
                listchitiethoadon = listchitiethoadon.Distinct().ToList();
                ViewBag.chitietdonhang = listchitiethoadon;
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            return View();
        }



        public ActionResult CacDonHangDangCho()
        {
            if (Session["KhachHang"] != null)
            {
                KhachHang khachhang = (KhachHang)Session["KhachHang"];
                List<DonDatHang> listhoadon = data.DonDatHangs.Where(c => c.IDKH == khachhang.IDKH && c.IDTrangThai == 1).ToList();               
                ViewBag.cachoadondangcho = listhoadon;
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            return View();
        }

        public ActionResult HuyDonHang(FormCollection form)
        {
            if (Session["KhachHang"] != null)
            {
                int id = int.Parse(form["ID DonDatHang"].ToString());
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                DonDatHang hoaDon = data.DonDatHangs.FirstOrDefault(c => c.IDHD == id);
                if (hoaDon == null)
                {
                    return HttpNotFound();
                }
                data.DonDatHangs.Remove(hoaDon);
                data.SaveChanges();
                return RedirectToAction("CacDonHangDangCho", "ThongBao");
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }

        }

        public ActionResult TatCaCacDonHang()
        {

            if (Session["KhachHang"] != null)
            {
                KhachHang khachhang = (KhachHang)Session["KhachHang"];
                List<DonDatHang> listhoadon = data.DonDatHangs.Where(c => c.IDKH == khachhang.IDKH).ToList();
                ViewBag.tatcacacdonhang = listhoadon;
            }
            else
            {
                return RedirectToAction("Index", "Login");
            }
            return View();
        }
    }
}