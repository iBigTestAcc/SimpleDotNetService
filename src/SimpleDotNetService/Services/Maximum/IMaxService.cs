using SimpleDotNetService.Models;
namespace SimpleDotNetService.Services
{
    public interface IMaxService
    {
        int? FindMax(string number);
        int? FindMax(RequestIntArray obj);
    }
}
