using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;

namespace WebBanHang.Controllers
{
    public class XacNhanDonHangController : Controller
    {
        WebBanDoDienTuEntities data = new WebBanDoDienTuEntities();

        // GET: Admin/AdminDonDatHangs/Edit/5
        public ActionResult XacNhan(int? id)
        {
            
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonDatHang hoaDon = data.DonDatHangs.Find(id);
            if (hoaDon == null)
            {
                return RedirectToAction("Index", "Login");
            }

            GioHang gioHang = (GioHang)Session["GioHang"];         
            
            ViewBag.DonDatHang = hoaDon;
            ViewBag.GioHang = gioHang;   

            ViewData["IDPT"] = new SelectList(data.PhuongThucThanhToans, "IDPT", "TenPT", hoaDon.IDPT);
           
            return View(hoaDon);
        }

        // POST: Admin/AdminDonDatHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult XacNhan(DonDatHang hoaDon)
        {       
            
            if (ModelState.IsValid)
            {
                data.Entry(hoaDon).State = System.Data.Entity.EntityState.Modified;
                DonDatHang hoaDon1 = (DonDatHang)Session["DonDatHang"];
               
                hoaDon.IDKH = hoaDon1.IDKH;
                hoaDon.IDTrangThai = 1;
                hoaDon.TongSoluong = hoaDon1.TongSoluong;
                hoaDon.TongTien = hoaDon1.TongTien;

                data.SaveChanges();
                Session.Remove("DonDatHang");
                Session.Remove("GioHang");
                Session.Remove("SoLuongHangTrongGioHang");
                return RedirectToAction("MuaThanhCong","ThongBao");
            }

            GioHang gioHang = (GioHang)Session["GioHang"];


            ViewBag.DonDatHang = hoaDon;
            ViewBag.GioHang = gioHang;

            ViewData["PhuongThucThanhToan"] = new SelectList(data.PhuongThucThanhToans.ToList(), "IDPT", "TenPT", hoaDon.PhuongThucThanhToan);

            hoaDon.IDTrangThai = 1;

            ViewBag.IDKH = new SelectList(data.KhachHangs, "IDKH", "TenKH", hoaDon.IDKH);
            ViewBag.IDPT = new SelectList(data.PhuongThucThanhToans, "IDPT", "TenPT", hoaDon.IDPT);
            ViewBag.IDTrangThai = new SelectList(data.TrangThais, "IDTrangThai", "TenTrangThai", hoaDon.IDTrangThai);
            
            return View(hoaDon);
        }

    }
}