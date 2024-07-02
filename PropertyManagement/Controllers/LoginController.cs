using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PropertyManagement.Models;
using PropertyManagement.ViewModels;

namespace PropertyManagement.Controllers
{
    public class LoginController : Controller
    {
        private readonly PropertyManagementDbContext _context;

        public LoginController(PropertyManagementDbContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public IActionResult Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = _context.Users.Include(r => r.Role).FirstOrDefault(u => u.UserName == model.UserName.Trim() && u.Password == model.Password);
                if (user != null && user.IsAction == true)
                {
                    if (user.RoleID == 1)
                    {
                        HttpContext.Session.SetString("admin", model.UserName);
                    }
                    else
                    {
                        HttpContext.Session.SetString("user", model.UserName);
                    }
                    HttpContext.Session.SetString("pass", model.Password);
                    HttpContext.Session.SetInt32("id", user.UserID);

                    return RedirectToAction("PropertyManage", "Home");
                }
                else if (user != null && user.IsAction == false)
                {
                    ViewBag.error = "Tài khoản đã bị khóa";
                    return View("~/Views/Home/Login.cshtml");
                }
                else
                {
                    ViewBag.error = "Tên đăng nhập hoặc mật khẩu chưa chính xác";
                    return View("~/Views/Home/Login.cshtml");
                }
            }
            ViewBag.error = "Thông tin không hợp lệ";
            return View("~/Views/Home/Login.cshtml");
        }


        public IActionResult Register()
        {
            return View("/Views/Home/Register.cshtml");
        }

        public IActionResult RegisterNewUser(RegisterViewModel model)
        {
            
                if (ModelState.IsValid)
                {
                    User user = new User();

                    user.UserName = model.UserName;
                    user.Password = model.Password;
                    user.IsAction = true;
                    user.RoleID = 2;
                    user.CreatedBy = 1;
                    user.CreatedOn = DateTime.Now;

                var check = _context.Users.FirstOrDefault(u => u.UserName == model.UserName);
            
                if (check == null)
                {
                    _context.Users.Add(user);
                    _context.SaveChanges();
                    ViewBag.Message = "Add successfull ! ";

                    return View("/Views/Home/Index.cshtml");
                }else
                    ViewBag.Message = "Username is already exist";

                    return View("/Views/Home/Register.cshtml");
                }
                else 
                {
                    ViewBag.Message = "Register unsuccessfull! Username or password is not valid";
                    return View("/Views/Home/Register.cshtml");
                }
                  
        }

        public IActionResult Logout()
        {
            //HttpContext.Session.Remove("user");
            //HttpContext.Session.Remove("pass");
            HttpContext.Session.Clear(); 
            HttpContext.Session.CommitAsync();
            return RedirectToAction("Index", "Home");
        }
    }
}
