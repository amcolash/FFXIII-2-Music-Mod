default: convert.exe

test: convert.exe
	cmd /C test.bat

run: convert.exe
	cmd /C convert.exe 3d0a573f 0.2

convert.exe: convert.c
	x86_64-w64-mingw32-gcc convert.c -o convert.exe

clean:
	rm -f convert.exe
