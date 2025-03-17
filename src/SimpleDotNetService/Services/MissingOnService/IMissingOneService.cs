using SimpleDotNetService.Models;
namespace SimpleDotNetService.Services
{
    public interface IMissingOneService
    {
        int FindMissingNumber(RequestIntArray inputObj);
    }
}
