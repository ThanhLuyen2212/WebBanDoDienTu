using System;
using System.Collections.Generic;
using System.Data.Entity;
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

        public List<string> maGiamGia()
        {
            List<string> maGiamGiaList = new List<string>();
            List<MaGiamGia> temp =  data.MaGiamGias.ToList();
            foreach (MaGiamGia item in temp)
            {
                maGiamGiaList.Add(item.IDMaGiamGia.ToString());
            }
            return maGiamGiaList;
        }

        public List<int> soTienTuongUnMaGiamGia()
        {
            List<int> tien = new List<int>();
            List<MaGiamGia> temp = data.MaGiamGias.ToList();
            foreach (MaGiamGia item in temp)
            {
                tien.Add(int.Parse(item.SoTienGiam.ToString()));
            }
            return tien;
        }


        // GET: Admin/AdminDonDatHangs/Edit/5
        public ActionResult XacNhan()
        {
            GioHang gio = (GioHang)Session["GioHang"];
            if (gio == null)
            {
                return RedirectToAction("Index", "Home");
            }
            if (Session["KhachHang"] == null)
            {
                return RedirectToAction("Index", "Login");
            }
            KhachHang kh = (KhachHang)Session["KhachHang"];
            ViewBag.IDPT = new SelectList(data.PhuongThucThanhToans, "IDPT", "TenPT", 1);
            ViewBag.DiemTichLuyCuaKhachHang = kh.DiemTichLuyConLai;
            ViewBag.MaGiamGia = maGiamGia();
            ViewBag.SoTienTuongUngMaGiamGia = soTienTuongUnMaGiamGia();
            ViewBag.HangCuaKhachHang = kh.LoaiKhachHang;
            return View();
        }

        // POST: Admin/AdminDonDatHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult XacNhanDonHang()
        {
            try
            {
                if (Session["KhachHang"] == null || Session["GioHang"] == null)
                {
                    return RedirectToAction("Index", "Login");
                }

                KhachHang khachHang = (KhachHang)Session["KhachHang"];

                DonDatHang donDatHang = new DonDatHang();

                donDatHang.IDKH = khachHang.IDKH;

                if (Request.Form.Get("DiaChiNhanHang") != null && Request.Form.Get("DiaChiNhanHang") != "")
                {
                    donDatHang.DiaChiNhanHang = Request.Form.Get("DiaChiNhanHang");
                }
                else
                {
                    donDatHang.DiaChiNhanHang = khachHang.DiaChiGiaoHang1;
                }

                var checkbox = Request.Form.Get("TrangThaiThanhToan");
                if (checkbox != null)
                {
                    donDatHang.IDPT = int.Parse(Request.Form.Get("IDPT").ToString());
                    donDatHang.TrangThaiThanhToan = true;
                    donDatHang.NgayThanhToan = DateTime.Now;
                }
                else
                {
                    donDatHang.TrangThaiThanhToan = false;
                    donDatHang.IDPT = 8;
                }

                donDatHang.IDTrangThai = 1;
                donDatHang.NgayMua = DateTime.Now;
                data.DonDatHangs.Add(donDatHang);
                data.SaveChanges();

                int tongtien = 0;
                int _tongHang = 0;
                try
                {
                    // Lấy tưng sản phẩm
                    GioHang gio = (GioHang)Session["GioHang"];

                    foreach (var item in gio.ListHang)
                    {
                        ChiTietDonDatHang detail = new ChiTietDonDatHang();
                        detail.IDDDH = donDatHang.IDDDH;
                        detail.IDMH = item.gioHang.IDMH;
                        detail.SoluongMH = item._soLuongHang;

                        tongtien += (int)(item.gioHang.DonGia * item._soLuongHang);
                        _tongHang += item._soLuongHang;
                        data.ChiTietDonDatHangs.Add(detail);
                        data.SaveChanges();
                    }
                }
                catch (Exception ex)
                {
                    string s = ex.Message;
                    data.DonDatHangs.Remove(donDatHang);
                }
                donDatHang.TongSoluong = _tongHang;
                donDatHang.TongTien = tongtien;


                var checkmagiamgia = Request.Form.Get("DungMaGiamGia");
                if (checkbox == "on")
                {
                    string magiamgia = Request.Form.Get("magiamgia");
                    if (magiamgia != "")
                    {
                        MaGiamGia mgg = data.MaGiamGias.Where(c => c.IDMaGiamGia == magiamgia).FirstOrDefault();
                        if (mgg != null)
                        {
                            donDatHang.TongTien = donDatHang.TongTien - mgg.SoTienGiam;
                            if (donDatHang.TongTien < 0) donDatHang.TongTien = 0;
                        }
                    }
                }


                var checkboxDiemTichLuy = Request.Form.Get("DungDiemTichLuy");
                if (checkboxDiemTichLuy == "on")
                {
                    var diemdung = Request.Form.Get("SoDiemDung");
                    donDatHang.TongTien = donDatHang.TongTien - int.Parse(diemdung.ToString());
                    if (donDatHang.TongTien < 0) donDatHang.TongTien = 0;
                    data.sp_GiamDiemKhachHangKhiMuaHangSuDungDiem(donDatHang.IDKH, int.Parse(diemdung.ToString()));
                }


                int diem_tang = (int)donDatHang.TongTien / 10000;
                data.sp_ThemDiemKhachHangKhiMuaHang(donDatHang.IDKH, diem_tang);

                /*data.Entry(donDatHang).State = EntityState.Modified;       */

                data.SaveChanges();
                Session.Remove("DonDatHang");
                Session.Remove("GioHang");
                Session.Remove("SoLuongHangTrongGioHang");
                return RedirectToAction("MuaThanhCong", "ThongBao");
            }
            catch
            {
                Session.Remove("DonDatHang");
                Session.Remove("GioHang");
                Session.Remove("SoLuongHangTrongGioHang");
                return Content("<script language='javascript' type='text/javascript'>alert ('Vui lòng kiểm tra lại thông tin!');</script>");

            }

            /*GioHang gioHang = (GioHang)Session["GioHang"];


            ViewBag.DonDatHang = donDatHang;
            ViewBag.GioHang = gioHang;

            ViewData["PhuongThucThanhToan"] = new SelectList(data.PhuongThucThanhToans.ToList(), "IDPT", "TenPT", donDatHang.PhuongThucThanhToan);

            donDatHang.IDTrangThai = 1;

            ViewBag.IDKH = new SelectList(data.KhachHangs, "IDKH", "TenKH", 1);
            ViewBag.IDPT = new SelectList(data.PhuongThucThanhToans, "IDPT", "TenPT", donDatHang.IDPT);
            ViewBag.IDTrangThai = new SelectList(data.TrangThais, "IDTrangThai", "TenTrangThai", donDatHang.IDTrangThai);
            KhachHang kh = data.KhachHangs.Find(donDatHang.KhachHang.IDKH);
            ViewBag.DiemTichLuyCuaKhachHang = kh.DiemTichLuyConLai;
            ViewBag.HangCuaKhachHang = kh.LoaiKhachHang;
            ViewBag.MaGiamGia = maGiamGia();
            ViewBag.SoTienTuongUngMaGiamGia = soTienTuongUnMaGiamGia();*/
        }

    }
}