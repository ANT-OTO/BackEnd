using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class ANTTools
    {
        public static void importCategoryList(string input)
        {
            List<Category> item = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Category>>(input);
            
        }
        public class Category
        {
            public string title { get; set; }
            public string link { get; set; }
            public List<string> brand { get; set; }
            public List<Category> childrenList { get; set; }
        }
    }
}
