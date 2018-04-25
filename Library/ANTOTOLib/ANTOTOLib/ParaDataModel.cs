using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public static class ParaDataModel
    {
        ///<Summary>
        /// User login input required
        ///</Summary>
        public class ParaUserLogin
        {
            ///<Summary>
            /// Login Name
            ///</Summary>
            public string LoginName { get; set; }

            ///<Summary>
            /// Password
            ///</Summary>
            public string Password { get; set; }

            ///<Summary>
            /// System Language Id
            ///</Summary>
            public int SystemLanguageId { get; set; }
        }

        public class ParaRoleCreate
        {
            ///<Summary>
            /// RoleName
            ///</Summary>
            public string RoleName { get; set; }
            ///<Summary>
            /// ParentRoleId
            ///</Summary>
            public int ParentRoleId { get; set; }
            ///<Summary>
            /// CopyRoleId
            ///</Summary>
            public int CopyRoleId { get; set; }
            ///<Summary>
            /// SystemRole
            ///</Summary>
            public bool SystemRole { get; set; }
        }

        public class ParaRoleGrantFunction
        {
            ///<Summary>
            /// RoleId
            ///</Summary>
            public int RoleId { get; set; }
            ///<Summary>
            /// FunctionId
            ///</Summary>
            public int FunctionId { get; set; }
            ///<Summary>
            /// granted
            ///</Summary>
            public bool granted { get; set; }
            ///<Summary>
            /// ActionForSubRole
            ///</Summary>
            public bool ActionForSubRole { get; set; }
            ///<Summary>
            /// ActionForSubFunction
            ///</Summary>
            public bool ActionForSubFunction { get; set; }
        }
    }
}
