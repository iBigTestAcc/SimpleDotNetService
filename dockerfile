
# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files and restore dependencies
COPY ["SimpleDotNetService.csproj", "./"]
RUN dotnet restore

# Copy the rest of the application
COPY . .
RUN dotnet publish -c Release -o /app/out

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
