# Case Study: Cylistic Bike Share Analysis

## Scenario
Berperan sebagai analisis data junior di tim analisis pemasaran di Cylistic, sebuah sebuah perusahaan berbagi sepeda di Chicago. Direktur pemasaran percaya bahwa kesuksesan perusahaan di masa depan tergantung pada upaya untuk memaksimalkan jumlah keanggotaan tahunan. Oleh karena itu, tim analisis pemasaran ingin memahami bagaimana pengendara casual dan member tahunan menggunakan sepeda Cyclistic secara berbeda. Dari wawasan ini, tim analisis pemasaran akan merancang strategi pemasaran baru untuk mengubah pengendara casual menjadi member tahunan. 

**Untuk menjawab pertanyaan bisnis utama, tim analisis pemasaran akan mengikuti proses analisis data: bertanya, mempersiapkan, memproses, menganalisis, berbagi, dan bertindak.**

BERTANYA
---

Tahap bertanya mengidentifikasi tugas bisnis, mendefinisikan masalah apa yang akan dipecahkan dan mempertimbangkan pemangku kepentingan utama

### Tugas Bisnis: 

Merancang strategi pemasaran yang bertujuan untuk mengubah pengendara casual menjadi member tahunan.
Pertanyaan yang ingin dijawab

Tiga pertanyaan yang akan memandu program pemasaran di masa depan:
1.	Bagaimana member tahunan dan pengendara casual menggunakan sepeda secara berbeda?
2.	Mengapa pengendara casual membeli keanggotaan tahunan Cyclistic?
3.	Bagaimana Cyclistic menggunakan media digital untuk mempengaruhi pengendara casual untuk menjadi member?

PERSIAPAN
--
### Dataset
Dataset perjalanan historis Cylistic bersumber [sini](divvy-tripdata.s3.amazonaws.com). 

Catatan: 
Dataset tersebut memiliki nama yang berbeda karena Cyclistic adalah perusahaan fiksi. Data telah disediakan oleh Motivate International Inc dengan lisensi. 

### Keterangan Data
Dataset yang digunakan merupakan data dengan periode juni 2023-juni 2024. Data yang disediakan dalam format zip, selanjutnya data tersebut terlebih dahulu disimpan dalam folder yang sama dengan format csv (comma-separate value). Data disimpan dalam format YYYYMM-divvy-tripdata.

Dataset terdiri dari variabel: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual.

### Kredibilitas Data
Memastikan kredibilitas dan integritas data akan menggunakan sistem ROCC.
- Reliable: Data memiliki ukuran sampel yang besar, sehingga mencerminkan ukuran populasi.
- Original: Sumber keaslian data dapat ditemukan
- Comprehensive: Setelah dicek, informasi pada dataset dapat dimengerti dan memenuhi kebutuhan data untuk menjawab pertanyaan.
- Current: Data relevan dan terkini
- Cited: Sumber data telah diperiksa yaitu disediakan oleh Motivate International Inc.

### Keterbatasan Data
Aturan privasi data melarang menggunakan informasi pengenal pribadi pengendara. 

PROCESS
---
Pada tahap proses, data akan dibersihkan agar kualitas dan integritas data serta kualitas wawasan yang diperoleh dari data semakin meningkat.

#### Tools yang digunakan:
DB SQL Lite dan Tableau

### Validasi data
Sebelum membersihkan data, terlebih dahulu data akan diidentifikasi untuk melihat bagian-bagian data yang masih perlu diperbaiki atau dibersihkan.

