INSERT INTO Refined.Dim_Album (album_key, album_id, album_name, album_release_date, start_date, end_date, active, load_date)
SELECT nextval('Refined.album_key_seq'),
       album_id,
       album_name,
       album_release_date,
       start_date,
       end_date,
       active,
       CURRENT_DATE
FROM Raw.album;


INSERT INTO Refined.Dim_Playlist (playlist_key, playlist_id, playlist_name, playlist_genre, playlist_subgenre, start_date, end_date, active, load_date)
SELECT nextval('Refined.playlist_key_seq'),
       playlist_id,
       playlist_name,
       playlist_genre,
       playlist_subgenre,
       start_date,
       end_date,
       active,
       CURRENT_DATE
FROM Raw.Playlist;


INSERT INTO Refined.Dim_Track (track_key, track_id, track_name, track_artist, track_popularity, danceability, energy, KEY, loudness, MODE, speechiness, acousticness, instrumentalness, liveness, valence, tempo, duration_ms, start_date, end_date, active, load_date)
SELECT nextval('Refined.track_key_seq'),
       track_id,
       track_name,
       track_artist,
       track_popularity,
       danceability,
       energy,
       KEY,
       loudness,
       MODE,
       speechiness,
       acousticness,
       instrumentalness,
       liveness,
       valence,
       tempo,
       duration_ms,
       start_date,
       end_date,
       active,
       CURRENT_DATE
FROM Raw.track;

WITH series AS
  (SELECT generate_series(CURRENT_DATE, CURRENT_DATE + interval '1 year', interval '1 day') AS generated_date)
INSERT INTO Refined.Dim_Date (date_key, date_date, date_day, date_month, date_year, date_name)
SELECT nextval('Refined.date_key_seq'),
       generated_date,
       EXTRACT(DAY
               FROM generated_date),
       EXTRACT(MONTH
               FROM generated_date),
       EXTRACT(YEAR
               FROM generated_date),
       to_char(generated_date, 'Day')
FROM series;


INSERT INTO refined.Fct_Tracks
SELECT track_key,
       album_key,
       playlist_key,
       date_key
FROM
  (SELECT DISTINCT ret.track_key AS track_key,
                   ral.album_key AS album_key,
                   rpl.playlist_key AS playlist_key,
                   red.date_key AS date_key
   FROM raw.track rat,
        refined.dim_track ret,
        refined.dim_album ral,
        refined.dim_playlist rpl,
        refined.dim_date red
   WHERE rat.track_album_id = ral.album_id
     AND rat.track_id = ret.track_id
     AND rat.playlist_id = rpl.playlist_id
     AND red.date_date = CURRENT_DATE ) s
ORDER BY track_key,
         album_key,
         playlist_key,
         date_key;