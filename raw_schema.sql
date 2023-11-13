CREATE SCHEMA Raw;

CREATE TABLE Raw.Artist (
    artist_name varchar(100) not null,
    start_date date,
    end_date date,
    active char(1),
    PRIMARY KEY (artist_name)
);

CREATE TABLE Raw.Album (
    album_id varchar(30) not null,
    album_name varchar(200) not null,
    album_release_date date,
    start_date date,
    end_date date,
    active char(1),
    PRIMARY KEY (album_id)
);

CREATE TABLE Raw.Genre (
    genre_name varchar(30) not null,
    start_date date,
    end_date date,
    active char(1),
    PRIMARY KEY (genre_name)
);

CREATE TABLE Raw.Playlist (
    playlist_id varchar(200) not null,
    playlist_name varchar(200) not null,
    playlist_genre varchar(100) not null,
    playlist_subgenre varchar(100) not null,
    start_date date,
    end_date date,
    active char(1),
    PRIMARY KEY (playlist_id),
    CONSTRAINT FK_Track_Genre FOREIGN KEY (playlist_genre) REFERENCES Raw.Genre (genre_name),
    CONSTRAINT FK_Track_SubGenre FOREIGN KEY (playlist_subgenre) REFERENCES Raw.Genre (genre_name)
);

CREATE TABLE Raw.Track (
    track_id varchar(30) not null,
    track_name varchar(200) not null,
    track_artist varchar(200) not null,
    track_popularity numeric,
    track_album_id varchar(200),
    playlist_id varchar(200),
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
    PRIMARY KEY (track_id),
    CONSTRAINT FK_Track_Artist FOREIGN KEY (track_artist) REFERENCES Raw.Artist (artist_name),
    CONSTRAINT FK_Track_AlbumID FOREIGN KEY (track_album_id) REFERENCES Raw.Album (album_id),
    CONSTRAINT FK_Track_PlaylistID FOREIGN KEY (playlist_id) REFERENCES Raw.Playlist (playlist_id)
);

