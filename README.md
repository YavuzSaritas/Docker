# Docker

## Docker Command

```bash
docker image ls     ===========================================> All Image List
docker container ls ===========================================> All Container List
docker ps =====================================================> Active Container List
docker container stop [container_Name] ========================> Container Stop 
docker rmi [image_id] =========================================> Remove Image
docker container rm [container_Name] ==========================> Remove Container
docker build -t [imageName:tag] . =============================> Create Image
docker run --name [container_Name] -p 8080:80 [imageName:Tag] => Create Container

##### Create Container Allow via HTTPS Command #####
docker run --name [container_Name] -p 8080:80 -p 8081:443(443 for https) 
    -e ASPNETCORE_URLS="https://+;http://+" 
    -e ASPNETCORE_HTTPS_PORT=8081 
    -e ASPNETCORE_ENVIRONMENT=Development 
    -v $env:APPDATA\microsoft\UserSecrets\:/root/.microsoft/usersecrets 
    -v $env:USERPROFILE\.aspnet\https:/root/.aspnet/https 
    [imageName:Tag]

```

## Certificate
### Create Certificate For Localhost
```bash
(Run this command in PowerShell)
dotnet dev-certs https -ep $env:USERPROFILE\.aspnet\https\Docker.pfx -p pa55w0rd!
dotnet dev-certs https --trust
C:\Users\yavuz.saritas\.aspnet\https\Docker.pfx (Sertificate File)
```
### Create Password For UserSecret Into Docker.csproj File
```bash
(Run this command after entering the project folder in PowerShell)
dotnet user-secrets set "Kestrel:Certificates:Development:Password" "pa55w0rd!"
C:\Users\yavuz.saritas\AppData\Roaming\Microsoft\UserSecrets\S03E05-f426967a-c5cf-4d9f-b3ba-ba1709a3c45c\Secret.json (Password File) 
```

