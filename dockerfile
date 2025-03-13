# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files separately to leverage caching
COPY ["SimpleDotNetService.csproj", "./"]
RUN dotnet restore

# Copy the rest of the application
COPY . .

# ✅ Move build output to a separate directory to avoid permission issues
RUN dotnet publish -c Release -o /app/build --no-restore

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .

ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
