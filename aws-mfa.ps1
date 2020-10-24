# Credit: https://community.spiceworks.com/scripts/show/4594-aws-command-line-mfa-access-powershell

$mfaCode = $args[0]

$mfaSerialNumber = "## Add your Device ARN here... Not your ARN.. Your MFA Device ARN ##"

$errorMessage = "There is an error. If you are getting 'session expired' error, pleaes try to run aws-clean-env.ps1 to clear the AWS credential in the elevated mode."

try{
	
	$sessionInfo = aws sts get-session-token --serial-number $($mfaSerialNumber) --token-code $($mfaCode) | ConvertFrom-Json
	
	if( $LASTEXITCODE -eq 0 ) {
		 [System.Environment]::SetEnvironmentVariable('AWS_SESSION_TOKEN', $($sessionInfo.Credentials.SessionToken),[System.EnvironmentVariableTarget]::Machine)
	 [System.Environment]::SetEnvironmentVariable('AWS_ACCESS_KEY_ID', $($sessionInfo.Credentials.AccessKeyID),[System.EnvironmentVariableTarget]::Machine)
	 [System.Environment]::SetEnvironmentVariable('AWS_SECRET_ACCESS_KEY', $($sessionInfo.Credentials.SecretAccessKey),[System.EnvironmentVariableTarget]::Machine) 
	 
	 Write-host "Your authentication credentials have now been updated `r`nYour new access-key-id is: $($sessionInfo.Credentials.AccessKeyID)`r`nYour new session token will expire: $($sessionInfo.Credentials.Expiration)`r`nPlease close and reopen the console before using the AWS CLI."
	
	} 
	else {
		Write-Output $errorMessage
	}

	
}	
catch{$errorMessage}
	