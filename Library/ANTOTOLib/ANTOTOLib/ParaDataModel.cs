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
    }
}
