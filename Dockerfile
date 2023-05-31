FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# .csproj dosyalarını kopyala ve restore et
COPY *.csproj ./
RUN dotnet restore

# Geri kalan dosyaları kopyala ve build et
COPY . ./
RUN dotnet publish -c Release -o out

# Çalışma zamanı görüntüsünü oluştur
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "sample_app.dll"]
