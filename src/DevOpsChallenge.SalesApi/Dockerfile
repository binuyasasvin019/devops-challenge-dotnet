# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /src

COPY ["DevOpsChallenge.SalesApi/DevOpsChallenge.SalesApi.csproj", "DevOpsChallenge.SalesApi/"]
COPY ["DevOpsChallenge.SalesApi.Business/DevOpsChallenge.SalesApi.Business.csproj", "DevOpsChallenge.SalesApi.Business/"]
COPY ["DevOpsChallenge.SalesApi.Database/DevOpsChallenge.SalesApi.Database.csproj", "DevOpsChallenge.SalesApi.Database/"]

RUN dotnet restore DevOpsChallenge.SalesApi/DevOpsChallenge.SalesApi.csproj

COPY . .

RUN dotnet publish DevOpsChallenge.SalesApi/DevOpsChallenge.SalesApi.csproj --configuration Release --output /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "DevOpsChallenge.SalesApi.dll"]