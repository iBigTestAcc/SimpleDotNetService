# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file separately to leverage caching
COPY ["SimpleDotNetService.csproj", "./"]
RUN dotnet restore

# Copy everything else and move to a clean build directory
COPY . .

# ✅ Use a completely separate directory for the build process
WORKDIR /src/build
RUN dotnet publish /src/SimpleDotNetService.csproj -c Release -o /src/build/out

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /src/build/out .
ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
