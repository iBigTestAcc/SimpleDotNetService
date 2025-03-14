using System.Text.RegularExpressions;
using SimpleDotNetService.Models;

namespace SimpleDotNetService.Services
{
    public class Base2To10 : IBase2To10
    {
        public int ConvertBase2To10(Base2To10Request postObj)
        {
            int result = 0;
            int precedence = postObj.Number.Length - 1;
            for(int x = 0; x < postObj.Number.Length; x++)
            {
                if(postObj.Number[x] == '1')
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
