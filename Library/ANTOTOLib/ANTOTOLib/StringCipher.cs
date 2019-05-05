using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.Cryptography;

namespace ANTOTOLib
{
    public static class StringCipher
    {
        public static string HashPassword(string pasword)
        {
            if(pasword == null)
            {
                return "";
            }
            byte[] arrbyte = new byte[pasword.Length];

            SHA256 hash = new SHA256CryptoServiceProvider();

            arrbyte = hash.ComputeHash(Encoding.UTF8.GetBytes(pasword));

            return Convert.ToBase64String(arrbyte);

        }

}
}
