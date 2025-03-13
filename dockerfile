# Use official .NET SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ✅ Copy entire `src` folder while maintaining correct structure
COPY src/ /src/

# ✅ Verify files are copied
RUN ls -R /src

# ✅ Move inside the correct project directory
WORKDIR /src/SimpleDotNetService

# ✅ Ensure the correct project file is found
RUN if [ ! -f "SimpleDotNetService.csproj" ]; then echo "❌ Project file is missing!"; exit 1; fi

# ✅ Restore dependencies
RUN dotnet restore SimpleDotNetService.csproj

# ✅ Publish the app in a separate directory
RUN dotnet publish -c Release -o /app/build --no-restore

# Use a runtime image for final execution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/build .

ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
