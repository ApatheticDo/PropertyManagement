using PropertyManagement.Models;

namespace PropertyManagement.ViewModels
{
    public class PaginatedViewModel
    {
        public List<Property> Items { get; set; }

        public int PageIndex { get; set; }

        public int TotalItems { get; set; }

        public int PageSize { get; set; }

        public int TotalPages  => (int)Math.Ceiling((double)TotalItems / PageSize);
    }
}
