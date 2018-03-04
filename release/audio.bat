@ECHO %off

REM Location of extracted audio to change
SET DIR=white_scru/sound/pack/8000/usa

REM Check that filelist_scru.win32.bin exists
IF NOT EXIST filelist_scru.win32.bin (
	ECHO Missing file: filelist_scru.win32.bin
	PAUSE
	EXIT
)

REM Check that white_scru.win32.bin exists
IF NOT EXIST white_scru.win32.bin (
	ECHO Missing file: white_scru.win32.bin
	PAUSE
	EXIT
)

REM Ask user for the gain they would like to set
SET /p GAIN="Enter Gain: "

REM Decrypt
ffxiiicrypt -d filelist_scru.win32.bin 2
PAUSE

REM Extract
ff13tool -x -ff132 filelist_scru.win32.bin white_scru.win32.bin
PAUSE

REM Convert Audio
FOR %%f IN (%DIR%/*) DO (
	ECHO converting %%f
	FOR /F "tokens=*" %%g IN ('xxd.exe -p -l 4 -s 168 %DIR%/%%f') DO (
		FOR /F "tokens=*" %%v IN ('convert.exe %%g %GAIN%') DO (
			ECHO %%v | xxd.exe -r - %DIR%/%%f
		)
	)
)

PAUSE

REM Repack
ff13tool -c -ff132 filelist_scru.win32.bin white_scru
PAUSE

REM Encrypt
ffxiiicrypt -e filelist_scru.win32.bin 2
PAUSE

REM Wipe the temp dir that was extracted
ECHO Removing temp files
DEL /s /q white_scru
PAUSE