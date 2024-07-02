using Microsoft.EntityFrameworkCore;
using PropertyManagement.Models;

namespace PropertyManagement.Models
{
    public class PropertyManagementDbContext : DbContext
    {
        public PropertyManagementDbContext(DbContextOptions<PropertyManagementDbContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
            .HasOne(r => r.Role)
            .WithMany(u => u.User)
            .HasForeignKey(r => r.RoleID);
        }

        public DbSet<User> Users { get; set; }

        public DbSet<Role> Roles { get; set; }

        public DbSet<Property> Properties { get; set; }


    }
}