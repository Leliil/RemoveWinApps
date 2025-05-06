# Скрипт для развертывания через групповые политики
$SourcePath = "\\network\share\RemoveApps.bat"
$DestPath = "C:\IT\RemoveApps.bat"

if (-not (Test-Path "C:\IT")) {
    New-Item -ItemType Directory -Path "C:\IT" | Out-Null
}

Copy-Item -Path $SourcePath -Destination $DestPath -Force

# Создание задачи в планировщике
$Action = New-ScheduledTaskAction -Execute "$DestPath" -Argument "/silent"
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd

Register-ScheduledTask `
    -TaskName "Remove Built-in Apps" `
    -Action $Action `
    -Trigger $Trigger `
    -Settings $Settings `
    -RunLevel "Highest" `
    -Force
