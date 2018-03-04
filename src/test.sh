#!/bin/sh

cp music_34comical.win32.scd music_34comical.win32.scd-test

#xxd -p -l 4 -s 168 music_34comical.win32.scd-test | xxd -l 4 -s 168 music_34comical.win32.scd-test

echo "00000A8: 3108 2C3F" | xxd -r - music_34comical.win32.scd-test

echo ""

xxd -l 200 music_34comical.win32.scd-test

xxd music_34comical.win32.scd > orig.hex
xxd music_34comical.win32.scd-test > test.hex

echo ""

diff orig.hex test.hex

rm orig.hex
rm test.hex