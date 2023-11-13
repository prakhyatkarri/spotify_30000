-- How many Albums got released in the last 3 years

select count(1) from refined.fct_tracks f, refined.dim_album al
where f.album_key = al.album_key
and extract(year from al.album_release_date) >= (extract(year from current_date) - 3)

-- Top 10 popular songs in the last 3 years

select t.track_name, t.track_popularity from refined.fct_tracks f, refined.dim_track t
where f.track_key = t.track_key
and extract(year from t.load_date) >= (extract(year from current_date) - 3)
order by t.track_popularity desc
limit 10;

-- Top 5 Popular Artists in the last 5 years

select t.track_name, t.track_artist from refined.fct_tracks f, refined.dim_track t
where f.track_key = t.track_key
and extract(year from t.load_date) >= (extract(year from current_date) - 5)
order by t.track_popularity desc
limit 5;

-- Top 20 longest songs ever

select t.track_name, round((t.duration_ms /1000/60), 2) as duration_minutes from refined.fct_tracks f, refined.dim_track t
where f.track_key = t.track_key
order by t.duration_ms desc
limit 20;

-- Top 7 Danceable songs in last 7 years

select t.track_name, round((t.danceability * 10), 2) as danceability from refined.fct_tracks f, refined.dim_track t
where f.track_key = t.track_key
and extract(year from t.load_date) >= (extract(year from current_date) - 7)
order by t.danceability desc
limit 7;
