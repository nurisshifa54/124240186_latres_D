# nim_latres_D

Aplikasi toko online sederhana (Flutter) untuk Latihan Responsi Praktikum Pemrograman Aplikasi Mobile. Data produk dari https://dummyjson.com/products.

## Fitur
- Login: username bebas, password = NIM. Username disimpan di Shared Preferences.
- Auto login: kalau belum logout, app langsung masuk ke halaman utama.
- Bottom navigation: Home dan Profile.
- Home: info username, tombol cart, dan daftar produk. Klik produk untuk ke Detail.
- Detail: info lengkap produk, pilih jumlah (1 sampai stok), tombol Tambah ke Cart (disimpan ke Hive beserta username dan jumlah).
- Cart: hanya menampilkan produk milik user yang sedang login, ada tombol hapus.
- Profile: username, deskripsi, tombol Tes Notif (Local Notification), dan Logout.

## Library
- get (GetX)
- http
- hive dan hive_flutter
- shared_preferences
- flutter_local_notifications

## Struktur Folder
```
lib/
├── main.dart                        inisialisasi Hive, notifikasi, cek session, jalankan app
├── model/
│   └── product.dart                 class Product dan fromJson
├── service/
│   ├── product_service.dart         ambil data produk dari API (http)
│   ├── session_service.dart         simpan, ambil, hapus username (Shared Preferences)
│   ├── cart_service.dart            simpan, ambil, hapus isi cart (Hive)
│   └── notification_service.dart    local notification
├── controller/
│   ├── auth_controller.dart         login dan logout
│   ├── product_controller.dart      state daftar produk
│   └── cart_controller.dart         state cart milik user yang login
├── routes/
│   ├── app_routes.dart              nama-nama route
│   └── app_pages.dart               daftar halaman dan binding
└── view/
    └── pages/
        ├── login_page.dart
        ├── main_page.dart           bottom navigation
        ├── home_page.dart
        ├── product_detail_page.dart
        ├── cart_page.dart
        └── profile_page.dart
```

## Cart per user
Setiap item di Hive disimpan dengan key `username-productId`, jadi cart tiap username terpisah. Saat Cart dibuka, hanya item dengan username yang sama dengan user login yang ditampilkan.
