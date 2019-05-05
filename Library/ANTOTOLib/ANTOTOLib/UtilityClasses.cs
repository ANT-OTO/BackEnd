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
            public string Number { get; set; }
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

        public class ShippingAddress
        {
            public Address AddressDetail { get; set; }
            public string ContactPersonFirstName { get; set; }
            public string ContactPersonLastName { get; set; }
            public string ContactPersonPhoneNumber { get; set; }
            public int? ContactPersonPhoneNumberCountryId { get; set; }
            public bool? DefaultShipping { get; set; }
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

        public class SystemLanguage
        {
            public int? SystemLanguageId { get; set; }
            public string DisplayName { get; set; }
        }

        public static List<tfnCountryListGetResult> getCountryList(int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCountryListGet(SystemLanguageId);
            List<tfnCountryListGetResult> result = new List<tfnCountryListGetResult>();
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.Add(item);
                }
            }
            return result;
        }

        public static tfnCountryListGetResult getCountryFromId(int? CountryId, int? SystemLanguageId)
        {
            tfnCountryListGetResult result = new tfnCountryListGetResult();
            var CountryList = getCountryList(SystemLanguageId.Value);
            if (CountryList != null)
            {
                foreach(var Country in CountryList)
                {
                    if(Country.CountryId == CountryId)
                    {
                        result = Country;
                        break;
                    }
                }
            }
            return result;
        }

        public static List<tfnSystemLanguageListGetResult> getSystemLanguageList()
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnSystemLanguageListGet();
            List<tfnSystemLanguageListGetResult> result = new List<tfnSystemLanguageListGetResult>();
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.Add(item);
                }
            }
            return result;
        }
        
        public class Currency
        {
            public string CurrencyName { get; set; }
            public int CurrencyId { get; set; }
            public string CurrencyCode { get; set; }
            public string CurrencySymbol { get; set; }
        }

        public static List<Currency> getCurrencyList(int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCurrencyListGet(pSystemLanguageId);
            List<Currency> result = new List<Currency>();
            if (list != null && list.Count() > 0)
            {
                foreach(var item in list)
                {
                    Currency temp = new Currency();
                    temp.CurrencyId = item.CurrencyId;
                    temp.CurrencyCode = item.CurrencyCode;
                    temp.CurrencyName = item.CurrencyName;
                    temp.CurrencySymbol = item.CurrencySymbol;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static Currency GetCurrency(int CurrencyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCurrencyListGet(SystemLanguageId);
            Currency result = new Currency();
            if (list != null && list.Count() > 0)
            {
                foreach (var item in list)
                {
                    Currency temp = new Currency();
                    temp.CurrencyId = item.CurrencyId;
                    temp.CurrencyCode = item.CurrencyCode;
                    temp.CurrencyName = item.CurrencyName;
                    temp.CurrencySymbol = item.CurrencySymbol;
                    if(CurrencyId == item.CurrencyId)
                    {
                        result = temp;
                        break;
                    }
                }
            }
            return result;
        }
    }
}
