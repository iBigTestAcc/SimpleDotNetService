# Use official .NET runtime as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files
COPY ["SimpleDotNetService.csproj", "./"]
RUN dotnet restore "SimpleDotNetService.csproj"

# Copy everything else and set correct permissions
COPY . .
RUN chmod -R 777 /src  # Give full access before building
RUN dotnet publish -c Release -o /app/publish

# Final stage - run the application
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
