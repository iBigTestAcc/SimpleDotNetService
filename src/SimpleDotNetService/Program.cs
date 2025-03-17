using Microsoft.OpenApi.Models;
using SimpleDotNetService.Services;
using SimpleDotNetService.Models;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddEndpointsApiExplorer(); // Enables API Explorer
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "SimpleDotNetService API",
        Version = "v1",
        Description = "A simple Web API with Swagger documentation."
    });
});

//> Register
// FizzBuzzService
builder.Services.AddScoped<IFizzBuzzService, FizzBuzzService>();

// MaxService
builder.Services.AddScoped<IMaxService, MaxService>();

// MissingOneService
builder.Services.AddScoped<IMissingOneService, MissingOneService>();

// Base2To10
builder.Services.AddScoped<IBase2To10, Base2To10>();

// Base10To2
builder.Services.AddScoped<IBase10To2, Base10To2>();
//< Register

var app = builder.Build();

// Enable Swagger in development and production
app.UseSwagger();
app.UseSwaggerUI(options =>
{
    options.SwaggerEndpoint("/swagger/v1/swagger.json", "SimpleDotNetService API v1");
    options.RoutePrefix = ""; // Set as root to open Swagger UI by default
});

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

// interface IMaxService
app.MapGet("/max/{string}", (string number, IMaxService maxService) =>
{
    var result = maxService.FindMax(number);
    return result.HasValue ? Results.Ok(result.Value) : Results.NoContent();
});

app.MapPost("/max", (RequestObj request, IMaxService maxService) =>
{
    var result = maxService.FindMax(request);
    return result.HasValue ? Results.Ok(result.Value) : Results.NoContent();
});

app.MapPost("/missing", (int[] request, IMissingOneService missingService) =>
{
    if (request == null || request.Length != 99)
        return Results.BadRequest("Array must contain exactly 99 elements.");

    var missingNumber = missingService.FindMissingNumber(request);
    return Results.Ok(missingNumber);
});

app.MapPost("/base2To10", (Base2To10Request request, IBase2To10 Base2To10) =>
{
    if (request == null)
        return Results.BadRequest("Array must contain exactly 99 elements.");

    var missingNumber = Base2To10.ConvertBase2To10(request);
    return Results.Ok(missingNumber);
});

app.MapPost("/base10To2", (Base10To2Request request, IBase10To2 Base10To2) =>
{
    if (request == null)
        return Results.BadRequest("Array must contain exactly 99 elements.");

    var missingNumber = Base10To2.ConvertBase10To2(request);
    return Results.Ok(missingNumber);
});

app.Run();
