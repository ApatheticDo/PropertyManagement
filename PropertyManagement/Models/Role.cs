using System.ComponentModel.DataAnnotations;

namespace PropertyManagement.Models
{
    public class Role
    {
        [Key]
        public int RoleID { get; set; }

        public String RoleName { get; set; }

        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

        public ICollection<User> User { get; set; }
    }
}
