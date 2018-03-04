FOR /F "tokens=*" %%g IN ('xxd -p -l 4 -s 168 music_34comical.win32.scd') DO (
    FOR /F "tokens=*" %%v IN ('convert.exe %%g 0.2') DO (
        echo %%v | xxd -r - music_34comical.win32.scd-test
    )
)