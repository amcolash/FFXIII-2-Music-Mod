default: convert.exe

test: convert.exe
	cmd /C test.bat

run: convert.exe
	cmd /C convert.exe 3d0a573f 0.2

convert.exe: convert.c
	g++ convert.c -o convert.exe

clean:
	rm -f convert.exe