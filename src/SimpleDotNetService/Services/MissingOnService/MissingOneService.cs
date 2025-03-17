using SimpleDotNetService.Models;
namespace SimpleDotNetService.Services
{
    public class MissingOneService : IMissingOneService
    {
        public int FindMissingNumber(RequestIntArray inputObj)
        {
            int result = 5050; // Sum of numbers from 1 to 100
            int actualSum = 0;

            // Calculate sum of given numbers
            for (int i = 0; i < inputObj.InputIntArray.Length; i++)
            {
                actualSum += inputObj.InputIntArray[i];
            }

            return result - actualSum; // Missing number
        }
    }
}
