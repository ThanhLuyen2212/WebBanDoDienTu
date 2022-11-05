﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;

namespace WebBanHang.Controllers
{
    public class GioHangKhachLeController : Controller
    {


        WebBanDoDienTuEntities data = new WebBanDoDienTuEntities();

        [HttpGet]
        public ActionResult Index()
        {            
            return View();
        }

        // GET: GioHangKhachLe
        public GioHang GetHang()
        {
            GioHang gio = Session["GioHang"] as GioHang;
            if ((gio == null) || Session["GioHang"] == null)
            {
                gio = new GioHang();
                Session["GioHang"] = gio;
            }
            return gio;
        }


        public ActionResult Addto(string id)
        {            
            var gio = data.MatHangs.SingleOrDefault(s => s.IDMH.ToString() == id);
            if (gio != null)
            {
                GetHang().Add(gio);

                // Số lượng hàng trong giở là bao nhiêu
                GioHang gioHang = Session["GioHang"] as GioHang;
                Session["SoLuongHangTrongGioHang"] = gioHang.sum().ToString();
            }
            return RedirectToAction("Show", "GioHangKhachLe");            
        }

        public ActionResult Show()
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Shop");
            }

            /*KhachHang kh = (KhachHang)Session["KhachHang"];*/

            GioHang gio = Session["GioHang"] as GioHang;

            return View(gio);
        }

        public ActionResult Update_quantity(FormCollection form)
        {
            GioHang gio = Session["GioHang"] as GioHang;
            string id_MatHang = form["ID MatHang"];
            int quatity = int.Parse(form["quantity"]);

            gio.Update_quantity(id_MatHang, quatity);

            Session["SoLuongHangTrongGioHang"] = gio.sum().ToString();

            return RedirectToAction("Show", "GioHangKhachLe");

        }

        public ActionResult Remove(int id)
        {
            GioHang gio = Session["GioHang"] as GioHang;
            gio.Remove(id);

            Session["SoLuongHangTrongGioHang"] = gio.sum().ToString();
            return RedirectToAction("Show", "GioHangKhachLe");
        }


        public PartialViewResult BagMathang()
        {
            int total = 0;
            GioHang gio = Session["GioHang"] as GioHang;
            if (gio != null)
            {
                total = gio.Total();
            }

            ViewBag.InforGio = total;
            return PartialView("BagMatHang");
        }

        public ActionResult Mua_Success()
        {
            return RedirectToAction("Index", "PhongThuThanhToan");
        }

        [HttpPost]
        public ActionResult MuaHang(FormCollection form)
        {
            try
            {
                DonDatHang hoadon = new DonDatHang();
                /*if (Session["UserName"] == null)
                {
                    return RedirectToAction("Index", "Login");
                }
                KhachHang khach = (KhachHang)Session["KhachHang"];
                hoadon.IDKH = khach.IDKH;*/
                data.DonDatHangs.Add(hoadon);
                data.SaveChanges();

                // Lấy tưng sản phẩm
                GioHang gio = Session["GioHang"] as GioHang;
                int tongtien = 0;
                int _tongHang = 0;
                foreach (var item in gio.ListHang)
                {
                    if (item._soLuongHang <= 0)
                    {
                        data.DonDatHangs.Remove(hoadon);
                        data.SaveChanges();
                        return Content("<script language='javascript' type='text/javascript'>alert ('Vui lòng kiểm tra lại thông tin!');</script>");
                    }
                    _tongHang += item._soLuongHang;

                    if (_tongHang == 0)
                    {
                        data.DonDatHangs.Remove(hoadon);
                        data.SaveChanges();
                        return Content("<script language='javascript' type='text/javascript'>alert ('Không có hàng hóa trong giỏ hàng!');</script>");
                    }

                    ChiTietDonDatHang detail = new ChiTietDonDatHang();
                    detail.IDDDH = hoadon.IDDDH;
                    detail.IDMH = item.gioHang.IDMH;
                    detail.SoluongMH = item._soLuongHang;

                    tongtien += (int)(item.gioHang.DonGia * item._soLuongHang);

                    data.ChiTietDonDatHangs.Add(detail);
                    data.SaveChanges();
                }

                hoadon.TongSoluong = _tongHang;
                hoadon.TongTien = tongtien;
                Session["DonDatHang"] = hoadon;
                Session["GioHang"] = gio;

                data.SaveChanges();
                //gio.clear();
                return RedirectToAction("XacNhan", "XacNhanDonHangKhachLe", new { id = hoadon.IDDDH });
            }
            catch
            {
                return Content("Vui lòng kiểm tra lại thông tin!");
            }

        }
    }
}