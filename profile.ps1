function Create-Case {
	param(
		[Parameter(Mandatory=$true)]
		[string] $Casenumber
	)
	
	Write-Output "casenum: $Casenumber"

	$root = New-Item -Path ".\$Casenumber" -ItemType Directory
	New-Item -Path "$root\_images" -ItemType Directory

	$index = New-Item -Path "$root\case.md" -ItemType File
	
	Add-Content $index @"
# Case-$Casenumber
[link to case](https://goto.netcompany.com/cases/GTE809/SLVNDP/Lists/Tasks/DispForm.aspx?ID=$Casenumber)

## Notes

## Writeup

"@

	Invoke-Expression -Command "nvim $root/case.md"
}

function Open-Case {
	param (
		[Parameter(Mandatory=$true)]
		[string] $Casenumber
	)
	Start-Process "https://goto.netcompany.com/cases/GTE809/SLVNDP/Lists/Tasks/DispForm.aspx?ID=$Casenumber"
}
