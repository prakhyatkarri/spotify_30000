CREATE SCHEMA Refined;

CREATE SEQUENCE Refined.Album_Key_Seq START 1001;

CREATE TABLE Refined.Dim_Album (
	album_key numeric not null,
    album_id varchar(30) not null,
    album_name varchar(200) not null,
    album_release_date date,
    start_date date,
    end_date date,
    active char(1),
    load_date date,
    PRIMARY KEY (album_key)
);

CREATE SEQUENCE Refined.Playlist_Key_Seq START 2001;

CREATE TABLE Refined.Dim_Playlist (
	playlist_key numeric not null,
    playlist_id varchar(200) not null,
    playlist_name varchar(200) not null,
    playlist_genre varchar(100) not null,
    playlist_subgenre varchar(100) not null,
    start_date date,
    end_date date,
    active char(1),
    load_date date,
    PRIMARY KEY (playlist_key)
);

CREATE SEQUENCE Refined.Track_Key_Seq START 3001;

CREATE TABLE Refined.Dim_Track (
    track_key numeric not null,
    track_id varchar(30) not null,
    track_name varchar(200) not null,
    track_artist varchar(200) not null,
    track_popularity numeric,
    danceability numeric,
    energy numeric,
    key numeric,
    loudness numeric,
    mode numeric(1),
    speechiness numeric,
    acousticness numeric,
    instrumentalness varchar(50),
    liveness numeric,
    valence numeric,
    tempo numeric,
    duration_ms numeric,
    start_date date,
    end_date date,
    active char(1),
    load_date date,
    PRIMARY KEY (track_key)
);

CREATE SEQUENCE Refined.Date_Key_Seq START 4001;

CREATE TABLE Refined.Dim_Date (
    date_key numeric not null,
    date_date date not null,
    date_day numeric not null,
    date_month numeric not null,
    date_year numeric not null,
    date_name varchar(10) not null,
    PRIMARY KEY (date_key)
);

CREATE SEQUENCE Refined.Tracks_Key_Seq START 5001;

CREATE TABLE Refined.Fct_Tracks (
    track_key numeric not null,
    album_key numeric not null,
    playlist_key numeric not null,
    date_key numeric not null,
	CONSTRAINT FK_Fct_Track_Album FOREIGN KEY (album_key) REFERENCES Refined.Dim_Album (album_key),
	CONSTRAINT FK_Fct_Track_Playlist FOREIGN KEY (playlist_key) REFERENCES Refined.Dim_Playlist (playlist_key),
	CONSTRAINT FK_Fct_Track_Date FOREIGN KEY (date_key) REFERENCES Refined.Dim_Date (date_key)
); 
