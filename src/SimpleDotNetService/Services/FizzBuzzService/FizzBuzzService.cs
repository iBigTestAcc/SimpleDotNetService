using SimpleDotNetService.Models;
namespace SimpleDotNetService.Services
{
    public class FizzBuzzService : IFizzBuzzService
    {
        public string ProcessNumber(RequestInt inputObj)
        {
            string result = string.Empty;
            if (inputObj.InputInt == 0)
            {
                result = "Out of Scope";
                return result;
            }
            if (inputObj.InputInt % 3 == 0 && inputObj.InputInt % 5 == 0)
                result = "ab";
            else if (inputObj.InputInt % 3 == 0)
                result = "a";
            else if (inputObj.InputInt % 5 == 0)
                result = "b";
            
            return result;
        }
    }
}
