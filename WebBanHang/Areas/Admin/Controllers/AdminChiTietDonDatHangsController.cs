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
    public class AdminChiTietDonDatHangsController : Controller
    {
        private WebBanDoDienTuEntities db = new WebBanDoDienTuEntities();

        // GET: Admin/AdminChiTietDonDatHangs 
        public ActionResult Index(string IDDDH)
        {
            if (Session["Admin"] == null)
            {
                return RedirectToAction("Index", "AdminLogin");
            }
            else
            {
                if (IDDDH == null)
                {
                    return View(db.ChiTietDonDatHangs.Include(c => c.DonDatHang).Include(c => c.MatHang).ToList());
                }
                else if (IDDDH.Equals(""))
                {
                    return View(db.ChiTietDonDatHangs.Include(c => c.DonDatHang).Include(c => c.MatHang).ToList());
                }
                else
                {
                    int id = int.Parse(IDDDH);
                    return View(db.ChiTietDonDatHangs.Include(c => c.DonDatHang).Include(c => c.MatHang).Where(c => c.IDDDH == id).ToList());
                }
            }
        }


        // GET: Admin/AdminChiTietDonDatHangs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ChiTietDonDatHang chiTietDonDatHang = db.ChiTietDonDatHangs.Find(id);
            if (chiTietDonDatHang == null)
            {
                return HttpNotFound();
            }
            return View(chiTietDonDatHang);
        }

        // GET: Admin/AdminChiTietDonDatHangs/Create
        public ActionResult Create()
        {
            ViewBag.IDDDH = new SelectList(db.DonDatHangs, "IDDDH", "DiaChiNhanHang");
            ViewBag.IDMH = new SelectList(db.MatHangs, "IDMH", "TenMH");
            return View();
        }

        // POST: Admin/AdminChiTietDonDatHangs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(ChiTietDonDatHang chiTietDonDatHang)
        {
            if (ModelState.IsValid)
            {
                db.ChiTietDonDatHangs.Add(chiTietDonDatHang);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IDDDH = new SelectList(db.DonDatHangs, "IDDDH", "DiaChiNhanHang", chiTietDonDatHang.IDDDH);
            ViewBag.IDMH = new SelectList(db.MatHangs, "IDMH", "TenMH", chiTietDonDatHang.IDMH);
            return View(chiTietDonDatHang);
        }

        // GET: Admin/AdminChiTietDonDatHangs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ChiTietDonDatHang chiTietDonDatHang = db.ChiTietDonDatHangs.Find(id);
            if (chiTietDonDatHang == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDDDH = new SelectList(db.DonDatHangs, "IDDDH", "DiaChiNhanHang", chiTietDonDatHang.IDDDH);
            ViewBag.IDMH = new SelectList(db.MatHangs, "IDMH", "TenMH", chiTietDonDatHang.IDMH);
            return View(chiTietDonDatHang);
        }

        // POST: Admin/AdminChiTietDonDatHangs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IDChiTietHD,IDDDH,IDMH,DanhGiaSanPham,BinhLuan,SoluongMH")] ChiTietDonDatHang chiTietDonDatHang)
        {
            if (ModelState.IsValid)
            {
                db.Entry(chiTietDonDatHang).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IDDDH = new SelectList(db.DonDatHangs, "IDDDH", "DiaChiNhanHang", chiTietDonDatHang.IDDDH);
            ViewBag.IDMH = new SelectList(db.MatHangs, "IDMH", "TenMH", chiTietDonDatHang.IDMH);
            return View(chiTietDonDatHang);
        }

        // GET: Admin/AdminChiTietDonDatHangs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ChiTietDonDatHang chiTietDonDatHang = db.ChiTietDonDatHangs.Find(id);
            if (chiTietDonDatHang == null)
            {
                return HttpNotFound();
            }
            return View(chiTietDonDatHang);
        }

        // POST: Admin/AdminChiTietDonDatHangs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ChiTietDonDatHang chiTietDonDatHang = db.ChiTietDonDatHangs.Find(id);
            db.ChiTietDonDatHangs.Remove(chiTietDonDatHang);
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
