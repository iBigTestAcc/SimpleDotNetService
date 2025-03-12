# Use official .NET runtime as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files
COPY ["SimpleDotNetService/SimpleDotNetService.csproj", "SimpleDotNetService/"]
WORKDIR /src/SimpleDotNetService
RUN dotnet restore

# ✅ Remove old build artifacts before running publish
RUN rm -rf /src/SimpleDotNetService/bin /src/SimpleDotNetService/obj

# ✅ Reset ownership and permissions (new fix)
RUN mkdir -p /src/SimpleDotNetService/bin /src/SimpleDotNetService/obj
RUN chown -R $(whoami) /src/SimpleDotNetService/bin /src/SimpleDotNetService/obj
RUN chmod -R 777 /src/SimpleDotNetService/bin /src/SimpleDotNetService/obj

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
