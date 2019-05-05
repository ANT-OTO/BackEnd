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
        public static List<Role> getAvailableRoleList(int CompanyId, int UserId, bool FunctionNeed)
        {
            List<Role> result = new List<Role>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCompanyRoleListGet(CompanyId, UserId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    if(item.ParentRoleId == 0)
                    {
                        Role tempRole = new Role();
                        tempRole.RoleId = item.SecRoleId;
                        tempRole.RoleName = item.RoleName;
                        if (FunctionNeed)
                        {
                            tempRole.FunctionList = getFunctionList(item.SecRoleId, UserId, CompanyId);
                        }
                        tempRole.ChildRoleList = getChildRole(item.SecRoleId, list, FunctionNeed, UserId);
                        tempRole.changeable = item.Changable;
                        tempRole.Available = item.Available;
                        result.Add(tempRole);
                    }
                }
            }
            return result;
        }

        public static Role getRoleDetail(int RoleId, int CompanyId, int UserId)
        {
            Role result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCompanyRoleListGet(CompanyId, UserId);
            if (list != null && list.Count() > 0)
            {
                foreach(var item in list)
                {
                    if(item.SecRoleId == RoleId)
                    {
                        result = new Role();
                        result.RoleId = item.SecRoleId;
                        result.RoleName = item.RoleName;
                        result.ChildRoleList = getChildRole(item.SecRoleId, list, false, UserId);
                        result.FunctionList = getFunctionList(item.SecRoleId, UserId, CompanyId);
                        result.changeable = item.Changable;
                        result.Available = item.Available;
                        break;
                    }
                }
            }
            return result;
        }

        private static List<Role> getChildRole(int RoleId, IQueryable<tfnCompanyRoleListGetResult> rolelist, bool FunctionNeed, int UserId)
        {
            List<Role> result = new List<Role>();
            if (rolelist != null)
            {
                foreach(var item in rolelist)
                {
                    if(item.ParentRoleId == RoleId)
                    {
                        Role tempRole = new Role();
                        tempRole.RoleId = item.SecRoleId;
                        tempRole.RoleName = item.RoleName;
                        if (FunctionNeed)
                        {
                            tempRole.FunctionList = getFunctionList(item.SecRoleId, UserId, item.CompanyId);
                        }
                        tempRole.ChildRoleList = getChildRole(item.SecRoleId, rolelist, FunctionNeed, UserId);
                        tempRole.changeable = item.Changable;
                        tempRole.Available = item.Available;
                        result.Add(tempRole);
                    }
                }
            }
            return result;
        }

        public static List<Function> getFunctionList(int RoleId, int UserId, int CompanyId)
        {
            List<Function> result = new List<Function>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnSecRoleFunctionListGet(RoleId, UserId);
            if(list!=null && list.Count() > 0)
            {
                foreach(var item in list)
                {
                    if(item.ParentSecFunctionId == 0)
                    {
                        var Function = new Function();
                        Function.FunctionId = item.SecFunctionId;
                        Function.FunctionName = item.FunctionName;
                        Function.Granted = item.Granted;
                        Function.ChildFunctionList = getChildFunctionList(item.SecFunctionId, list);
                        result.Add(Function);
                    }
                }
            }
            return result;
        }

        private static List<Function> getChildFunctionList(int FunctionId, IQueryable<tfnSecRoleFunctionListGetResult> FunctionList)
        {
            var result = new List<Function>();
            if(FunctionList != null)
            {
                foreach(var item in FunctionList)
                {
                    if(FunctionId == item.ParentSecFunctionId)
                    {
                        var Function = new Function();
                        Function.FunctionId = item.SecFunctionId;
                        Function.FunctionName = item.FunctionName;
                        Function.Granted = item.Granted;
                        Function.ChildFunctionList = getChildFunctionList(item.SecFunctionId, FunctionList);
                        result.Add(Function);
                    } 
                }
            }

            return result;
        }

        public static void grantFunctionToRole(int RoleId, int FunctionId, bool granted, bool ActionForSubRole, bool ActionForSubFunction, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_RoleFunctionUpdate(RoleId, FunctionId, granted, ActionForSubRole, ActionForSubFunction, UserId, 1);
            return;
        }

        public static Role createRole(String RoleName, int CompanyId, int ParentRoleId, int CopyRoleId, bool SystemRole, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? RoleId = 0;
            Role result = null;
            db.sp_Role_Update(ref RoleId, RoleName, ParentRoleId, false, true, CompanyId, CopyRoleId, UserId, 1);
            if(RoleId != null && RoleId > 0)
            {
                result = getRoleDetail(RoleId.Value, CompanyId, UserId);
            }
            return result;
        }

        public static Role updateRole(String RoleName, int RoleId, bool Available, int UserId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? SecRoleId = RoleId;
            if(RoleId == 0)
            {
                return null;
            }
            db.sp_Role_Update(ref SecRoleId, RoleName, 0, false, Available, CompanyId, 0, UserId, 1);
            if(SecRoleId != null && SecRoleId > 0)
            {
                return getRoleDetail(SecRoleId.Value, CompanyId, UserId);
            }
            return null;
        }


    }
}
