using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace API
{
    /// <summary>
    /// WebAPIConfig
    /// </summary>
    public static class WebApiConfig
    {
        /// <summary>
        /// Register
        /// </summary>
        /// <param name="config"></param>
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Cross Origin Requests
            config.EnableCors();

            // Web API routes
            config.MapHttpAttributeRoutes();

            if (System.Configuration.ConfigurationManager.AppSettings["JSONP"] == "Y")
            {
                config.Routes.MapHttpRoute(
                    name: "DefaultApi",
                    routeTemplate: "{controller}/{id}/{format}",
                    defaults: new { id = RouteParameter.Optional, format = RouteParameter.Optional }
                );

            }
            else
            {
                config.Routes.MapHttpRoute(
                    name: "DefaultApi",
                    routeTemplate: "{controller}/{id}",
                    defaults: new { id = RouteParameter.Optional }
                );
            }
        }
    }
}
