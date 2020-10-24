# aws-cli-mfa-powershell
PowerShell Script for AWS CLI Multi Factor Authentication (MFA)

# Sign-in MFA user from AWS Cli

* Open aws-mfa.ps1
* Add your MFA device ARM
* Save the file.
* Open the Powershell in admin mode 
* Open your Auth App for AWS and get the MFA token
* run .\aws-mfa.ps1 {token} (for example: .\aws-mfa.ps1 120345 )
* if it's success, it will show the token expire. 
   * Close the Powershell and re-open it to use the AWS Cli.. **** Closing the console is important.. because we are setting the envs so need to refresh. If you have a better way, let me know.
* If you get the error, use aws-clean-env.ps1.

# Clean AWS Environment Varaibles 

Once the token is expired but the old token is still in your AWS env vars so you will get the "expired token" error when you try to run the AWS Cli or try to resign again. So we need to clean the AWS ENV first before we sign-in.

* Open the Powershell in admin mode 
* run .\aws-clean-env.ps1