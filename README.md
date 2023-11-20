# Tugas Kelompok PTS C01 <CONE>
## Anggota Kelompok
**PBP C | VRO**
- Nurin Farzana Nafiah(2206082695)
- Calista Sekar Pamaja (2206082064)
- Muhammad Nanda Pratama (2206081654)
- Fazle Ilahi Bimo Aji (2206081446)
- Resanda Dezca Asyam (2206082682)
------------------
## Tautan Berita Acara
[Tautan Berita Acara](https://univindonesia-my.sharepoint.com/:x:/g/personal/calista_sekar_office_ui_ac_id/EUnjZrQaeM9GgEaQnD3NUeABI_EVRlMdAIquNQ7l8XRvLQ?e=5akaGa)
# Librarium 📖
## Tautan Situs
http://librarium-c01-tk.pbp.cs.ui.ac.id.
## Background Story
Literasi adalah kunci untuk pengembangan individu dan kemajuan bangsa. Indonesia memiliki berbagai regulasi yang mendukung peningkatan literasi, termasuk Undang-Undang Dasar 1945 yang menekankan hak warga negara untuk mendapatkan pendidikan yang layak. Librarium, sebagai sebuah website yang mengedepankan kegiatan membaca dan berbicara tentang buku, memiliki peran penting dalam memajukan literasi di Indonesia. Fitur-fitur seperti Book Reviews memungkinkan pengguna untuk mengekspresikan pendapat mereka tentang buku dan berbagi rekomendasi dengan komunitas pembaca lainnya. Hal ini membantu memotivasi masyarakat untuk membaca dan meningkatkan pemahaman mereka tentang literatur.

Librarium adalah sebuah _website_ seru yang membantu kamu berbicara tentang buku! Dengan fitur-fitur seperti Book Reviews, kamu dapat mengekspresikan pendapatmu tentang buku-buku yang baru kamu baca, berbagi rekomendasi, dan mendapatkan wawasan dari pengulas lainnya. Fitur lain seperti Book Loans memudahkanmu untuk mengatur buku-buku yang sedang kamu pinjam, dan mengingatkanmu kapan waktunya untuk mengembalikannya. Fitur Collections memberikan akses cepat ke daftar buku yang tersedia, sementara fitur Bookshelf memungkinkanmu mengatur koleksimu dengan mudah. Librarium adalah teman terbaikmu dalam menjelajahi dunia literatur dan berinteraksi dengan komunitas pembaca yang serupa.

### Why Librarium?
- Meningkatkan Literasi
- Kemudahan dalam Membaca
- Akses Cepat ke Daftar Buku
- Mengatur Koleksi Pribadi
- Kesempatan berinteraksi dalam Komunitas Pembaca
- Dukungan pada Kemajuan Literasi di Indonesia

## Daftar modul yang akan diimplementasikan
### 🏠 Homepage
Modul ini menampilkan halaman utama dari aplikasi Librarium. Pada `Homepage` terdapat overview mengenai fitur-fitur yang aplikasi kami sediakan.
### 📝 Book Review (Calista)
Di dalam aplikasi `Librarium`, pengguna dapat menambahkan ulasan terhadap suatu buku. Pada halaman `Book Reviews`, pengguna dapat memilih salah satu buku untuk diberikan rating lalu diulas singkat. Modul ini menerapkan fungsi `post` untuk menambahkan ulasan yang ditulis oleh pengguna dan fungsi `get` untuk mengambil objek `Review` dan `Book` yang ada.

Pada modul ini, kami mengimplementasikan beberapa _event handler_ :

1. `onTap`:
* Digunakan pada button `Book Reviews`. Ketika button di-tap, program akan memanggil `Navigator.push` dan melakukan push menuju halaman `Book Reviews`

2.  `onPressed` digunakan untuk button `Add Review` dan `back`.
* Ketika button `Add Review` di-pressed maka akan memanggil `Navigator.push` dan melakukan push menuju halaman `Add Review`
### 📖 Book Loans (Nurin)
User yang sudah terdaftar dan berhasil melakukan login dapat mengakses salah satu fitur yang ada pada librarium. Pada fitur ini, terdapat katalog yang berisikan buku-buku yang available uuntuk dipinjam. Modul ini  menerapkan post yang berfungsi untuk menambahkan buku-buku yang dipinjam oleh user. Fungsi get berguna untuk mengambil data buku-buku yang dipinjam.
Event handler yang digunakan pada modul ini:
1. onChanged: Digunakan pada file add_loans.dart yang berfungsi untuk inisiasi ketika ada perubahan pada TextFormField pada form penambahan buku pinjaman.
2. onPressed: Button yang digunakan untuk menampilkan informasi detail setiap buku yang dipinjam user dan Button Add pada pade Book Loans yang akan mengarahkan ke page form untuk menambahkan buku yang akan dipinjam.
### 📔 Collections (Resanda)
Fitur ini menampilkan daftar buku-buku yang tersedia di `Librarium`. Pengguna juga dapat membuat suatu kelompok/kategori buku (Liked/Favorite/lainnya) dimana pengguna dapat melihat dan menambahkan daftar buku dalam koleksi tersebut. Modul ini mengimplementasikan _list of_ buku. Dalam modul ini memanfaatkan `get` untuk mengambil data dari buku, dan memanfaatkan  `post` untuk menambahkan list collection yang dibuat pengguna.
Event handler yang digunakan pada modul:
* `onTap` pada tiap card Collection yang akan memanggil `Navigator.push` di mana akan ter-push halaman Edit Plan untuk menyunting Collection tersebut.
* `onPressed` untuk button Add Collection, Add Book, dan Edit Collection
### 📚 User Profile (Nanda)
Fitur Userprofile berfungsi sebagai informasi pengguna librarium dan untuk mengganti user profile dan password.

Event handler yang digunakan pada modul:
1. onChanged: Digunakan pada edit_profile.dart yang berfungsi untuk trigger ketika ada perubahan pada TextFormField pada form penggantian password dan profile
2. onPressed : Digunakan untuk menyimpan perubahan profile user atau password user ketika tombol submit ditekan.
### 📥 Book Request (Bimo)
User dan Guest dapat menambahkan permintaan buku yang ingin diunggah di aplikasi librarium. Para pengguna dapat menambahkan rincian buku, seperti nama, tahun terbit, nomor ISBN, dan review singkat sebagai bahan pertimbangan pengembang untuk menambahkan buku tersebut ke dalam aplikasi librarium. Modul ini menerapkan GET untuk mengambil rincian mengenai buku yang kemudian akan ditampilkan pada laman pengguna. Selain itu, modul ini juga menggunakan metode POST untuk menambahkan permintaan buku baru serta menyunting permintaan yang sudah ada.<br>

Event handler yang digunakan pada modul:
* onTap pada setiap card buku yang akan memanggil Navigator.push untuk memunculkan halaman Edit Request untuk menyunting permintaan tersebut.
* onPressed untuk button _Add Request_, _Edit Request_, dan back yang akan mengarahkan ke halaman yang sesuai, kemudian untuk button SAVE dan EDIT yang akan memanggil function yang sesuai untuk menambahkan atau menyunting permintaan atau _request_.

## Datasets
_Project_ kami akan menggunakan sumber dataset buku `Book Recommendation Dataset` oleh MÖBIUS dari platform Kaggle
[Book Recommendation Dataset by MÖBIUS](https://www.kaggle.com/datasets/arashnic/book-recommendation-dataset/)

## User Roles
### Guest 🔒
Guest adalah pengguna yang belum login. Berikut ini hal-hal yang dapat dilakukan oleh Guest:
- Mengakses `Homepage`.
- Membuka halaman `About Us`.
- Memberikan kritik dan saran.
### Member 🔓
Member merupakan pengguna yang sudah melakukan _register_. Pengguna yang telah login dapat mengakses seluruh fitur yang tersedia dalam Liberarium, diantaranya Book Reviews, Book Loans, Collections, Bookshelf, dan Book Request.
