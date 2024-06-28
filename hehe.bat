@echo off
setlocal enabledelayedexpansion

:: Create the main directory
mkdir advent-of-code-2015
if errorlevel 1 (
    echo Failed to create advent-of-code-2015 directory
    exit /b 1
)
cd advent-of-code-2015

:: Initialize the main module
go mod init github.com/urvish4503/advent-of-code/2015
if errorlevel 1 (
    echo Failed to initialize Go module
    exit /b 1
)

:: Create a template file for Go code
call :create_go_template
if errorlevel 1 (
    echo Failed to create Go template file
    exit /b 1
)

:: Loop to create 25 day projects
for /l %%i in (1,1,25) do (
    :: Create directory
    set "day=day%%i"
    if %%i lss 10 set "day=day0%%i"
    mkdir !day!
    if errorlevel 1 (
        echo Failed to create directory for !day!
        exit /b 1
    )
    
    :: Copy Go template file
    copy go_template.txt "!day!\!day!.go" > nul
    if errorlevel 1 (
        echo Failed to create !day!.go file
        exit /b 1
    )

    :: Create empty input file
    echo. > "!day!\input.txt"
    if errorlevel 1 (
        echo Failed to create input.txt for !day!
        exit /b 1
    )
    
    :: Create empty sample file
    echo. > "!day!\sample.txt"
    if errorlevel 1 (
        echo Failed to create sample.txt for !day!
        exit /b 1
    )
    
    echo Created project for !day!
)

:: Delete the template file
del go_template.txt

echo All 25 day projects have been created!

:: Verify creation
echo Verifying file creation...
for /l %%i in (1,1,25) do (
    set "day=day%%i"
    if %%i lss 10 set "day=day0%%i"
    if not exist "!day!\!day!.go" (
        echo !day!.go is missing
        exit /b 1
    )
    if not exist "!day!\input.txt" (
        echo input.txt is missing for !day!
        exit /b 1
    )
    if not exist "!day!\sample.txt" (
        echo sample.txt is missing for !day!
        exit /b 1
    )
)

echo Verification complete. All files created successfully.
exit /b 0

:create_go_template
(
echo package main
echo.
echo import (
echo     "fmt"
echo     "os"
echo ^)
echo.
echo func main(^) {
echo     input, err := os.Open(".//sample.txt"^)
echo.
echo     if err ^^^!= nil {
echo         fmt.Println("Error reading input file:", err^)
echo         return
echo     }
echo.
echo     defer input.Close(^)
echo.
echo }
) > go_template.txt
exit /b 0