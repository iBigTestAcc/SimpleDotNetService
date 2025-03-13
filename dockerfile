# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ✅ Copy the project file and restore dependencies
COPY ["SimpleDotNetService/SimpleDotNetService/SimpleDotNetService.csproj", "SimpleDotNetService/"]
WORKDIR /src/SimpleDotNetService
RUN dotnet restore

# ✅ Copy the full project source
COPY SimpleDotNetService/SimpleDotNetService/. SimpleDotNetService/
WORKDIR /src/SimpleDotNetService

# ✅ Ensure the build happens in a clean directory
RUN dotnet publish -c Release -o /app/build --no-restore

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .

ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
