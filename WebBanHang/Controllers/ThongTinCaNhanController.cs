using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHang.Models;

namespace WebBanHang.Controllers
{
    public class ThongTinCaNhanController : Controller
    {
        // GET: ThongTinCaNhan
        WebBanDoDienTuEntities data = new WebBanDoDienTuEntities();
        public ActionResult Index()
        {
            if (Session["KhachHang"] == null) return RedirectToAction("Index", "Login");
            return View((KhachHang)Session["KhachHang"]);           
        }

        [HttpPost]
        public ActionResult ChangePassword(FormCollection form)
        {
            KhachHang kh = Session["KhachHang"] as KhachHang;

            string oldpassword = form["Old password"];
            string newpassword = form["New password"];
            string confirmpassword = form["Confirm password"];

            if (ModelState.IsValid)
            {                               

                if (kh.Password != oldpassword)
                {
                    return Content("<script language='javascript' type='text/javascript'>alert     ('Thất bại! Bạn đã nhập sai mật khẩu cũ');</script>");
                }
                else if (newpassword != confirmpassword)
                {
                    return Content("<script language='javascript' type='text/javascript'>alert     ('Thất bại ! Mật khẩu nhập lại không đúng');</script>");
                }

                if (kh.Password == oldpassword && newpassword == confirmpassword)
                {
                    kh.Password = newpassword;
                    data.SaveChanges();
                    return Content("<script language='javascript' type='text/javascript'>alert     ('Thành công ! Chúc mừng bạn đã đổi mật khẩu thành công');</script>");
                }                        
            }
            
            return Content("<script language='javascript' type='text/javascript'>alert     ('Thất bại ! Có thể bạn đã nhập sai thông tin');</script>");

        }
    }
}