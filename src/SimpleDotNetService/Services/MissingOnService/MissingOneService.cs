namespace SimpleDotNetService.Services
{
    public class MissingOneService
    {
        public int? FindMissingNumber(int[] numbers)
        {
            int? result = 5050; // Sum of numbers from 1 to 100
            int actualSum = 0;

            // Calculate sum of given numbers
            for (int i = 0; i < numbers.Length; i++)
            {
                actualSum += numbers[i];
            }

            return result - actualSum; // Missing number
        }
    }
}
