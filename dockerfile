# Use official .NET runtime as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file separately to leverage caching
COPY ["SimpleDotNetService/SimpleDotNetService.csproj", "SimpleDotNetService/"]
WORKDIR /src/SimpleDotNetService
RUN dotnet restore

# Copy everything else into the container
COPY . .

# ✅ Ensure the build directory is empty
RUN rm -rf /app/build

# ✅ Specify the full path to the `.csproj` file when publishing
RUN dotnet publish /src/SimpleDotNetService/SimpleDotNetService.csproj -c Release -o /app/build

FROM base AS final
WORKDIR /app
COPY --from=build /app/build .
ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
