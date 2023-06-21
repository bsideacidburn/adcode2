$PASSWORD_FOR_USERS    = "password@123"
$USER_FIRST_LAST_LIST  = Get-Content .\users.txt

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
New -ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false

foreach ($n in $USER_FIRST_LAST_LIST) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()

    Write-Host "Creating user: $($username)" -BackgroundColor Black -Foreground Color Cyan

    New-AdUser -AccountPassword $password `
                -GivenName $first `
                -Surname $last `
                -DisplayName $username `
                -Name $username `
                -EmployeeID $username `
                -PasswordNeverExpires $true `
                -Path "ou=_USERS,$((ADSI`"")).disinguishedName)" `
                -Enabled $true
}