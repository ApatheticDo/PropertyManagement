using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PropertyManagement.Models
{
    public class User
    {
        [Key]
        public int UserID { get; set; }

        public String UserName { get; set; }

        public String Password { get; set; }

        public bool IsAction { get; set; }

        [ForeignKey("RoleID")]
        public Role Role { get; set; }
        public int RoleID { get; set; }

        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

    }
}
