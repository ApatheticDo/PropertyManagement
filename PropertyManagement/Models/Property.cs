namespace PropertyManagement.Models
{
    public class Property
    {
        public int PropertyID { get; set; }

        public string PropertyCode { get; set; }

        public string PropertyName { get; set; }

        public string Supplier { get; set; }

        public string Image { get; set; }

        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
    }
}
