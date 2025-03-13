using SimpleDotNetService.Services;
using SimpleDotNetService.Models;


var builder = WebApplication.CreateBuilder(args);

// Register FizzBuzzService
builder.Services.AddScoped<IFizzBuzzService, FizzBuzzService>();

var app = builder.Build();

app.UseHttpsRedirection();

// interface IFizzBuzzService
app.MapGet("/fizzbuzz/{number}", (int number, IFizzBuzzService fizzBuzzService) =>
{
    var result = fizzBuzzService.ProcessNumber(number);
    return string.IsNullOrEmpty(result) ? Results.NoContent() : Results.Ok(result);
});

app.MapPost("/fizzbuzz", (FizzBuzzRequest request, IFizzBuzzService fizzBuzzService) =>
{
    var result = fizzBuzzService.ProcessNumber(request.Number);
    return string.IsNullOrEmpty(result) ? Results.NoContent() : Results.Ok(result);
});

app.Run();
