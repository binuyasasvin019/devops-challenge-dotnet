# Use the official .NET 5 SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory inside the container
WORKDIR /src

# Copy the .csproj and restore any dependencies (via restore)
COPY ["devops-challenge-dotnet/devops-challenge-dotnet.csproj", "./"]
RUN dotnet restore

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet build --configuration Release --output /app/build

# Publish the application (creating a self-contained app)
RUN dotnet publish --configuration Release --output /app/publish

# Use the official .NET 5 runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

# Copy the published app from the build container
COPY --from=build /app/publish .

# Set the entry point for the application (run the API when the container starts)
ENTRYPOINT ["dotnet", "devops-challenge-dotnet.dll"]
