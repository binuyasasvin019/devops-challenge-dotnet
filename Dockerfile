# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire src directory (all csproj and source files)
COPY src/ ./src/

# Restore NuGet packages for all projects
RUN dotnet restore src/DevOpsChallenge.SalesApi/DevOpsChallenge.SalesApi.csproj

# Build and publish the API project
RUN dotnet publish src/DevOpsChallenge.SalesApi/DevOpsChallenge.SalesApi.csproj --configuration Release --output /app/publish

# Use the official .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final

# Set the working directory inside the container
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /app/publish .

# Expose the port that the app will run on (adjust as needed)
EXPOSE 80

# Define the entry point for the API project
CMD ["dotnet", "DevOpsChallenge.SalesApi.dll"]