﻿using System;
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
            DonDatHang donDatHang = data.DonDatHangs.Find(id);
            if (donDatHang == null)
            {
                return RedirectToAction("Index", "Login");
            }

            GioHang gioHang = (GioHang)Session["GioHang"];         
            
            ViewBag.DonDatHang = donDatHang;
            ViewBag.GioHang = gioHang;   

            ViewData["IDPT"] = new SelectList(data.PhuongThucThanhToans, "IDPT", "TenPT", donDatHang.IDPT);
           
            return View(donDatHang);
        }

        // POST: Admin/AdminDonDatHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult XacNhan(DonDatHang donDatHang)
        {
            try
            {
                var checkbox = Request.Form.Get("TrangThaiThanhToan");
                if (checkbox != null)
                {
                    donDatHang.TrangThaiThanhToan = true;
                    donDatHang.NgayThanhToan = DateTime.Now;                    
                }
                else
                {
                    donDatHang.TrangThaiThanhToan = false;
                }
                data.Entry(donDatHang).State = System.Data.Entity.EntityState.Modified;
                DonDatHang donDatHang1 = (DonDatHang)Session["DonDatHang"];

                donDatHang.IDKH = donDatHang1.IDKH;
                donDatHang.IDTrangThai = 1;
                donDatHang.TongSoluong = donDatHang1.TongSoluong;
                donDatHang.TongTien = donDatHang1.TongTien;
                donDatHang.NgayMua = DateTime.Now;

                data.SaveChanges();
                Session.Remove("DonDatHang");
                Session.Remove("GioHang");
                Session.Remove("SoLuongHangTrongGioHang");
                return RedirectToAction("MuaThanhCong", "ThongBao");
            }
            catch
            {
                return Content("<script language='javascript' type='text/javascript'>alert ('Vui lòng kiểm tra lại thông tin!');</script>");
            }

            GioHang gioHang = (GioHang)Session["GioHang"];


            ViewBag.DonDatHang = donDatHang;
            ViewBag.GioHang = gioHang;

            ViewData["PhuongThucThanhToan"] = new SelectList(data.PhuongThucThanhToans.ToList(), "IDPT", "TenPT", donDatHang.PhuongThucThanhToan);

            donDatHang.IDTrangThai = 1;

            ViewBag.IDKH = new SelectList(data.KhachHangs, "IDKH", "TenKH", donDatHang.IDKH);
            ViewBag.IDPT = new SelectList(data.PhuongThucThanhToans, "IDPT", "TenPT", donDatHang.IDPT);
            ViewBag.IDTrangThai = new SelectList(data.TrangThais, "IDTrangThai", "TenTrangThai", donDatHang.IDTrangThai);
            
            return View(donDatHang);
        }

    }
}