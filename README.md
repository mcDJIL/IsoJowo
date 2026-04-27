# Isojowo App

Aplikasi Flutter bertema budaya Jawa.

README ini dibuat untuk pemula supaya bisa langsung menjalankan project.

## 1) Persiapan yang wajib

Pastikan sudah terpasang:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (disarankan versi stabil terbaru)
- [Android Studio](https://developer.android.com/studio) + Android SDK
- Minimal 1 emulator Android aktif, atau HP Android dengan USB debugging aktif
- Git

## 2) Cek instalasi Flutter

Jalankan perintah berikut di terminal:

```bash
flutter doctor
```

Kalau ada tanda silang, ikuti saran perbaikannya sampai siap.

## 3) Ambil source code

Jika belum clone:

```bash
git clone <url-repository-kamu>
cd isojowo_app
```

Jika project sudah ada, cukup buka folder project ini.

## 4) Install dependency

Di root project, jalankan:

```bash
flutter pub get
```

## 5) Konfigurasi API Key Gemini (fitur AI)

Fitur `Njawi Look` memakai Gemini API. Atur API key dulu:

1. Buka file `lib/screens/njawi_look_screen.dart`
2. Cari baris konstanta:

```dart
const String _kGeminiApiKey = 'ISI_API_KEY_KAMU';
```

3. Ganti nilainya dengan API key milik kamu dari [Google AI Studio](https://aistudio.google.com/)

Catatan:

- Jangan pakai API key orang lain.
- Kalau muncul error quota atau unauthorized, cek key dan kuota akun Google AI Studio.

## 6) Jalankan aplikasi

Pastikan emulator/HP sudah terdeteksi:

```bash
flutter devices
```

Lalu jalankan:

```bash
flutter run
```

Jika perangkat lebih dari satu:

```bash
flutter run -d <device_id>
```

## 7) Build APK (opsional)

Kalau ingin file APK:

```bash
flutter build apk --release
```

Hasil build ada di:

`build/app/outputs/flutter-apk/app-release.apk`

## 8) Troubleshooting cepat

- Error dependency: jalankan `flutter clean`, lalu `flutter pub get`
- Perubahan plugin tidak kebaca: stop app lalu jalankan lagi (full restart)
- Emulator tidak muncul: cek di Android Studio > Device Manager
- Build gagal karena lisensi Android: jalankan `flutter doctor --android-licenses`

## Referensi

- [Dokumentasi Flutter](https://docs.flutter.dev/)
- [Flutter setup Android](https://docs.flutter.dev/get-started/install/windows/mobile)
