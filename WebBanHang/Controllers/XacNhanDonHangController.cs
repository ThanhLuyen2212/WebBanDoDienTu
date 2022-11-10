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
            KhachHang kh = data.KhachHangs.Find(donDatHang.KhachHang.IDKH);
            ViewBag.DiemTichLuyCuaKhachHang = kh.DiemTichLuyConLai;
            ViewBag.MaGiamGia = maGiamGia();
            ViewBag.SoTienTuongUngMaGiamGia = soTienTuongUnMaGiamGia();
            ViewBag.HangCuaKhachHang = kh.LoaiKhachHang;

           
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
                    donDatHang.IDPT = 8;
                }

                data.Entry(donDatHang).State = System.Data.Entity.EntityState.Modified;
                DonDatHang donDatHang1 = (DonDatHang)Session["DonDatHang"];

                donDatHang.IDKH = donDatHang1.IDKH;
                donDatHang.IDTrangThai = 1;
                donDatHang.TongSoluong = donDatHang1.TongSoluong;
                donDatHang.TongTien = donDatHang1.TongTien;
                donDatHang.NgayMua = DateTime.Now;

                if (donDatHang.DiaChiNhanHang == null)
                {
                KhachHang kh1 = data.KhachHangs.Where(c => c.IDKH == donDatHang.IDKH).FirstOrDefault();
                    donDatHang.DiaChiNhanHang = kh1.DiaChiGiaoHang1;
                }


                var checkmagiamgia = Request.Form.Get("DungMaGiamGia");
                if (checkbox != null)
                {
                    string magiamgia = Request.Form.Get("magiamgia");
                    if (magiamgia != null)
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
                if (checkboxDiemTichLuy != null)
                {
                    var diemdung = Request.Form.Get("SoDiemDung");
                    donDatHang.TongTien = donDatHang.TongTien - int.Parse(diemdung.ToString());
                    if (donDatHang.TongTien < 0) donDatHang.TongTien = 0;
                    data.sp_GiamDiemKhachHangKhiMuaHangSuDungDiem(donDatHang.IDKH, int.Parse(diemdung.ToString()));
                }


                int diem_tang = (int)donDatHang.TongTien / 10000;
                data.sp_ThemDiemKhachHangKhiMuaHang(donDatHang.IDKH, diem_tang);
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
            KhachHang kh = data.KhachHangs.Find(donDatHang.KhachHang.IDKH);
            ViewBag.DiemTichLuyCuaKhachHang = kh.DiemTichLuyConLai;
            ViewBag.HangCuaKhachHang = kh.LoaiKhachHang;
            ViewBag.MaGiamGia = maGiamGia();
            ViewBag.SoTienTuongUngMaGiamGia = soTienTuongUnMaGiamGia();

            return View(donDatHang);
        }

    }
}