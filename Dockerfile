#https://docs.docker.com/engine/examples/dotnetcore/
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Docker.dll"]
#_________________________________________________________________________________________________________
# FROM mcr.microsoft.com/dotnet/core/sdk
# LABEL author="Yavuz"

# ENV ASPNETCORE_URLS=http://+:80
# ENV ASPNETCORE_ENVIRONMENT = development

# WORKDIR /app

# COPY . .

# EXPOSE 80

# ENTRYPOINT ["/bin/bash","-c","dotnet restore && dotnet run"]

#_________________________________________________________________________________________________________
#Dev dockerfile Example
#
#FROM mcr.microsoft.com/dotnet/core/sdk
#LABEL author="Yavuz"
#
#ENV ASPNETCORE_URLS=http://+:5000
#ENV DOTNET_USE_POLLING_FILE_WATCHER = 1
#ENV ASPNETCORE_ENVIRONMENT = development
#
#EXPOSE 5000
#WORKDIR /var/www/app
#
#CMD["dotnet restore && dotnet build && dotnet watch run"]
#_________________________________________________________________________________________________________
#Production Dockerfile Example:
#
#FROM mcr.microsoft.com/dotnet/core/aspnet
#LABEL author="Yavuz"
#
#ENV ASPNETCORE_URLS=http://+:5000
#ENV ASPNETCORE_ENVIRONMENT = production
#
#WORKDIR /app
#COPY ./dist/app
#
#ENTRYPOINT["dotnet","ASPNET-Core-And-Docker.dll"]
#_________________________________________________________________________________________________________
#Dockerfile ozetle 2 ana bolumden olusur. 
#Birincisi uygulamayi build etme ikincisi ise uygulamayi run etme bolumleridir. 
#Dosya icerisindeki komutlarin ne olduguna bakacak olursak;
#
#FROM; hangi docker image'i kullanılacagına belirttigimiz komut. 
#WORKDIR; image icerisinde working directory olarak kullanacagimiz yeri belirttigimiz komut. 
#COPY; proje dosyalarini local file system'dan image'e kopyalamak icin kullanilan komuttur. 
#ENTRYPOINT; container ayaga kaldirilirken ilk olarak calisacak olan komut ve parametreleri belirttigimiz komuttur. Container run edilirken dotnet komutuyla HelloDocker.dll'i execute edilecektir.
#CMD; ENTRYPOINT gibi verilen komutlari calistirir. 
#dotnet-watch; Kodda degisiklik oldugu zaman Kestrel Server otomatik restartlar
#_________________________________________________________________________________________________________
#Production Build
#dotnet CLI:
#
#dotnet publish -c Release -o dist
#
#Release; Set build configuration
#dist; Outpur folder
#_________________________________________________________________________________________________________
#Creating/Building a Custom Image
#
#docker build -t denemebuild:1.0 .
#
#-t; Tag
#denemebuild; ImageName
#1.0.0; Tag name, tag name'in bu sekilde verilmesi rollback icin kullanislidir
#.; Build Context, sondaki nokta docket file dosyanin oldu yeri gosterir.Nokta koyulursa bulundugu klasorde arar.
#_________________________________________________________________________________________________________
#Deploy/Running a Custom Container
#
#docker run -d --name dotnet -p 5000:5000 danwahlin/dotnet:1.0
#
#dotnet; Container name
#5000:5000; Port 80:80 gibi
#danwahlin/dotnet:1.0; image name
#_________________________________________________________________________________________________________
# Özet docker Komutları
#
# docker image ls ; Imageleri Listeler
# docker container ls ; Tüm Containerları listeler
# docker ps ; Çalışan containerları listeler 
# docker container stop container_Name ; container stop 
# docker container rm container_Name ; container sil
# docker build -t imageName:tag . ; Image Olusturur
# docker run --name container_Name -p 8080:80 imageName:Tag ; container oluşturur 
# Https için container :
# docker run --name container_Name -p 8080:80 -p 8081:443(443 https için) 
#     -e ASPNETCORE_URLS="https://+;http://+" 
#     -e ASPNETCORE_HTTPS_PORT=8081 
#     -e ASPNETCORE_ENVIRONMENT=Development 
#     -v $env:APPDATA\microsoft\UserSecrets\:/root/.microsoft/usersecrets 
#     -v $env:USERPROFILE\.aspnet\https:/root/.aspnet/https 
#     imageName:Tag
# docker rmi image_id ; Image sil
