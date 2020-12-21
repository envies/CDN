@color 0A
@title RDP Port
@echo off

::	防火墙放行端口
netsh advfirewall firewall add rule name="Rdp-meto" dir=in protocol=tcp action=allow localport=3000

::	windows服务器修改远程端口
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v "PortNumber" /t REG_DWORD /d 3000 /f
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "PortNumber" /t REG_DWORD /d 3000 /f
:: 3000为端口号，修改为想要的端口号即可，需使用管理员权限cmd或pshell执行

::	重启服务：
net stop "Remote Desktop Services" && net start "Remote Desktop Services"

::	允许远程：1为允许远程，0为不允许远程
wmic RDTOGGLE WHERE ServerName='%COMPUTERNAME%' call SetAllowTSConnections 1

exit