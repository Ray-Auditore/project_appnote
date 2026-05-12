NoteApp Flutter
Aplikasi NoteApp adalah aplikasi pencatat sederhana yang dibuat menggunakan Flutter dengan penyimpanan data lokal menggunakan Sqflite.
Aplikasi ini memiliki fitur utama seperti membuat catatan, mengedit catatan, menghapus catatan, serta mendukung Dark Mode dan Light Mode untuk kenyamanan pengguna.

✨ Fitur Utama


➕ Menambahkan catatan baru


📝 Mengedit catatan


🗑️ Menghapus catatan


💾 Penyimpanan data lokal menggunakan Sqflite


🌙 Dark Mode


☀️ Light Mode


📱 Tampilan sederhana dan mudah digunakan



📸 Preview Aplikasi
Tambahkan screenshot aplikasi di folder assets/ lalu gunakan format berikut:
<img width="449" height="991" alt="Screenshot 2026-05-08 110019" src="https://github.com/user-attachments/assets/f87c2fde-4529-45cf-8371-2005becb2fb3" />
<img width="436" height="981" alt="Screenshot 2026-05-08 105804" src="https://github.com/user-attachments/assets/f5e78e27-0f7f-44de-a3ec-f3858bee46c6" />



🛠️ Teknologi yang Digunakan


Flutter


Dart


Sqflite


Provider / Stateful Widget


Material Design



📂 Struktur Project
lib/│├── main.dart├── pages/│   └── note_page.dart├── database/│   └── database_instance.dart├── models/│   └── note_model.dart└── widgets/

📦 Package Dependencies
Tambahkan dependency berikut pada pubspec.yaml:
dependencies:  flutter:    sdk: flutter  sqflite: ^2.3.0  path: ^1.9.0  path_provider: ^2.1.2

🚀 Cara Menjalankan Project


Clone repository


git clone https://github.com/username/noteapp.git


Masuk ke folder project


cd noteapp


Install dependencies


flutter pub get


Jalankan aplikasi


flutter run

💾 Database Sqflite
Aplikasi menggunakan database lokal Sqflite untuk menyimpan data catatan secara offline.
Contoh tabel database:
CREATE TABLE notes(  id INTEGER PRIMARY KEY AUTOINCREMENT,  title TEXT,  content TEXT)

🌗 Dark Mode & Light Mode
Aplikasi mendukung dua tema:


Light Mode ☀️


Dark Mode 🌙


Tema dapat berubah sesuai pengaturan aplikasi atau sistem perangkat.
Contoh implementasi:
themeMode: ThemeMode.system,darkTheme: ThemeData.dark(),theme: ThemeData.light(),

📱 Tampilan UI


Desain minimalis


Mudah digunakan


Responsive di berbagai ukuran layar



👨‍💻 Developer
Dibuat oleh Rayyan Ghibran Ananta menggunakan Flutter ❤️

📄 License
Project ini bebas digunakan untuk pembelajaran dan pengembangan pribadi.
