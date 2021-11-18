@echo off
setlocal ENABLEDELAYEDEXPANSION
set file=%1
set count=0
for /f "delims=" %%l in (%file%) do (
  set "line[!count!]=%%l"
  set /a count+=1
)
set /a total=count-1
:l
cls
for /l %%i in (0,1,%total%) do (
  echo %%i !line[%%i]!
)
echo.
echo.
echo Type a line number, or type SAVE or EXIT
set /p q="> "
if "%q%"=="SAVE" (
  break > %file%
  for /l %%i in (0,1,%total%) do (
    echo/!line[%%i]! >> %file%
  )
) else (
  if "%q%"=="EXIT" (
    goto EOF
  ) else (
    set "check=0"
    for /f "delims=0123456789" %%i in ("%q%") do set "check=%%i"
    if "%check%"=="0" (
      if %q% GTR %total% (
        set total=%q%
      )
      echo [ !line[%q%]!
      set /p line[%q%]="> "
    )
  )
)
goto l
:EOF