using System.Text.RegularExpressions;
using SimpleDotNetService.Models;

namespace SimpleDotNetService.Services
{
    public class Base2To10 : IBase2To10
    {
        public int ConvertBase2To10(RequestString postObj)
        {
            int result = 0;
            int precedence = postObj.InputString.Length - 1;
            for(int x = 0; x < postObj.InputString.Length; x++)
            {
                if(postObj.InputString[x] == '1')
                {
                    if(precedence < 0)
                    {   
                        result = result + 1;
                    }
                    else
                    {
                        result += (int)Math.Pow(2,precedence);
                    }
                }
                precedence--;
            }
            
            return result;
        }
    }
}
