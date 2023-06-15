CREATE DATABASE MovieDB;

GO

USE MovieDB;

-- tables
-- Table: actors
CREATE TABLE actors (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    gender char(1)  NOT NULL,
    CONSTRAINT actors_pk PRIMARY KEY  (id)
);

-- Table: directors
CREATE TABLE directors (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT directors_pk PRIMARY KEY  (id)
);

-- Table: genres
CREATE TABLE genres (
    id int  NOT NULL,
    description varchar(50)  NOT NULL,
    CONSTRAINT genres_pk PRIMARY KEY  (id)
);

-- Table: movie_cast
CREATE TABLE movie_cast (
    actor_id int  NOT NULL,
    movie_id int  NOT NULL,
    role varchar(50)  NOT NULL,
    CONSTRAINT movie_cast_pk PRIMARY KEY  (actor_id,movie_id)
);

-- Table: movies
CREATE TABLE movies (
    id int  NOT NULL,
    title varchar(50)  NOT NULL,
    year int  NOT NULL,
    language varchar(50)  NOT NULL,
    duration int  NOT NULL,
    director_id int  NOT NULL,
    genre_id int  NOT NULL,
    CONSTRAINT movies_pk PRIMARY KEY  (id)
);

-- Table: ratings
CREATE TABLE ratings (
    reviewer_id int  NOT NULL,
    movie_id int  NOT NULL,
    stars int  NOT NULL,
    comment varchar(255)  NOT NULL,
    CONSTRAINT ratings_pk PRIMARY KEY  (reviewer_id,movie_id)
);

-- Table: reviewers
CREATE TABLE reviewers (
    id int  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT reviewers_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: movie_casting_actors (table: movie_cast)
ALTER TABLE movie_cast ADD CONSTRAINT movie_casting_actors
    FOREIGN KEY (actor_id)
    REFERENCES actors (id);

-- Reference: movie_casting_movies (table: movie_cast)
ALTER TABLE movie_cast ADD CONSTRAINT movie_casting_movies
    FOREIGN KEY (movie_id)
    REFERENCES movies (id);

-- Reference: movies_directors (table: movies)
ALTER TABLE movies ADD CONSTRAINT movies_directors
    FOREIGN KEY (director_id)
    REFERENCES directors (id);

-- Reference: movies_genres (table: movies)
ALTER TABLE movies ADD CONSTRAINT movies_genres
    FOREIGN KEY (genre_id)
    REFERENCES genres (id);

-- Reference: rating_movies (table: ratings)
ALTER TABLE ratings ADD CONSTRAINT rating_movies
    FOREIGN KEY (movie_id)
    REFERENCES movies (id);

-- Reference: rating_reviewers (table: ratings)
ALTER TABLE ratings ADD CONSTRAINT rating_reviewers
    FOREIGN KEY (reviewer_id)
    REFERENCES reviewers (id);

insert into genres(id, description) values(1, 'Drama');
insert into genres(id, description) values(2, 'Comedia');
insert into genres(id, description) values(3, 'Terror');
insert into genres(id, description) values(4, 'Ciencia ficción');
insert into genres(id, description) values(5, 'Musical');


insert into reviewers(id, name) values (1,'Luis Campos');
insert into reviewers(id, name) values (2,'Vilma Becerra');
insert into reviewers(id, name) values (3,'Julio Noriega');
insert into reviewers(id, name) values (4,'Marcos Rivera');
insert into reviewers(id, name) values (5,'Amanda Ruiz');
insert into reviewers(id, name) values (6,'Enrique Contreras');

insert into directors(id,name) values (1, 'Christopher Nolan')
insert into directors(id,name) values (2, 'Sofia Coppola')
insert into directors(id,name) values (3, 'Martin Scorsese')

insert into movies( id,year,title, language, duration, director_id, genre_id) values(1,2020,'Inception', 'English',120, 1,4)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(2,1998,'Following', 'English',120, 1,4)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(3,2000,'Memento', 'English',120, 1,4)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(4,2003,'Lost in Translation', 'English',120, 2,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(5,2003,'Somewhere', 'English',120, 2,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(6,1999,'The Virgin Suicides', 'English',120, 2,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(7,2003,'Casino', 'English',120, 3,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(8,1980,'Raging Bull', 'English',120, 3,1)
insert into movies( id,year,title, language, duration, director_id, genre_id) values(9,2016,'Silence', 'English',120, 3,1)


insert into ratings(reviewer_id, movie_id, stars, comment) values (1,1,3, 'Buena película')
insert into ratings(reviewer_id, movie_id, stars, comment) values (1,2,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,1,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,2,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,1,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,3,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,4,5, 'Excelente')

insert into ratings(reviewer_id, movie_id, stars, comment) values (1,5,3, 'Buena película')
insert into ratings(reviewer_id, movie_id, stars, comment) values (1,6,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,5,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (2,6,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,5,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,6,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (3,7,5, 'Excelente')

insert into ratings(reviewer_id, movie_id, stars, comment) values (4,5,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (4,6,5, 'Excelente')
insert into ratings(reviewer_id, movie_id, stars, comment) values (5,6,3, 'Buena película')
insert into ratings(reviewer_id, movie_id, stars, comment) values (5,5,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (6,6,4, 'Excelentes actuaciones')
insert into ratings(reviewer_id, movie_id, stars, comment) values (6,7,4, 'Excelentes actuaciones')
go
-- End of file.
