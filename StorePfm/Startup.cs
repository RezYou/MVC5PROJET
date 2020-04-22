using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin;
using Owin;
using StorePfm.Models;

[assembly: OwinStartupAttribute(typeof(StorePfm.Startup))]
namespace StorePfm
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            CreateRoles();
        }
        public void CreateRoles()
        {
            ApplicationDbContext db = new ApplicationDbContext();
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(db));
            if(!roleManager.RoleExists("admin"))
            {
                var role = new IdentityRole();
                role.Name = "admin";
                roleManager.Create(role);
            }
            if (!roleManager.RoleExists("Seller"))
            {
                var role = new IdentityRole();
                role.Name = "Seller";
                roleManager.Create(role);
            }
            if (!roleManager.RoleExists("Buyer"))
            {
                var role = new IdentityRole();
                role.Name = "Buyer";
                roleManager.Create(role);
            }
        }
    }
}
