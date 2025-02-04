--melihat keseluruhan data
SELECT * FROM annual_tripdata_juni2023_juni2024

--cek struktur kolom pada tabel annual_tripdata_juni2023_juni2024
PRAGMA table_info(annual_tripdata_juni2023_juni2024);

--CEK KEHADIRAN DATA

--cek jlh data yang kosong
SELECT COUNT(*)-COUNT(ride_id) AS ride_id,
	COUNT(*)-COUNT(rideable_type) AS rideable_type,
	COUNT(*)-COUNT(started_at) AS started_at,
	COUNT(*)-COUNT(ended_at) AS ended_at,
	COUNT(*)-COUNT(start_station_name) AS start_station_name,
	COUNT(*)-COUNT(start_station_id) AS start_station_id,
	COUNT(*)-COUNT(end_station_name) AS end_station_name,
	COUNT(*)-COUNT(end_station_id) AS end_station_id,
	COUNT(*)-COUNT(start_lat) AS start_lat,
	COUNT(*)-COUNT(start_lng) AS start_lng,
	COUNT(*)-COUNT(end_lat) AS end_lat,
	COUNT(*)-COUNT(end_lng) AS end_lng,
	COUNT(*)-COUNT(member_casual) AS member_casual
FROM annual_tripdata_juni2023_juni2024;

--cek data yang duplikat, data dicek berdasarkan kolom ride_id
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS baris_duplikat
FROM annual_tripdata_juni2023_juni2024;


--PENGECEKAN FORMAT TANGGAL
SELECT started_at, ended_at
FROM annual_tripdata_juni2023_juni2024
LIMIT 20

--cek started_at, ended_at yang lebih dari sehari
SELECT COUNT (*) AS lebih_dari_sehari
FROM annual_tripdata_juni2023_juni2024
WHERE (
	julianday(ended_at)-julianday(started_at)) *24*60>=1440;

--cek started_at, ended_at yang kurang dari semenit
SELECT COUNT(*) AS kurang_dari_semenit
FROM annual_tripdata_juni2023_juni2024
WHERE (
	(julianday(ended_at)-julianday(started_at))*24*60) <=1;

--CEK ISI DATA

--cek kelengkapan rideable_type
SELECT DISTINCT rideable_type, COUNT(rideable_type) AS jumlah_tipe
FROM annual_tripdata_juni2023_juni2024
GROUP BY rideable_type

--cek kelengkapan member_casual
SELECT DISTINCT member_casual, COUNT(member_casual) AS jumlah_member_casual
FROM annual_tripdata_juni2023_juni2024
GROUP BY member_casual

--cek panjang data ride_id =16
SELECT LENGTH (ride_id) AS panjang_id, COUNT(ride_id) AS jumlah_baris_id
FROM annual_tripdata_juni2023_juni2024
GROUP BY panjang_id