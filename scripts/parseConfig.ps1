# Reads json configuration file and creates environment variables for each entry

param (
    [string]$configFile
)

$config = (get-content $configFile | convertFrom-json)
foreach ($Line in $config.PSObject.Properties) {

  $EnvVarName = "VOD_$($Line.Name)"
  $EnvVarValue = $Line.Value

  # Display output for happiness
  write-output "Adding environment value name $EnvVarName with a value of $EnvVarValue"

  # Test if environment variable already exists
  if (Test-Path Env:$EnvVarName) {
    # Update existing environment variable
    Set-Item -path Env:$EnvVarName -Value $EnvVarValue | out-null
  }
  else {
    # Create new environment variable
    New-Item -Path Env:$EnvVarName -Value $EnvVarValue | out-null
  }

}
