@echo off
echo Membuat project Flutter...
call flutter create --project-name latresmobile --platforms=android .
if errorlevel 1 goto gagal
echo Menyalin kode latres...
xcopy isi_project . /E /Y /I
rmdir /S /Q isi_project
if exist test\widget_test.dart del test\widget_test.dart
call flutter pub get
echo.
echo SELESAI. Sekarang jalankan: flutter run
goto akhir
:gagal
echo GAGAL: pastikan Flutter sudah terpasang dan perintah flutter bisa dipakai di terminal.
:akhir
pause
