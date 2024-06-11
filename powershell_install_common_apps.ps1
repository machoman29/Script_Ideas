#powershell script for installing commonly used resources for personal used
#this script is intended to be run on a fresh windows installation
#this script is intended to be run as an administrator

#list of common apps to install
#1. winget
#2. powershell
#3. git
#4. vscode
#5. docker
#6. nodejs
#7. python
#8. 7zip
#9. github desktop
Write-Output "Installing common apps"

#install winget
Invoke-WebRequest -Uri
Invoke-WebRequest -Uri 

#give prompts for each install
winget settings set global sourceName "Microsoft"
winget settings set global source "https://winget.azureedge.net/cache"

#install latest version of powershell
winget install --id=Microsoft.PowerShell -e

#install latest version of git
winget install --id=Git.Git -e

#install latest version of vscode
winget install --id=Microsoft.VisualStudioCode -e

#install latest version of docker
winget install --id=Docker.DockerDesktop -e

#install latest version of nodejs
winget install --id=OpenJS.NodeJS -e

#install latest version of python
winget install --id=Python.Python -e

#install latest version of 7zip
winget install --id=7zip.7zip -e

#install latest version of github desktop
winget install --id=GitHub.GitHubDesktop -e

