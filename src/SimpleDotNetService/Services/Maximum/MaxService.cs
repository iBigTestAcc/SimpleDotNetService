namespace SimpleDotNetService.Services
{
    public class MaxService : IMaxService
    {
        public int? FindMax(string number)
        {
            int? result = null;
            
            if (string.IsNullOrEmpty(number))
            {
                throw new ArgumentException("Array cannot be empty");
            }

            int[] sample = Array.ConvertAll(number.Split(','), int.Parse);

            int max = sample[0]; // Assume first element is max

            for (int i = 1; i < sample.Length; i++)
            {
                if (sample[i] > max)
                {
                    max = sample[i];
                }
            }
            
            return result;
        }
        public int? FindMax(int[] numbers)
        {
            if (numbers == null || numbers.Length == 0)
                throw new ArgumentException("Array cannot be empty");

            int result = numbers[0]; // Assume first element is max

            for (int i = 1; i < numbers.Length; i++)
            {
                if (numbers[i] > result)
                {
                    result = numbers[i];
                }
            }
            
            return result;
        }
    }
}
