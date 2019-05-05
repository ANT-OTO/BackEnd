using System;
using RestSharp;
using Newtonsoft.Json;
using Microsoft.CSharp;
using System.Collections.Generic;

namespace ANTOTOLib
{
    public class UPCSearchEngine
    {
        public static object searchUPC(string UPC)
        {
            var client = new RestClient("https://api.upcitemdb.com/prod/trial/");
            // lookup request with GET
            var request = new RestRequest("lookup", Method.GET);

            request.AddQueryParameter("upc", UPC);
            IRestResponse response = client.Execute(request);
            //Console.WriteLine("response: " + response.Content);
            // parsing json
            var obj = JsonConvert.DeserializeObject(response.Content);
            return obj;
        }
        
        public class UPCLookUpResult
        {
            public string code { get; set; }
            public int? total { get; set; }
            public int? offset { get; set; }
            public List<UPCLookUpResultItem> items { get; set; }
        }

        public class UPCLookUpResultItem
        {
            public string ean { get; set; }
            public string title { get; set; }
            public string description { get; set; }
            public string upc { get; set; }
            public string brand { get; set; }
            public string model { get; set; }
            public string color { get; set; }
            public string size { get; set; }
            public string dimension { get; set; }
            public string weight { get; set; }
            public string asin { get; set; }
            public string Elid { get; set; }
        }


    }
}
