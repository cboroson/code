# Reads json configuration file and creates environment variables for each entry

param (
    [string]$configFile
)

$config = (get-content $configFile | convertFrom-json)
foreach ($Line in $config.PSObject.Properties) {

  $EnvVarName = "VOD_$($Line.Name)"
  $EnvVarValue = $Line.Value

  # Test if environment variable already exists
  if (Test-Path Env:$EnvVarName) {
    # Update existing environment variable
    write-output "Setting existing environment variable $EnvVarName with a value of $EnvVarValue"
    #Set-Item -path Env:$EnvVarName -Value $EnvVarValue #| out-null
    Write-output $EnvVarName=$EnvVarValue | out-file $GITHUB_ENV -append
  }
  else {
    # Create new environment variable
    write-output "Adding new environment variable $EnvVarName with a value of $EnvVarValue"
    #New-Item -Path Env:$EnvVarName -Value $EnvVarValue #| out-null
    Write-output $EnvVarName=$EnvVarValue | out-file $GITHUB_ENV -append

  }

}

#dir env:
Write-Output "GitHub_ENV = $GITHUB_ENV"
cat $GITHUB_ENV
