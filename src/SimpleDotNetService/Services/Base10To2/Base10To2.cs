using SimpleDotNetService.Models;

namespace SimpleDotNetService.Services
{
    public class Base10To2 : IBase10To2
    {
        public string ConvertBase10To2(RequestInt postObj)
        {
            
            string result = string.Empty;
            int input = postObj.InputInt;
            if (input == 0) 
            {
                return "0";
            }

            while(input > 0)
            {
                int currentVal = input % 2;
                result = currentVal + result; 
                input = input / 2;

            }
            return result;
        }
    }
}
