using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ANTOTOLib.DataModel;

namespace ANTOTOLib
{
    public class CompanySecurity
    {
        public static List<Role> getAvailableRoleList(int CompanyId)
        {
            List<Role> result = new List<Role>();
            return result;
        }

        public static List<Function> getFunctionList(int RoleId, int CompanyId)
        {
            List<Function> result = new List<Function>();
            return result;
        }

        public static void grantFunctionToRole(int RoleId, int FunctionId, bool granted, bool ActionForSubRole, bool ActionForSubFunction)
        {

            return;
        }

        //public static Role createRole(Role role, int CompanyId, int ParentRoleId, int CopyRoleId, bool SystemRole)
        //{
            
        //}

        
    }
}
