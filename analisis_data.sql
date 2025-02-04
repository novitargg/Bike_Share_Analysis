--DATA ANALISIS

SELECT * FROM cleaned_annual_tripdata LIMIT 10;

--melihat jumlah pengendara berdasarkan keanggotaan
SELECT member_casual, COUNT(*) AS jumlah_pengendara
FROM cleaned_annual_tripdata
GROUP BY member_casual;

--melihat tipe sepeda berdasarkan keanggotaan dan tipe sepeda
SELECT rideable_type, member_casual, COUNT (*) AS jumlah_pengendara
FROM cleaned_annual_tripdata
GROUP BY rideable_type, member_casual
ORDER BY rideable_type, member_casual;

--melihat jumlah pengendara berdasarkan tipe pengguna setiap bulannya
SELECT month_name, member_casual, COUNT (*) AS jumlah_pengendara_perbulan
FROM cleaned_annual_tripdata
GROUP BY month_name, member_casual
ORDER BY member_casual; 

--melihat jumlah pengendara setiap bulannya
SELECT month_name, COUNT (*) AS jumlah_pengendara_perbulan
FROM cleaned_annual_tripdata
GROUP BY month_name

--melihat jumlah pengendara berdasarkan tipe pengguna per hari
SELECT day_of_week, member_casual, COUNT(*) AS jumlah_pengendara_perhari
FROM cleaned_annual_tripdata
GROUP BY day_of_week, member_casual
ORDER BY member_casual;

--rata-rata durasi perjalanan per bulan
SELECT month_name, member_casual, AVG(ride_length) AS rataan_perjalanan_perbulan
FROM cleaned_annual_tripdata
GROUP BY month_name, member_casual;

SELECT ride_length FROM cleaned_annual_tripdata;

--rata-rata panjang perjalanan per hari
SELECT day_of_week, member_casual, AVG(ride_length) AS rataan_perjalanan_perhari
FROM cleaned_annual_tripdata
GROUP BY day_of_week, member_casual;

--melihat jumlah pengendara pada lokasi perjalanan dimulai
SELECT start_station_name, 
		member_casual,
		AVG(start_lat) AS start_lat,
		AVG(start_lng) AS start_lng,
		COUNT(ride_id) AS total_pengendara
FROM cleaned_annual_tripdata 
GROUP BY start_station_name, member_casual LIMIT 10;

--melihat jumlah pengendara pada lokasi perjalanan berakhir
SELECT end_station_name, 
		member_casual,
		AVG(end_lat) AS end_lat,
		AVG(end_lng) AS end_lng,
		COUNT(ride_id) AS total_pengendara
FROM cleaned_annual_tripdata
GROUP BY start_station_name, member_casual LIMIT 10;