Pada gambar dibawah akan diperlihatkan bentuk data yang akan diproses
![Image](https://github.com/user-attachments/assets/b8a09ec1-9b16-4c3b-91b0-1d02e001600c)
 
Dari tabel tersebut, diperlihatkan bahwa terdapat 6.453.999 jumlah keseluruhan baris dan 13 kolom. Selanjutnya akan dilakukan pemeriksaan atau validasi data.

![Image](https://github.com/user-attachments/assets/ed8b94e1-d53d-4db3-b0f2-652a1140ff79)

- Pemeriksaan Format
Format kolom started_at dan started_end belum dalam format tanggal, sehingga masih harus diperbaiki.
- Pemeriksaan Kehadiran Data
Pada kolom start_station name dan start_station_id terdapat 1049262 baris yang kosong, pada kolom end_station name dan end_station_id terdapat 1104606 baris yang kosong, dan pada kolom end_lat dan end_lng terdapat 8808 baris yang kosong. Selanjutnya terdapat 211 baris yang duplikat. Pada pembersihan data, baris yang kosong dan duplikat akan dihapus guna meningkatkan kualitas data.
- Pemeriksaan Kelengkapan Data
--pemeriksaan durasi lebih dari sehari dan durasi kurang dari semenit
Hasil pemerikasaan menunjukkan terdapat 8723 jumlah pengendara sepeda yang memakai sepeda lebih dari sehari dan terdapat 155019 jumlah pengendara sepeda yang memakai sepeda kurang dari semenit. Selanjutnya pada pembersihan data nanti akan  dipilih jumlah pengendara sepeda yang lebih dari semenit dan kurang dari 24 jam.
-- pemeriksaan variabel
Pada kolom rideable_type hanya memiliki tiga tipe yaitu classic_bike, docked_bike, dan electric_bike. Setelah dicek, terlihat bahwa kolom member_casual hanya memiliki dua input yaitu member dan casual. Selanjutnya pada keseluruhan baris di kolom ride_id memiliki 16 karakter. Kelengkapan data untuk kolom rideable_type, member_casual, dan ride_id sudah benar.

Cleaning Data
---
Proses pembersihan data pada proyek ini masih menggunakan DB Browser SQLite. Pada tahap ini akan dilakukan juga tahap transformasi yaitu menambahkan beberapa kolom baru yang akan dibutuhkan untuk analisis.   Oleh karena itu, akan dibuat tabel baru yang dinamakan cleaned_annual_tripdata yang berisi data sudah bersih dan tambahan kolom baru.
Setelah data diekstrak dari kolom sebelumnya, maka dibawah ini akan dijelaskan tahapan yang dilakukan.

- Perbaikan format data tanggal
- Menghapus data kosong dan data duplikat

Pada proses pembuatan tabel baru, menjadikan ride_id sebagai primary key mengindikasikan bahwa ride_id yang duplikat tidak akan diikutsertakan. Oleh karena itu, pada kolom cleaned_annual_tripdata sudah tidak ada lagi data yang duplikat. 
Selanjutnya, data yang diidentifikasi memiliki baris yang kosong pada tahap pengecekan akan dihapus menggunakan perintah DROP.
- Menambahkan kolom day_of_week dan month_name
Selanjutnya akan ditambahkan kolom day_of_week yang menunjukkan hari dimana perlajalanan dimulai, dan kolom month_name yang menunjukkan bulan saat perjalanan dimulai.
- Menambahkan kolom length_ride
Kolom length_ride akan ditambahkan, kolom ini menunjukkan durasi perjalanan pengendera sepeda dengan mengurangkan kolom ended_at dengan started_at. Kolom length_ride menunjukkan durasi perjalanan pengendara sepeda yang memakai sepeda lebih dari semenit dan kurang dari 24 jam. Pada kolom ride_length, data berisi jumlah waktu dalam menit.

Tabel cleaned_annual_tripdata sudah memiliki kolom tambahan yaitu day_of_week, month_name, dan ride_length.
![Image](https://github.com/user-attachments/assets/f77d739a-e637-4988-b44a-3d698e66d961)

ANALISIS
--
Proses analisis akan menunjukkan wawasan yang diperoleh dari data, pada tahap ini, data akan menjawab pertanyaan yang sudah didefinisikan pada tahap Bertanya sebelumnya.

Untuk menjawab pertanyaan tersebut, akan dilakukan eksplorasi terhadap data untuk menemukan pola dan tren yang bisa menjawab pertanyaan. 

### Pengendara casual dan member

![Image](https://github.com/user-attachments/assets/a09d70c9-9844-42d5-8f4e-3d38ad764117)
![Image](https://github.com/user-attachments/assets/6eddc0d7-21f1-4058-ab61-21949461938e)
 
### Analisis pengendara casual dan member 

![Image](https://github.com/user-attachments/assets/bdbdcb9a-09ff-4649-8ed1-ebc57e5ceb87)

![Image](https://github.com/user-attachments/assets/3f8c97b6-474c-4202-a3b1-ad7b25dbd30a)

![Image](https://github.com/user-attachments/assets/e628c37f-ac90-4829-ae36-0dc40e8b0fd7)
 
Berdasarkan line chart, jumlah pengguna member tahunan selalu lebih tinggi dibandingkan pengendara casual. Dibawah ini akan ditunjukkan variasi yang lebih mendalam dari chart diatas.

- Per bulan: Pengendara sepeda casual maupun member menunjukkan perilaku yang sama yaitu perjalanan yang memuncak saat bulan juni, juli, dan agustus yang mungkin terjadi karena adanya liburan musim panas.
- Per hari : Pengendara sepeda member menunjukkan penggunaan sepeda yang meningkat konsisten dan sedikit menurun pada akhir pekan, sementara pengendara casual meningkat pada saat akhir pekan.
- Per jam:  Pengendara sepeda member menunjukkan lonjakan pada jam 6-8, dan pada jam 16-20. Pengendara sepeda casual menunjukkan perjalanan yang meningkat konsisten dan paling tinggi pada saat jam 16-20.

### Analisis pengendara berdasarkan durasi penggunaan sepeda 

 ![Image](https://github.com/user-attachments/assets/a63541fe-a798-437a-ab5a-57ace1ee736d)

![Image](https://github.com/user-attachments/assets/05335a86-a4a2-40ea-a14f-c8df5df8772e)

![Image](https://github.com/user-attachments/assets/03198557-7a3d-409c-b8af-fe98fce96372)

Berdasarkan ketiga line chart, pengendara sepeda casual maupun member memiliki kesamaan yaitu pengendara casual memiliki durasi perjalanan yang lebih lama dibandingkan pengendara member. 
Selanjutnya akan diperlihatkan variasi yang lebih mendalam dari chart diatas. 
- Per bulan: Durasi perjalanan pengendara sepeda menaik pada bulan april hingga akhir agustus, yang menunjukkan jarak tempuh pengendara pada bulan tersebut lebih jauh dari bulan sebelumnya.
- Per hari : Pola garis menunjukkan pola yang sama bagi kedua jenis pengendara yaitu durasi perjalanan meningkat pada saat mendekati awal hari kerja dan akhir pekan.
- Per jam : Durasi perjalanan pengendara casual menunjukkan lonjakan pada jam 10 hingga jam 2 siang sementara durasi member memiliki pola yang konsisten pada setiap jam.

### Analisis tipe sepeda
 
![Image](https://github.com/user-attachments/assets/ae2d3ea2-7809-4a0d-a053-5555222f05d4)

![Image](https://github.com/user-attachments/assets/6229af55-135a-4c0a-b8d7-21e48adc399c)

![Image](https://github.com/user-attachments/assets/0bfffb93-5f47-4ac9-af1e-4576d2be0ead)

![Image](https://github.com/user-attachments/assets/c23d8543-918a-4251-8842-05835a86f778)
 
Berdasarkan informasi diatas, tipe sepeda yang paling banyak diminati ialah tipe sepeda classic diikuti electric dan docked. Ketiga line chart tersebut menunjukkan bahwa classic bike memiliki nilai yang paling tinggi. Selain itu terlihat bahwa classic dan electric bike lebih banyak digunakan pada bulan juni hingga agustus. Lalu pengguna classic dan electric bike menujukkan kenaikan pada jam 8 pagi dan kenaikan paling tinggi pada jam 6 sore.

BERBAGI
---
Berdasarkan hasil analisis diatas, hal yang dapat disorot ialah sebagai  berikut:

- Pengendara sepeda casual maupun member menunjukkan perilaku yang sama yaitu perjalanan yang memuncak saat bulan juni, juli, dan agustus. Hal tersebut dapat terjadi karena liburan musim panas biasanya dimulai pada bulan juni hingga agustus.
- Pengguna sepeda casual dan member berdasarkan hari kerja dan akhir pekan menunjukkan bahwa member mayoritas menggunakan sepeda pada hari kerja sedangkan pengguna casual menggunakan sepeda pada akhir pekan.
- Pengendara member menunjukkan lonjakan pada jam 6-8 dan jam 16-20. Hal tersebut memiliki kemungkinan bahwa member menggunakan sepeda untuk berangkat dan pulang bekerja.
- Durasi perjalanan tersebut dapat menunjukkan bahwa jarak tempuh pengendara casual lebih jauh dibandingkan member. Pada akhir pekan, durasi perjalanan akan meningkat bagi kedua tipe pengguna. Lalu durasi perjalanan pengguna casual berdasarkan jam menunjukkan bahwa kemungkinan pengguna casual memiliki waktu yang cukup fleksibel, dimana pengguna casual mungkin menggunakan sepeda untuk tujuan rekreasi.
- Tipe sepeda yang paling diminati oleh pengguna ialah tipe classic diikuti electric dan docked.

BERTINDAK
---

Berdasarkan analisis dan informasi yang diperoleh dari data, berikut ini beberapa rekomendasi yang dapat saya berikan:
1.	Berdasarkan informasi, pengguna sepeda meningkat pada musim panas. Oleh karena itu, marketing mengenai keuntungan yang diperoleh sebagai pengguna member tahunan dapat dilakukan sebelum musim panas hingga berlangsungnya musim panas.
2.	Pengguna casual mayoritas menggunakan sepeda pada akhir pekan, sehingga menawarkan paket khusus sebagai member tahunan pada akhir pekan dapat dicoba sembari menonjolkan keuntungan yang diperoleh sebagai member tahunan.
3.	Berdasarkan durasi perjalanan, pengendara casual kemungkinan memiliki waktu yang cukup fleksibel, pengguna casual mungkin menggunakan sepeda untuk tujuan rekreasi. Untuk menarik pengguna casual menjadi member, menonjolkan pengehematan biaya yang diperoleh sebagai member tahunan dibandingkan sebagai casual dan memberikan diskon dapat dicoba untuk meningkatkan pengguna member.




