namespace SimpleDotNetService.Services
{
    public class FizzBuzzService : IFizzBuzzService
    {
        public string ProcessNumber(int number)
        {
            string result = string.Empty;
            if (number % 3 == 0 && number % 5 == 0)
                result = "ab";
            else if (number % 3 == 0)
                result = "a";
            else if (number % 5 == 0)
                result = "b";
            
            return result;
        }
    }
}
