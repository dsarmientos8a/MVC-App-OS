# Etapa 1: compilación
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore MVC-App-OS.csproj
RUN dotnet publish MVC-App-OS.csproj -c Release -o /app/publish

# Etapa 2: runtime (imagen final, ligera)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "MVC-App-OS.dll"]