using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;

namespace WebBanHang.Areas.Admin.Controllers
{
    public class AdminDonDatHangsController : Controller
    {
        private WebBanDoDienTuEntities db = new WebBanDoDienTuEntities();

        // GET: Admin/AdminDonDatHangs
        public ActionResult Index()
        {
            if (Session["Admin"] == null)
            {
                return RedirectToAction("Index", "AdminLogin");
            }

            Session["DonDatHangCho"] = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            var donDatHangs = db.DonDatHangs.Include(h => h.KhachHang).Include(h => h.PhuongThucThanhToan).Include(h => h.TrangThai);
            return View(donDatHangs.ToList());
        }

        // GET: Admin/AdminDonDatHangs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonDatHang donDatHang = db.DonDatHangs.Find(id);
            if (donDatHang == null)
            {
                return HttpNotFound();
            }
            return View(donDatHang);
        }

        // GET: Admin/AdminDonDatHangs/Create
        public ActionResult Create()
        {
            ViewBag.IDKH = new SelectList(db.KhachHangs, "IDKH", "TenKH");
            ViewBag.IDPT = new SelectList(db.PhuongThucThanhToans, "IDPT", "TenPT");
            ViewBag.IDTrangThai = new SelectList(db.TrangThais, "IDTrangThai", "TenTrangThai");
            return View();
        }

        // POST: Admin/AdminDonDatHangs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDHD,NgayMua,TongSoluong,TongTien,IDKH,IDPT,IDTrangThai")] DonDatHang donDatHang)
        {
            if (ModelState.IsValid)
            {
                db.DonDatHangs.Add(donDatHang);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            Session["DonDatHangCho"] = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            ViewBag.IDKH = new SelectList(db.KhachHangs, "IDKH", "TenKH", donDatHang.IDKH);
            ViewBag.IDPT = new SelectList(db.PhuongThucThanhToans, "IDPT", "TenPT", donDatHang.IDPT);
            ViewBag.IDTrangThai = new SelectList(db.TrangThais, "IDTrangThai", "TenTrangThai", donDatHang.IDTrangThai);
            return View(donDatHang);
        }

        // GET: Admin/AdminDonDatHangs/Edit/5
        
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonDatHang donDatHang = db.DonDatHangs.Find(id);
            if (donDatHang == null)
            {
                return HttpNotFound();
            }
            Session["DonDatHangCho"] = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            ViewBag.IDKH = new SelectList(db.KhachHangs, "IDKH", "TenKH", donDatHang.IDKH);
            ViewBag.IDPT = new SelectList(db.PhuongThucThanhToans, "IDPT", "TenPT", donDatHang.IDPT);
            ViewBag.IDTrangThai = new SelectList(db.TrangThais, "IDTrangThai", "TenTrangThai", donDatHang.IDTrangThai);
            Session["TrangThai"] = donDatHang.IDTrangThai;
            return View(donDatHang);
        }

        // POST: Admin/AdminDonDatHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDHD,NgayMua,TongSoluong,TongTien,IDKH,IDPT,IDTrangThai")] DonDatHang donDatHang)
        {
            if (ModelState.IsValid)
            {
                db.Entry(donDatHang).State = EntityState.Modified;
                db.SaveChanges();
                if ((int)Session["TrangThai"] == 1 && donDatHang.IDTrangThai != 1)
                {
                    List<ChiTietDonDatHang> cthd = db.ChiTietDonDatHangs.Where(c => c.IDHD == donDatHang.IDHD).ToList();
                    foreach(ChiTietDonDatHang item in cthd)
                    {
                        MatHang mh = db.MatHangs.FirstOrDefault(c => c.IDMH == item.IDMH);
                        mh.SoLuong = mh.SoLuong - item.SoluongMH;
                        
                    }
                }
                else
                {
                    if((int)Session["TrangThai"] != 1 && donDatHang.IDTrangThai == 1)
                    {
                        List<ChiTietDonDatHang> cthd = db.ChiTietDonDatHangs.Where(c => c.IDHD == donDatHang.IDHD).ToList();
                        foreach (ChiTietDonDatHang item in cthd)
                        {
                            MatHang mh = db.MatHangs.FirstOrDefault(c => c.IDMH == item.IDMH);
                            mh.SoLuong = mh.SoLuong + item.SoluongMH;
                           
                        }
                    }
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            Session["DonDatHangCho"] = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            ViewBag.IDKH = new SelectList(db.KhachHangs, "IDKH", "TenKH", donDatHang.IDKH);
            ViewBag.IDPT = new SelectList(db.PhuongThucThanhToans, "IDPT", "TenPT", donDatHang.IDPT);
            ViewBag.IDTrangThai = new SelectList(db.TrangThais, "IDTrangThai", "TenTrangThai", donDatHang.IDTrangThai);
            return View(donDatHang);
        }

        // GET: Admin/AdminDonDatHangs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonDatHang donDatHang = db.DonDatHangs.Find(id);
            if (donDatHang == null)
            {
                return HttpNotFound();
            }
            Session["DonDatHangCho"] = db.DonDatHangs.Where(c => c.TrangThai.TenTrangThai.Equals("Chờ duyệt đơn hàng")).Count();
            return View(donDatHang);
        }

        // POST: Admin/AdminDonDatHangs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DonDatHang donDatHang = db.DonDatHangs.Find(id);
            db.DonDatHangs.Remove(donDatHang);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
