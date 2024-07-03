using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PropertyManagement.Models;
using System.Diagnostics;
using IronBarCode;
using Newtonsoft.Json;
using System.Text.Json;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using PropertyManagement.ViewModels;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;




namespace PropertyManagement.Controllers
{
    public class HomeController : Controller
    {
        //private readonly ILogger<HomeController> _logger;
        private readonly PropertyManagementDbContext _context;

        //public HomeController(ILogger<HomeController> logger)
        //{
        //    _logger = logger;
        //}
        private readonly IWebHostEnvironment _webHostEnvironment;

        public HomeController(IWebHostEnvironment webHostEnvironment, PropertyManagementDbContext context)
        {
            _webHostEnvironment = webHostEnvironment;
            _context = context;
        }

       

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult PropertyManage()
        {
            return View("Property");
        }

        public IActionResult Inventory() 
        {
            return View("Inventory");
        }

        public IActionResult Property(string? searchText, int? pageIndex, int? pageSize)
        {
            try
            {
                int pgIndex = pageIndex ?? 1;
                int pgSize = pageSize ?? 3;
                List<Property> prop;
                if (!string.IsNullOrEmpty(searchText))
                {
                    string[] keywords = searchText.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

                    var query = _context.Properties.AsQueryable();

                    foreach (var keyword in keywords)
                    {
                        query = query.Where(e =>
                            EF.Functions.Like(e.PropertyCode, $"%{keyword}%") ||
                            EF.Functions.Like(e.PropertyName, $"%{keyword}%") ||
                            EF.Functions.Like(e.Supplier, $"%{keyword}%"));
                    }
                     prop = query.ToList();
                }
                else
                {
                     prop = _context.Properties.ToList();
                }

                var pageData = prop.Skip((pgIndex - 1) * pgSize ).Take(pgSize).ToList();
                var model = new PaginatedViewModel
                {
                    Items = pageData,
                    PageIndex = pgIndex,
                    PageSize = pgSize,
                    TotalItems = prop.Count
                };
                return PartialView("DataList", model);

            }
            catch (Exception ex)
            {
                
                ViewBag.ErrorMessage = "Đã xảy ra lỗi khi lấy danh sách thuộc tính.";
                
                Console.WriteLine("Error retrieving properties: " + ex.Message);
            }

            return View();
        }

        public IActionResult Staff()
        {
            try
            {
                var staff = _context.Users.Include(r => r.Role).Where(r => r.RoleID == 2).ToList();
                ViewBag.StaffUser = staff;
                return View("~/Views/Home/Staff.cshtml");
            }
            catch (Exception ex)
            {

                ViewBag.ErrorMessage = "Đã xảy ra lỗi khi lấy danh sách nhân viên.";
                
                Console.WriteLine("Error retrieving properties: " + ex.Message);
            }
            return View();
        }

        public IActionResult UsersActive(int userID)
        {
            var staff = _context.Users.Find(userID);
            if (staff == null)
            {
                return NotFound();
            }
            else if (staff.IsAction == false)
            {
                staff.IsAction = true;
            }
            else
            {
                staff.IsAction = false;
            }

            try
            {
                _context.SaveChanges();
                return RedirectToAction("Staff");
            }
            catch
            {
                return RedirectToAction("Error");
            }

        }



        public IActionResult AddProperty()
        {
            return View();
        }



        public IActionResult NewProperty(PropertyViewModel model)
        {

            int? crBy = HttpContext.Session.GetInt32("id");

            if (ModelState.IsValid)
            {
                string uniqueFileName = UpLoadedFile(model);
                if (crBy != null)
                {
                    Property property = new Property()
                    {
                        PropertyCode = model.PropertyCode,
                        PropertyName = model.PropertyName,
                        Supplier = model.Supplier,
                        Image = uniqueFileName,
                        CreatedBy = crBy ?? 0,
                        CreatedOn = DateTime.Now,
                    };
                    //if (!model.IsImageFile())
                    //{
                    //    ModelState.AddModelError("Image", "Please choose a valid image file (jpg, jpeg, png, gif).");
                    //    ViewBag.Message = "Invalid information!";
                    //    return View(model); // Return to the view with error message
                    //}
                    var check = _context.Properties.FirstOrDefault(u => u.PropertyCode == model.PropertyCode);
                    if (check == null)
                    {
                        _context.Add(property);
                        _context.SaveChanges();
                        ViewBag.Message = "Add successfull !";
                    }
                    else
                    {
                        ViewBag.Message = "Code is already exist.";
                    }

                }
            }
            else
            {
                ViewBag.Message = "Invalid information !";
            }
            return RedirectToAction("PropertyManage", "Home");
        }

        public IActionResult EditProperty(int id)
        { 
            var find = _context.Properties.Find(id);
            


            var model = new PropertyViewModel();
            model.PropertyCode = find.PropertyCode;
            model.PropertyName = find.PropertyName;
            model.Supplier = find.Supplier;
            model.Image = find.Image;

            return View("EditProperty", model);
        
        }

        private string UpLoadedFile(PropertyViewModel model)
        {
            string uniqueFileName = null;

            if (model.Image != null)
            {
                string uploadsFolder = Path.Combine(_webHostEnvironment.WebRootPath, "images");

                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                uniqueFileName = Guid.NewGuid().ToString() + "_" + model.PropertyPicture.FileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    model.PropertyPicture.CopyTo(fileStream);
                }
            }
            return uniqueFileName;
        }

        public IActionResult CreateQRCode(PropertyQRCodeModel prop)
        {

            string jsonDataQR = Newtonsoft.Json.JsonConvert.SerializeObject(prop);
            

            var barcode = QRCodeWriter.CreateQrCode(jsonDataQR, 500,
            QRCodeWriter.QrErrorCorrectionLevel.Medium);

            var folder = Path.Combine(_webHostEnvironment.WebRootPath, "QRCodeImages");
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            string fileName = $"{prop.PropertyName}QR.png";
            string filePath = Path.Combine(folder, fileName);
            barcode.SaveAsPng(filePath);


            return RedirectToAction("PropertyManage");
        }



        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


    }
}
