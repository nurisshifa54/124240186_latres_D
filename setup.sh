#!/bin/bash
flutter create --project-name latresmobile --platforms=android . || exit 1
cp -r isi_project/. .
rm -rf isi_project test/widget_test.dart
flutter pub get
echo "SELESAI. Jalankan: flutter run"
