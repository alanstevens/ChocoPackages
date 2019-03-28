if ((get-process "Executor" -ea SilentlyContinue) -eq $Null) { 
  Write-Host "Executor NOT running." 
} else { 
  Write-Host "Stopping Executor process..."
  Stop-Process -processname "Executor"
}