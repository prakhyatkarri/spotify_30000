INSERT INTO
  Refined.Dim_Album (
    album_key, 
    album_id, 
    album_name, 
    album_release_date, 
    start_date, 
    end_date, 
    active, 
    load_date
) 
SELECT 
  nextval('Refined.album_key_seq'), 
  album_id, 
  album_name, 
  album_release_date, 
  start_date, 
  end_date, 
  active,
  current_date 
from 
  Raw.album;

INSERT INTO 
  Refined.Dim_Playlist (
	playlist_key,
	playlist_id,
    playlist_name,
    playlist_genre,
    playlist_subgenre,
    start_date,
    end_date,
    active,
    load_date
)
SELECT 
    nextval('Refined.playlist_key_seq'),
    playlist_id,
    playlist_name,
    playlist_genre,
    playlist_subgenre,
    start_date,
    end_date,
    active,
    current_date
from 
  Raw.Playlist;

  INSERT INTO Refined.Dim_Track (
    track_key,
    track_id,
    track_name,
    track_artist,
    track_popularity,
    danceability,
    energy,
    key,
    loudness,
    mode,
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
    load_date
)
SELECT 
  nextval('Refined.track_key_seq'),
  track_id,
  track_name,
  track_artist,
  track_popularity,
  danceability,
  energy,
  key,
  loudness,
  mode,
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
  current_date
FROM
  Raw.track;
  
with 
  series
as (
  SELECT generate_series(current_date, current_date + interval '1 year', interval '1 day') as generated_date
)
INSERT INTO 
  Refined.Dim_Date (
    date_key,
    date_date,
    date_day,
    date_month,
    date_year,
    date_name
)
SELECT
    nextval('Refined.date_key_seq'),
    generated_date,
    EXTRACT(DAY FROM generated_date),
    EXTRACT(MONTH FROM generated_date),
    EXTRACT(YEAR FROM generated_date),
    to_char(generated_date, 'Day')
from 
  series;

insert into refined.Fct_Tracks
select track_key, album_key, playlist_key, date_key from (
select distinct ret.track_key as track_key, ral.album_key as album_key, rpl.playlist_key as playlist_key, red.date_key as date_key
from raw.track rat,
refined.dim_track ret,
refined.dim_album ral,
refined.dim_playlist rpl,
refined.dim_date red
where rat.track_album_id = ral.album_id
and rat.track_id = ret.track_id
and rat.playlist_id = rpl.playlist_id
and red.date_date = current_date
) s
order by track_key, album_key, playlist_key, date_key;