<#
  .Description
  fix my school's garbage Windows 11
#>

# Become administrator
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

# Fix taskbar
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowCopilotButton' -Type 'DWord' -Value 0 # Hide Copilot icon
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAl' -Type 'DWord' -Value 0 # set taskbar icons to align left
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type 'DWord' -Value 0 # hide search box/icon

# Clean up useless garbage
Stop-Process -Name 'Student.exe'
Stop-Process -Name 'OAT.exe'
Stop-Process -Name 'oatservice.exe'
Stop-Process -Name 'Loader.exe'
Remove-Item -LiteralPath 'C:\Program Files (x86)\ITMS\ITBC 13' -Recurse -Force
Remove-Item -LiteralPath 'C:\Program Files (x86)\ITMS\ITBC 13' -Recurse -Force

# Change wallpaper
curl -o C:\wallpaper.png https://stsci-opo.org/STScI-01GA6KNV1S3TP2JBPCDT8G826T.png
Set-ItemProperty -Path "HKCU:Control Panel\Desktop" -Name WallPaper -Type 'String' -Value 'C:\wallpaper.png'
rundll32.exe user32.dll, UpdatePerUserSystemParameters
