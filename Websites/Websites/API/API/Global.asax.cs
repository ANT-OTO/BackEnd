using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace API
{
    public class WebApiApplication : System.Web.HttpApplication
    {
#pragma warning disable CS1591 // Missing XML comment for publicly visible type or member
        protected void Application_Start()
#pragma warning restore CS1591 // Missing XML comment for publicly visible type or member
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //if (System.Configuration.ConfigurationManager.AppSettings["JSONP"] == "Y")
            //{
            //    FormatterConfig.RegisterFormatters(GlobalConfiguration.Configuration.Formatters);
            //}

            var json = GlobalConfiguration.Configuration.Formatters.JsonFormatter;

            json.SerializerSettings.NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore;
            //json.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Serialize;
            //json.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.All;


            GlobalConfiguration.Configuration.Formatters.Remove(GlobalConfiguration.Configuration.Formatters.XmlFormatter);

       
            /*
             * json.SerializerSettings.Culture = new CultureInfo("it-IT");
             * json.SerializerSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Utc;
             * json.SerializerSettings.DateFormatHandling = Newtonsoft.Json.DateFormatHandling.MicrosoftDateFormat;
             * json.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
             * json.SerializerSettings.Formatting = Newtonsoft.Json.Formatting.Indented;
             * 
             * */


        }
    }
}
