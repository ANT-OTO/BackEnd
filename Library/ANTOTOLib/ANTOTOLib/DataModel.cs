using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public static class DataModel
    {
        ///<Summary>
        /// User Info
        ///</Summary>
        public class User
        {
            ///<Summary>
            /// UserId
            ///</Summary>
            public int UserId { get; set; }

            ///<Summary>
            /// First Name
            ///</Summary>
            public string FirstName { get; set; }

            ///<Summary>
            /// Last Name
            ///</Summary>
            public string LastName { get; set; }

            ///<Summary>
            /// Password , will not return
            ///</Summary>
            public string Password { get; set; }

            ///<Summary>
            /// Address
            ///</Summary>
            public UtilityClasses.Address Address { get; set; }

            ///<Summary>
            /// PhoneNumber
            ///</Summary>
            public UtilityClasses.PhoneNumber PhoneNumber { get; set; }

            ///<Summary>
            /// Login Name
            ///</Summary>
            public string LoginName { get; set; }

            ///<Summary>
            /// Email
            ///</Summary>
            public string Email { get; set; }

            ///<Summary>
            /// Available
            ///</Summary>
            public bool Available { get; set; }

            ///<Summary>
            ///Company List
            ///</Summary>
            public List<CompanyRole> companyList { get; set; }

            ///<Summary>
            /// Current Company Id
            ///</Summary>
            public int DefaultCompanyId { get; set; }
        }

        public class CompanyRole
        {
            ///<Summary>
            /// Company Id
            ///</Summary>
            public int CompanyId { get; set; }

            ///<Summary>
            /// Company Name
            ///</Summary>
            public string CompanyName { get; set; }

            ///<Summary>
            /// User Role in this company
            ///</Summary>
            public Role Role { get; set; }
        }



        public class Role
        {
            ///<Summary>
            /// Role Id
            ///</Summary>
            public int? RoleId { get; set; }

            ///<Summary>
            /// Sub Role List
            ///</Summary>
            public List<Role> ChildRoleList { get; set; }

            ///<Summary>
            /// Accessability List
            ///</Summary>
            public List<Function> FunctionList { get; set; }

            ///<Summary>
            /// Role Name
            ///</Summary>
            public string RoleName { get; set; }

            ///<Summary>
            /// Whether user could edit this role or not
            ///</Summary>
            public bool changeable { get; set; }

            ///<Summary>
            /// Available or not
            ///</Summary>
            public bool Available { get; set; }
        }

        public class Function
        {
            ///<Summary>
            /// Function Id
            ///</Summary>
            public int? FunctionId { get; set; }

            ///<Summary>
            /// Function Name
            ///</Summary>
            public string FunctionName { get; set; }

            ///<Summary>
            ///Accessability is granted to this role or not
            ///</Summary>
            public bool? Granted { get; set; }

            ///<Summary>
            /// Sub Accessability List
            ///</Summary>
            public List<Function> ChildFunctionList { get; set; }
        }

        public class Company
        {
            ///<Summary>
            /// Company Id
            ///</Summary>
            public int CompanyId { get; set; }

            ///<Summary>
            /// Company Name
            ///</Summary>
            public string CompanyName { get; set; }

            ///<Summary>
            /// Company Contact First Name
            ///</Summary>
            public string ContactFirstName { get; set; }

            ///<Summary>
            /// Company Contact Last Name
            ///</Summary>
            public string ContactLastName { get; set; }

            ///<Summary>
            /// Email
            ///</Summary>
            public string Email { get; set; }
        }


        public class ResultToken
        {
            ///<Summary>
            /// Login Token
            ///</Summary>
            public string Token { get; set; }
        }
    }
}
