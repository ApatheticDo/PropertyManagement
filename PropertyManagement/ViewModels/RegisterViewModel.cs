using System.ComponentModel.DataAnnotations;

namespace PropertyManagement.ViewModels
{
    public class RegisterViewModel
    {       
            [Required(ErrorMessage = "Username is required")]
            public string UserName { get; set; }

            [Required(ErrorMessage = "Password is required")]
            public string Password { get; set; }

            [Compare("Password", ErrorMessage = "Password and confirmation password do not match.")]
            public string ConfirmPassword { get; set; }
        

    }
}
