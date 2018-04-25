using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Net.Http.Formatting;
using System.Web;
using System.Web.Optimization;
using WebApiContrib.Formatting.Jsonp;

namespace API
{
    public class FormatterConfig
    {
        public static void RegisterFormatters(MediaTypeFormatterCollection formatters)
        {
            //var jsonFormatter = formatters.JsonFormatter;
            //jsonFormatter.SerializerSettings = new JsonSerializerSettings
            //{
            //    ContractResolver = new CamelCasePropertyNamesContractResolver()
            //};
            //// Insert the JSONP formatter in front of the standard JSON formatter.
            //var jsonpFormatter = new JsonpMediaTypeFormatter(formatters.JsonFormatter);
            //formatters.Insert(0, jsonpFormatter);
            formatters.JsonFormatter.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Serialize;
            formatters.JsonFormatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;

        }
    }
}
