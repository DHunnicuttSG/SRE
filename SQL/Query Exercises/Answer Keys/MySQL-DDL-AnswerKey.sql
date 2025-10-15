CREATE DATABASE IF NOT EXISTS MovieCatalogue;


USE MovieCatalogue;


CREATE TABLE IF NOT EXISTS Genre (
	GenreID int not null auto_increment,
	GenreName varchar(30) not null,
    PRIMARY KEY (GenreID)
);

CREATE TABLE IF NOT EXISTS Rating (
	RatingID int not null auto_increment,
	RatingName varchar(5) not null,
    PRIMARY KEY (RatingID)
);

CREATE TABLE IF NOT EXISTS Director (
	DirectorID int not null auto_increment,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	BirthDate date null,
    PRIMARY KEY (DirectorID)
);

CREATE TABLE IF NOT EXISTS Actor (
	ActorID  int not null auto_increment,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	BirthDate date null,
    PRIMARY KEY (ActorID)
);

CREATE TABLE IF NOT EXISTS Movie (
	MovieID int not null auto_increment,
	GenreID int not null,
	DirectorID int null,
	RatingID int null,
	Title varchar(128) not null,
	ReleaseDate date null,
    PRIMARY KEY (MovieID)
);


ALTER TABLE Movie
 ADD CONSTRAINT fk_MovieGenre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);
ALTER TABLE Movie
 ADD CONSTRAINT fk_MovieDirector FOREIGN KEY (DirectorID) REFERENCES Director(DirectorID);
ALTER TABLE Movie
 ADD CONSTRAINT fk_MovieRating FOREIGN KEY (RatingID) REFERENCES Rating(RatingID);

CREATE TABLE IF NOT EXISTS CastMember (
	CastMemberID int not null auto_increment,
	ActorID int not null,
	MovieID int not null,
	Role varchar(50) not null,
    PRIMARY KEY (CastMemberID)
);

ALTER TABLE CastMember
 ADD CONSTRAINT fkCastMemberActor FOREIGN KEY (ActorID) REFERENCES Actor(ActorID);

ALTER TABLE CastMember
 ADD CONSTRAINT fkCastMemberMovie FOREIGN KEY (MovieID) REFERENCES Movie(MovieID);