--DATA CLEANING

DROP TABLE IF EXISTS cleaned_annual_tripdata;

--membuat tabel baru yang berisi data bersih

CREATE TABLE IF NOT EXISTS cleaned_annual_tripdata (
	ride_id TEXT PRIMARY KEY,
	rideable_type TEXT,
	started_at DATETIME,
	ended_at DATETIME,
	start_station_name TEXT,
	start_station_id TEXT,
	end_station_name TEXT,
	end_station_id TEXT,
	start_lat REAL,
	start_lng REAL,
	end_lat REAL,
	end_lng REAL,
	member_casual TEXT
);


--memasukkan data dari tabel annual_tripdata_juni2023_juni2024
INSERT INTO cleaned_annual_tripdata(ride_id, 
									rideable_type, 
									started_at, 
									ended_at,
									start_station_name, 
									start_station_id, 
									end_station_name, 
									end_station_id, 
									start_lat,
									start_lng,
									end_lat,
									end_lng,
									member_casual)
SELECT ride_id,
		rideable_type,
		started_at,
		ended_at,
		a.start_station_name, 
		a.start_station_id, 
		a.end_station_name, 
		a.end_station_id, 
		a.start_lat,
		a.start_lng,
		a.end_lat,
		a.end_lng,
		a.member_casual
FROM annual_tripdata_juni2023_juni2024 AS a
GROUP BY a.ride_id;

--cek struktur kolom pada tabel cleaned_annual_tripdata
PRAGMA table_info(cleaned_annual_tripdata);

--menghapus data yang kosong berdasarkan kolom start_station_name
DELETE FROM cleaned_annual_tripdata
WHERE start_station_name IS NULL;

--menghapus data yang kosong berdasarkan kolom start_station_id
DELETE FROM cleaned_annual_tripdata
WHERE start_station_id IS NULL;

--menghapus data yang kosong berdasarkan kolom end_station_name
DELETE FROM cleaned_annual_tripdata
WHERE end_station_name IS NULL;

--menghapus data yang kosong berdasarkan kolom end_station_id
DELETE FROM cleaned_annual_tripdata
WHERE end_station_id IS NULL;

--menghapus data yang kosong berdasarkan kolom end_lat
DELETE FROM cleaned_annual_tripdata
WHERE end_lat IS NULL;

--cek lagi data yang ksong
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
FROM cleaned_annual_tripdata; --baris sudah tidak ada yang kosong

--menambahkan tabel length_ride ke tabel cleaned_annual_tripdata
ALTER TABLE cleaned_annual_tripdata ADD COLUMN ride_length;


UPDATE cleaned_annual_tripdata
SET ride_length = (
	SELECT 
    printf('%02d:%02d:%02d',
        (strftime('%s', ended_at) - strftime('%s', started_at)) / 3600,
        ((strftime('%s', ended_at) - strftime('%s', started_at)) % 3600) / 60,
        (strftime('%s', ended_at) - strftime('%s', started_at)) % 60
    ) 
	FROM cleaned_annual_tripdata as data
	WHERE cleaned_annual_tripdata.ride_id= data.ride_id
		AND(strftime('%s', data.ended_at) - strftime('%s', data.started_at)) / 60 > 1
		AND(strftime('%s', data.ended_at) - strftime('%s', data.started_at)) / 60 < 1440
);

--menambahkan tabel day_of_week ke table cleaned_annual_tripdata
ALTER TABLE cleaned_annual_tripdata ADD COLUMN day_of_week DATETIME;

UPDATE cleaned_annual_tripdata
SET day_of_week=CASE
	WHEN strftime( '%w', started_at)='0' THEN 'Sunday'
	WHEN strftime( '%w', started_at)='1' THEN 'Monday'
	WHEN strftime( '%w', started_at)='2' THEN 'Tuesday'
	WHEN strftime( '%w', started_at)='3' THEN 'Wednesday'
	WHEN strftime( '%w', started_at)='4' THEN 'Thursday'
	WHEN strftime( '%w', started_at)='5' THEN 'Friday'
	WHEN strftime( '%w', started_at)='6' THEN 'Saturday'	
END;

--menambahkan kolom month ke tabel cleaned_annual_tripdata
ALTER TABLE cleaned_annual_tripdata ADD COLUMN month_name DATETIME;

UPDATE cleaned_annual_tripdata
SET month_name= CASE
	WHEN strftime('%m', started_at)='01' THEN 'Jan'
	WHEN strftime('%m', started_at)='02' THEN 'Feb'
	WHEN strftime('%m', started_at)='03' THEN 'Mar'
	WHEN strftime('%m', started_at)='04' THEN 'Apr'
	WHEN strftime('%m', started_at)='05' THEN 'Mei'
	WHEN strftime('%m', started_at)='06' THEN 'Jun'
	WHEN strftime('%m', started_at)='07' THEN 'Jul'
	WHEN strftime('%m', started_at)='08' THEN 'Ags'
	WHEN strftime('%m', started_at)='09' THEN 'Sep'
	WHEN strftime('%m', started_at)='10' THEN 'Okt'
	WHEN strftime('%m', started_at)='11' THEN 'Nov'
	WHEN strftime('%m', started_at)='12' THEN 'Des'
END;

SELECT * from cleaned_annual_tripdata;

PRAGMA table_info(cleaned_annual_tripdata);





