# Execute the following to remove the elevated persistent payload

Get-WmiObject __eventFilter -namespace root\subscription -filter "name='Updater'"| Remove-WmiObject
Get-WmiObject CommandLineEventConsumer -Namespace root\subscription -filter "name='Updater'" | Remove-WmiObject
Get-WmiObject __FilterToConsumerBinding -Namespace root\subscription | Where-Object { $_.filter -match 'Updater'} | Remove-WmiObject
            
# Execute the following to remove the user-level persistent payload
Remove-ItemProperty -Path HKCU:Software\Microsoft\Windows\CurrentVersion\Run\ -Name Updater
