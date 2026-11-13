$deployPath = "C:\FastAPI-Production"

New-Item -ItemType Directory -Force -Path $deployPath

Copy-Item -Path "app" -Destination $deployPath -Recurse -Force
Copy-Item -Path "requirements.txt" -Destination $deployPath -Force

$venvPython = "$deployPath\venv\Scripts\python.exe"

if (!(Test-Path $venvPython)) {
    python -m venv "$deployPath\venv"
}

& $venvPython -m pip install -r "$deployPath\requirements.txt"

$pidFile = "$deployPath\app.pid"

if (Test-Path $pidFile) {

    $oldPid = Get-Content $pidFile

    Stop-Process -Id $oldPid -Force -ErrorAction SilentlyContinue

    Remove-Item $pidFile
}

$process = Start-Process `
    -FilePath $venvPython `
    -ArgumentList "-m uvicorn app.main:app --host 127.0.0.1 --port 8000" `
    -WorkingDirectory $deployPath `
    -PassThru `
    -WindowStyle Hidden

$process.Id | Set-Content $pidFile

Write-Host "FastAPI deployment completed!"