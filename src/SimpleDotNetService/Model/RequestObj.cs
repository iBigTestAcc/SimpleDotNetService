namespace SimpleDotNetService.Models
{
    public class RequestObj
    {
        public string InputString { get; set; }
        public int InputNumber { get; set; }
        public int[] InputIntArray {get; set;}
    }

    public class RequestString
    {
        public string InputString { get; set; }
    }

    public class RequestInt
    {
        public int InputInt { get; set; }
    }

    public class RequestIntArray
    {
        public int[] InputIntArray { get; set; }
    }
}