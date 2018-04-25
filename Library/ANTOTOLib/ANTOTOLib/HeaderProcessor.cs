using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Http;


namespace ANTOTOLib
{
    public class HeaderProcessor
    {

        /// <summary>
        /// Read Header Value from the Request Header
        /// </summary>
        /// <param name="pRequest"></param>
        /// <param name="pHeaderName"></param>
        /// <returns></returns>
        public static string ReadValueFromHeader(HttpRequestMessage pRequest, string pHeaderName)
        {
            string result = string.Empty;
            try
            {
                IEnumerable<string> headerValues;
                var keyFound = pRequest.Headers.TryGetValues(pHeaderName, out headerValues);
                if (keyFound)
                {
                    result = headerValues.FirstOrDefault();
                }
                else
                {
                    var list = pRequest.GetQueryNameValuePairs();
                    foreach (var item in list)
                    {
                        if (item.Key == pHeaderName)
                        {
                            result = item.Value;
                            break;
                        }
                    }
                }
            }
            catch
            {
                result = string.Empty;
            }
            return result;
        }


        /// <summary>
        /// Get Core URL
        /// </summary>
        /// <param name="pRequest"></param>
        /// <returns></returns>
        public static string GetCoreURL(HttpRequestMessage pRequest)
        {
            string result = string.Empty;
            try
            {
                string URL = pRequest.RequestUri.AbsoluteUri;


                int Pos = URL.IndexOf("/", 8);

                result = URL.Substring(0, Pos + 1);

            }
            catch
            {
                result = string.Empty;
            }
            return result;
        }

        /// <summary>
        /// Get Folder
        /// </summary>
        /// <param name="pRequest"></param>
        /// <returns></returns>
        public static string GetAPIFolder(HttpRequestMessage pRequest)
        {
            string result = string.Empty;
            try
            {
                string URL = pRequest.RequestUri.AbsoluteUri;
                int Pos = URL.IndexOf("/Provider", 8);

                result = URL.Substring(0, Pos + 1);
            }
            catch
            {
                result = string.Empty;
            }
            return result;
        }
    }

}