# 124240186_latres_D

Aplikasi toko online sederhana (Flutter) untuk Latihan Responsi Praktikum Pemrograman Aplikasi Mobile. Data produk dari https://dummyjson.com/products.

## Fitur
- Login: username bebas, password = NIM. Username disimpan di Shared Preferences.
- Auto login: kalau belum logout, app langsung masuk ke halaman utama.
- Bottom navigation: Home dan Profile.
- Home: info username, tombol cart, dan daftar produk. Klik produk untuk ke Detail.
- Detail: info lengkap produk, pilih jumlah (1 sampai stok), tombol Tambah ke Cart (disimpan ke Hive beserta username dan jumlah).
- Cart: hanya menampilkan produk milik user yang sedang login, ada tombol hapus.
- Profile: username, kesan dan pesan, tombol Tes Notif (Local Notification), dan Logout.

## Library
- get (GetX): state management, dependency injection, routing, dan binding (Modul VIII)
- http: mengambil data produk dari API
- hive dan hive_flutter: menyimpan cart dengan TypeAdapter (Modul VI)
- shared_preferences: menyimpan session login (Modul VI)
- flutter_local_notifications: notifikasi (Modul VII)

## Struktur Folder
```
lib/
├── main.dart                        inisialisasi Hive, notifikasi, AuthController, GetMaterialApp
├── model/
│   ├── product.dart                 class Product dan fromJson
│   ├── cart_item.dart               class CartItem (HiveObject) untuk isi cart
│   └── cart_item.g.dart             adapter Hive untuk CartItem
├── service/
│   ├── product_service.dart         ambil data produk dari API
│   └── notification_service.dart    local notification
├── controller/
│   ├── auth_controller.dart         login, logout, cek login (Shared Preferences)
│   ├── product_controller.dart      state daftar produk
│   └── cart_controller.dart         tambah dan hapus item cart (Hive)
├── routes/
│   ├── app_routes.dart              nama-nama route
│   └── app_pages.dart               daftar halaman dan binding
└── view/
    ├── pages/
    │   ├── login_page.dart
    │   ├── main_page.dart           bottom navigation
    │   ├── home_page.dart
    │   ├── product_detail_page.dart
    │   ├── cart_page.dart
    │   └── profile_page.dart
    └── widgets/
        └── product_card.dart        kartu produk
assets/
└── logo54.jpg                       logo toko
```

## Cart per user
Setiap item cart di Hive menyimpan field `username`. Saat halaman Cart dibuka, hanya item dengan username yang sama dengan user yang login yang ditampilkan, jadi cart tiap username terpisah.
