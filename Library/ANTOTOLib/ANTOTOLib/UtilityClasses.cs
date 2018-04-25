using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class UtilityClasses
    {
        public class PhoneNumber
        {
            ///<Summary>
            /// Phone Number Id
            ///</Summary>
            public int PhoneNumberId { get; set; }

            ///<Summary>
            /// Phone number country Id 
            ///</Summary>
            public int CountryId { get; set; }

            ///<Summary>
            /// Phone number
            ///</Summary>
            public string Phonenumber { get; set; }
        }
        public class Address
        {
            ///<Summary>
            /// Country Id
            ///</Summary>
            public int CountryId { get; set; }

            ///<Summary>
            /// Address Id
            ///</Summary>
            public int AddressId { get; set; }

            ///<Summary>
            /// Address 1
            ///</Summary>
            public string Address1 { get; set; }

            ///<Summary>
            /// Address 2
            ///</Summary>
            public string Address2 { get; set; }

            ///<Summary>
            /// City
            ///</Summary>
            public string City { get; set; }

            ///<Summary>
            /// District
            ///</Summary>
            public string District { get; set; }

            ///<Summary>
            /// State
            ///</Summary>
            public string State { get; set; }

            ///<Summary>
            /// Zip
            ///</Summary>
            public string Zip { get; set; }
        }
        public class Country
        {
            ///<Summary>
            /// Country Id
            ///</Summary>
            public int CountryId { get; set; }

            ///<Summary>
            /// Country Name
            ///</Summary>
            public string CountryName { get; set; }

            ///<Summary>
            /// Country ISOCode
            ///</Summary>
            public string ISOCode { get; set; }

            ///<Summary>
            /// Country Abbreviation
            ///</Summary>
            public string Abbreviation { get; set; }

            ///<Summary>
            /// Country Phone Number Region Code
            ///</Summary>
            public string RegionCode { get; set; }
        }

        
    }
}
