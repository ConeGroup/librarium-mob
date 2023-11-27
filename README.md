# Tugas Kelompok PAS C01 <CONE>
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
## Tautan Aplikasi Mobile
https://install.appcenter.ms/orgs/pas-c01/apps/librarium/distribution_groups/public.
## Background Story
Literasi adalah kunci untuk pengembangan individu dan kemajuan bangsa. Indonesia memiliki berbagai regulasi yang mendukung peningkatan literasi, termasuk Undang-Undang Dasar 1945 yang menekankan hak warga negara untuk mendapatkan pendidikan yang layak. Librarium, sebagai sebuah _website_ yang mengedepankan kegiatan membaca dan berbicara tentang buku, memiliki peran penting dalam memajukan literasi di Indonesia. Fitur-fitur seperti Book Reviews memungkinkan pengguna untuk mengekspresikan pendapat mereka tentang buku dan berbagi rekomendasi dengan komunitas pembaca lainnya. Hal ini membantu memotivasi masyarakat untuk membaca dan meningkatkan pemahaman mereka tentang literatur.

Librarium adalah sebuah _website_ seru yang membantu kamu berbicara tentang buku! Dengan fitur-fitur seperti Book Reviews, kamu dapat mengekspresikan pendapatmu tentang buku-buku yang baru kamu baca, berbagi rekomendasi, dan mendapatkan wawasan dari pengulas lainnya. Fitur lain seperti Book Loans memudahkanmu untuk mengatur buku-buku yang sedang kamu pinjam, dan mengingatkanmu kapan waktunya untuk mengembalikannya. Fitur Collections memberikan akses cepat ke daftar buku yang tersedia, sementara fitur Book Request memungkinkanmu untuk melakukan _request_ buku favoritmu agar diunggah pada Librarium. Librarium adalah teman terbaikmu dalam menjelajahi dunia literatur dan berinteraksi dengan komunitas pembaca yang serupa.

Selain itu, Librarium kini hadir dalam aplikasi _mobile_ yang tentunya akan memudahkan para penggiat buku ketika ingin merasakan semua fitur Librarium melalui satu genggaman tangan. Walaupun ukurannya dapat dikatakan lebih minimalis, Librarium _Mobile_ akan tetap menjaga semua fitur yang sudah ada pada _website_ Librarium agar dapat terus dinikmati oleh penggunanya, seperti fitur Book Reviews, Book Loans, Collections, dan Book Request.  

### Why Librarium?
- Meningkatkan Literasi
- Kemudahan dalam Membaca
- Akses Cepat ke Daftar Buku
- Mengatur Koleksi Pribadi
- Kesempatan berinteraksi dalam Komunitas Pembaca
- Dukungan pada Kemajuan Literasi di Indonesia

## Daftar Modul
### 🏠 Homepage
Modul ini menampilkan halaman utama dari aplikasi Librarium. Pada `Homepage` terdapat _overview_ mengenai fitur-fitur yang aplikasi kami sediakan.

### 📚 User Profile (Nanda)
Fitur *User Profile* berfungsi sebagai informasi pengguna Librarium dan untuk mengganti _user profile_ dan _password_.<br>

Pada modul ini, kami mengimplementasikan beberapa _event handler_ :

1. `onChanged` digunakan pada `edit_profile.dart` yang berfungsi sebagai _trigger_ ketika ada perubahan pada `TextFormField` pada _form_ penggantian _password_ dan _profile_.
2. `onPressed` digunakan untuk menyimpan perubahan _profile user_ atau _password user_ ketika tombol _submit_ ditekan.

### 📝 Book Review (Calista)
Pada aplikasi `Librarium`, pengguna dapat menambahkan ulasan terhadap suatu buku. Pada halaman *Book Reviews*, pengguna dapat memilih salah satu buku untuk diberikan _rating_ lalu diulas singkat. Modul ini menerapkan fungsi `post` untuk menambahkan ulasan yang ditulis oleh pengguna dan fungsi `get` untuk mengambil objek `Review` dan `Book` yang ada.<br>

Pada modul ini, kami mengimplementasikan beberapa _event handler_ :

1. `onTap` digunakan pada button *Book Reviews*. Ketika button di-_tap_, program akan memanggil `Navigator.push` dan melakukan _push_ menuju halaman *Book Reviews*.
2.  `onPressed` digunakan untuk button `Add Review` dan `back`. Ketika _button_ `Add Review` di-_pressed_ maka akan memanggil `Navigator.push` dan melakukan _push_ menuju halaman `Add Review`.

### 📖 Book Loans (Nurin)
_User_ yang sudah terdaftar dan berhasil melakukan _login_ dapat mengakses salah satu fitur yang ada pada Librarium. Pada fitur ini, terdapat katalog yang berisikan buku-buku yang tersedia untuk dipinjam. Modul ini menerapkan `post` yang berfungsi untuk menambahkan buku-buku yang dipinjam oleh _user_. Fungsi `get` berguna untuk mengambil data buku-buku yang dipinjam.<br>

