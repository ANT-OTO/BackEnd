using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ANTOTOLib;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Please enter a password to use:");
            string password = Console.ReadLine();
            Console.WriteLine("Please enter a string to encrypt:");
            string plaintext = Console.ReadLine();
            Console.WriteLine("");

            Console.WriteLine("Your encrypted string is:");
            string encryptedstring = StringCipher.Encrypt(plaintext, password);
            Console.WriteLine(encryptedstring);
            Console.WriteLine("");

            


            //Console.WriteLine("Please enter a password to use:");
            //password = Console.ReadLine();
            //Console.WriteLine("Please enter a string to encrypt:");
            //plaintext = Console.ReadLine();
            //Console.WriteLine("");

            Console.WriteLine("Your encrypted string1 is:");
            string encryptedstring1 = StringCipher.Encrypt(plaintext, password);
            Console.WriteLine(encryptedstring1);
            Console.WriteLine("");



            
            Console.WriteLine("Your decrypted string1 is:");
            string decryptedstring1 = StringCipher.Decrypt(encryptedstring, password);
            Console.WriteLine(decryptedstring1);
            Console.WriteLine("");

            Console.WriteLine("Your decrypted string is:");
            string decryptedstring = StringCipher.Decrypt(encryptedstring, password);
            Console.WriteLine(decryptedstring);
            Console.WriteLine("");

            Console.WriteLine("Press any key to exit...");
            Console.ReadLine();
        }
    }
}
