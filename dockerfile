# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ✅ Copy only the `.csproj` file first for caching
COPY src/SimpleDotNetService/*.csproj src/SimpleDotNetService/
WORKDIR /src/SimpleDotNetService
RUN dotnet restore

# ✅ Copy the full project source
COPY src/SimpleDotNetService/ ./
WORKDIR /src/SimpleDotNetService

# ✅ Publish the app in a separate directory to avoid permission issues
RUN dotnet publish -c Release -o /app/build --no-restore

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .

ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