Pada modul ini, kami mengimplementasikan beberapa _event handler_ :

1. `onChanged` digunakan pada _file_ `add_loans.dart` yang berfungsi untuk inisiasi ketika ada perubahan pada `TextFormField` pada _form_ penambahan buku pinjaman.
2. `onPressed` digunakan untuk menampilkan informasi rinci setiap buku yang dipinjam _user_ dan _button_ `Add` pada *Book Loans* yang akan mengarahkan ke _page form_ untuk menambahkan buku yang akan dipinjam.

### 📔 Collections (Resanda)
Fitur ini menampilkan daftar buku-buku yang tersedia di `Librarium`. Pengguna juga dapat membuat suatu kelompok/kategori buku (_Liked/Favorite/_lainnya) dengan menambahkan buku-buku yang menurut pengguna sesuai dengan kategori tersebut sehingga apabila ingin membaca atau mengulas kembali buku tertentu, pengguna dapat dengan mudah melihatnya pada kumpulan buku yang sudah dikategorikan. Modul ini mengimplementasikan _list of_ buku. Dalam modul ini memanfaatkan `get` untuk mengambil data dari buku, dan memanfaatkan `post` untuk menambahkan _list collection_ yang dibuat pengguna.<br>

Pada modul ini, kami mengimplementasikan beberapa _event handler_ :

* `onTap` pada tiap _card_ di halaman *Collections* sebagai pemicu `Navigator.push` untuk melakukan _push_ ke halaman *Edit Plan* jika ingin menyunting kategori buku tersebut.
* `onPressed` untuk _button_ `Add Collection`, `Add Book`, dan `Edit Collection`.

### 📥 Book Request (Bimo)
_User_ dan _Guest_ dapat menambahkan permintaan buku yang ingin diunggah di aplikasi Librarium. Para pengguna dapat menambahkan rincian buku, seperti nama, tahun terbit, nomor ISBN, dan ulasan singkat sebagai bahan pertimbangan pengembang untuk menambahkan buku tersebut ke dalam aplikasi Librarium. Modul ini menerapkan `get` untuk mengambil rincian mengenai buku yang kemudian akan ditampilkan pada laman pengguna. Selain itu, modul ini juga menggunakan metode `post` untuk menambahkan permintaan buku baru serta menyunting permintaan yang sudah ada.<br>

Pada modul ini, kami mengimplementasikan beberapa _event handler_ :

* `onTap` pada setiap _card_ buku yang akan memanggil `Navigator.push` untuk memunculkan halaman *Edit Request* jika ingin menyunting permintaan tersebut.
* `onPressed` untuk _button_ `Add Request`, `Edit Request`, dan `back` yang akan mengarahkan ke halaman yang sesuai, kemudian untuk _button_ `SAVE` dan `EDIT` yang akan memanggil _function_ yang sesuai untuk menambahkan atau menyunting permintaan atau _request_.

## Integrasi Web dengan Aplikasi
Berikut adalah langkah-langkah yang akan dilakukan untuk mengintegrasikan aplikasi dengan server _web_:
* Mengimplementasikan sebuah _wrapper class_ dengan menggunakan _library_ `http` dan `map` untuk mendukung penggunaan _cookie-based authentication_ pada aplikasi.
* Mengimplementasikan REST API pada Django (`views.py`) dengan menggunakan `JsonResponse` atau Django JSON `Serializer`.
* Mengimplementasikan desain _front-end_ untuk aplikasi berdasarkan desain _website_ yang sudah ada sebelumnya.
* Melakukan integrasi antara _front-end_ dan _back-end_ dengan menggunakan konsep _asynchronous_ `HTTP`.
## Datasets
_Project_ kami akan menggunakan sumber _dataset_ buku `Book Recommendation Dataset` oleh MÖBIUS dari _platform_ Kaggle
[Book Recommendation Dataset by MÖBIUS](https://www.kaggle.com/datasets/arashnic/book-recommendation-dataset/)

## User Roles
### Guest 🔒
_Guest_ adalah pengguna yang belum _login_. Berikut ini hal-hal yang dapat dilakukan oleh _Guest_:
- [x] Mengakses `Homepage`.
- [x] Membuka halaman `About Us`.
- [x] Memberikan kritik dan saran.
### Member 🔓
_Member_ merupakan pengguna yang sudah melakukan _register_. Berikut ini hal-hal yang dapat dilakukan oleh _Member_:
- [x] Mengakses apa saja yang dapat diakses oleh _Guest_.
- [x] Menyunting rincian data pribadi pada *User Profile*.
- [x] Mengakses semua fitur utama Librarium, seperti *Book Reviews*, *Book Loans*, *Collections*, dan *Book Request*.

### Build Status
[![Build status](https://build.appcenter.ms/v0.1/apps/19edfacb-ce87-48b6-a8ff-0ebe61f1c3f9/branches/main/badge)](https://appcenter.ms)