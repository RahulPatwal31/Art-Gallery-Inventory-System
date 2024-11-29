CREATE DATABASE ArtGalleryInventorySystem;
USE ArtGalleryInventorySystem;

CREATE TABLE Artists(
artist_id INT,
name VARCHAR(50),
birth_date DATE,
nationality VARCHAR(20),
biography VARCHAR(100),
PRIMARY KEY(artist_id));

CREATE TABLE Artworks(
artwork_id INT,
title VARCHAR(50),
artist_id INT,
creation_date DATE,
price INT,
status VARCHAR(20),
description VARCHAR(50),
PRIMARY KEY(artwork_id),
FOREIGN KEY(artist_id) REFERENCES Artists(artist_id));

ALTER TABLE Artworks MODIFY description VARCHAR(200);
ALTER TABLE Artworks MODIFY title VARCHAR(100);

CREATE TABLE Exhibitions(
exhibition_id INT,
name VARCHAR(50),
start_date DATE,
end_date DATE,
location VARCHAR(60),
PRIMARY KEY(exhibition_id));

CREATE TABLE Exhibition_Artworks(
exhibition_id INT,
artwork_id INT,
FOREIGN KEY(exhibition_id) REFERENCES Exhibitions(exhibition_id),
FOREIGN KEY(artwork_id) REFERENCES Artworks(artwork_id));

CREATE TABLE Buyers(
buyer_id INT,
name VARCHAR(50),
contact_details VARCHAR(100),
PRIMARY KEY(buyer_id));

CREATE TABLE Sales(
sale_id INT,
artwork_id INT,
buyer_id INT,
sale_date DATE,
price INT,
PRIMARY KEY(sale_id),
FOREIGN KEY(artwork_id) REFERENCES Artworks(artwork_id),
FOREIGN KEY(buyer_id) REFERENCES Buyers(buyer_id));

ALTER TABLE Sales add price INT;


