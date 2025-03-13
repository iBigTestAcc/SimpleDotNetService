# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ✅ Copy everything first (ensures all files are available)
COPY src/ ./src/

# ✅ Verify if `SimpleDotNetService.csproj` is copied
RUN ls -R /src

# ✅ Change working directory to the project folder
WORKDIR /src/SimpleDotNetService

# ✅ Verify if `SimpleDotNetService.csproj` is copied
RUN ls -R /src

# ✅ Check if the project file exists
RUN if [ ! -f "./SimpleDotNetService.csproj" ]; then echo "❌ Project file is missing!"; exit 1; fi

# ✅ Restore dependencies
RUN dotnet restore ./SimpleDotNetService.csproj


# ✅ Copy the entire project source again (ensuring all files exist)
COPY src/SimpleDotNetService/ ./ 

# ✅ Set working directory before publishing
WORKDIR /src/SimpleDotNetService

# ✅ Publish the app in a separate directory
RUN dotnet publish -c Release -o /app/build --no-restore

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .

ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
