# Reads json configuration file and creates environment variables for each entry

param (
    [string]$configFile
)

$config = (get-content $configFile | convertFrom-json)
foreach ($Line in $config.PSObject.Properties) {

  $EnvVarName = "VOD_$($Line.Name)"
  $EnvVarValue = $Line.Value

  # Create new environment variable
  write-output "Adding new environment variable $EnvVarName with a value of $EnvVarValue"
  Write-output "$EnvVarName=$EnvVarValue" | out-file $ENV:GITHUB_ENV -append

}
