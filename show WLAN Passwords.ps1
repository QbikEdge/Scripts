# Loop, bis der Benutzer sich entscheidet zu beenden
while ($true) {
    netsh wlan show profiles | Select-String -Pattern 'Profil für alle Benutzer' | ForEach-Object {
        # SSID aus dem Profil extrahieren
        $ssid = $_ -replace 'Profil für alle Benutzer\s+:\s+'
        # Das Profil anzeigen
        Write-Host $ssid
    }
    # Benutzer nach der SSID fragen
    $ssid = Read-Host -Prompt 'Geben Sie die SSID ein, die Sie anzeigen möchten (oder "exit" zum Beenden)'

    # Überprüfen, ob der Benutzer beenden möchte
    if ($ssid -eq "exit") {
        break
    }

    # Überprüfen, ob das Profil existiert
    $profiles = netsh wlan show profiles | Select-String -Pattern $ssid

    if ($profiles -ne $null) {
        # Wenn das Profil existiert, zeigen Sie das Passwort an
        $password = netsh wlan show profile name=$ssid key=clear | Select-String -Pattern 'Schlüsselinhalt'
        Write-Host $password -ForegroundColor Green
    } else {
        # Wenn das Profil nicht existiert, informieren Sie den Benutzer
        Write-Host "Das Profil $ssid existiert nicht." -ForegroundColor Red
    }
}