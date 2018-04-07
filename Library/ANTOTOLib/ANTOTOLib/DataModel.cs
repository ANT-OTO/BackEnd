using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public static class DataModel
    {
        public class User
        {
            public int UserId { get; set; }
            public Role Role { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Password { get; set; }
            public UtilityClasses.Address Address { get; set; }
            public UtilityClasses.PhoneNumber PhoneNumber { get; set; }
            public string LoginName { get; set; }
            public string Email { get; set; }
            public bool Available { get; set; }
        }


        public class Role
        {
            public int? RoleId { get; set; }
            public List<Role> ChildRoleList { get; set; }
            public List<Function> FunctionList { get; set; }
            public string RoleName { get; set; }
        }

        public class Function
        {
            public int? FunctionId { get; set; }
            public string FunctionName { get; set; }
            public bool? Granted { get; set; }
            public List<Function> ChildFunctionList { get; set; }
        }

        public class Company
        {
            public int CompanyId { get; set; }
            public string CompanyName { get; set; }
            public string ContactFirstName { get; set; }
            public string ContactLastName { get; set; }
            public string Email { get; set; }
        }
    }
}
