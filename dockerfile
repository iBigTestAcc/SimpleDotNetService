# Use official .NET runtime as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# ✅ Create a non-root user to avoid permission issues
RUN useradd -m builduser
USER builduser

# Copy project file separately to leverage caching
COPY --chown=builduser ["SimpleDotNetService/SimpleDotNetService.csproj", "SimpleDotNetService/"]
WORKDIR /src/SimpleDotNetService
RUN dotnet restore

# Copy everything else into the container
COPY --chown=builduser . .

# ✅ Run build as non-root user in an isolated environment
RUN dotnet publish SimpleDotNetService.csproj -c Release -o /app/publish --no-restore

# Use the final runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SimpleDotNetService.dll"]
