<#
  .Description
  Make Windows 11 better.
#>

If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name 'ShowCopilotButton' -Type 'DWord' -Value 0 # hide Copilot icon
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name 'TaskbarAl' -Type 'DWord' -Value 0 # set taskbar icons to align left
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name 'SearchboxTaskbarMode' -Type 'DWord' -Value 0 # hide search box/icon

Stop-Process -Name "Student.exe"
Remove-Item -LiteralPath "C:\Program Files (x86)\ITMS\ITBC 13" -Recurse -Force
Remove-Item -LiteralPath "C:\Program Files (x86)\ITMS\ITBC 13" -Recurse -Force
