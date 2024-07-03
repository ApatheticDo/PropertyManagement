using System.ComponentModel.DataAnnotations;

namespace PropertyManagement.ViewModels

{
    public class UploadImageViewModel
    {
        [Required]
        [Display(Name = "Picture")]
        public IFormFile PropertyPicture { get; set; }


    }
}
