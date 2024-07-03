using System.ComponentModel.DataAnnotations;

namespace PropertyManagement.ViewModels
{
    public class PropertyViewModel : UploadImageViewModel
    {
        [Required(ErrorMessage = "Please enter code")]
        public string PropertyCode { get; set; }
        [Required(ErrorMessage = "Please enter name")]
        public string PropertyName { get; set; }
        [Required(ErrorMessage = "Please enter supplier")]
        public string Supplier { get; set; }
        
        public string Image { get; set; }

    }
}
