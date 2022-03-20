CREATE DATABASE IF NOT EXISTS cineStudi;

USE cineStudi;

#
# Création des tables sans les liaisons
#
CREATE TABLE IF NOT EXISTS Administrators
(
    id           VARCHAR(36) NOT NULL PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    email        VARCHAR(32) NOT NULL,
    password     BINARY(64)  NOT NULL,
    isSuperAdmin BOOLEAN     NOT NULL
);
CREATE TABLE IF NOT EXISTS Complexes
(
    id      VARCHAR(36)  NOT NULL PRIMARY KEY,
    name    VARCHAR(128) NOT NULL,
    address VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Rooms
(
    id          VARCHAR(36) NOT NULL PRIMARY KEY,
    number      INTEGER     NOT NULL,
    seatNumner  INTEGER     NOT NULL,
    description VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Seances
(
    id        VARCHAR(36) NOT NULL PRIMARY KEY,
    startTime TIME        NOT NULL
);
CREATE TABLE IF NOT EXISTS Films
(
    id          VARCHAR(36) NOT NULL PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    description VARCHAR(255),
    duration    INTEGER     NOT NULL,
    image       VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Tarifs
(
    id          VARCHAR(36)  NOT NULL PRIMARY KEY,
    description VARCHAR(128) NOT NULL,
    price       INTEGER      NOT NULL
);
CREATE TABLE IF NOT EXISTS Reservations
(
    id      VARCHAR(36) NOT NULL PRIMARY KEY,
    prePaid BOOLEAN     NOT NULL,
    isPaid  BOOLEAN     NOT NULL
);
CREATE TABLE IF NOT EXISTS Customers
(
    id      VARCHAR(36) NOT NULL PRIMARY KEY,
    name    VARCHAR(32) NOT NULL,
    address VARCHAR(255),
    email   VARCHAR(32) NOT NULL
);

#
# Ajout des liaisons simples
#
# Relation Administrators <-> Complexes
ALTER TABLE Administrators
    ADD complexId VARCHAR(36),
    ADD FOREIGN KEY (complexId) REFERENCES Complexes (id);
# Relation Complexes <-> Rooms
CREATE TABLE Complexes_Rooms
(
    complexeId VARCHAR(36) NOT NULL,
    roomId     VARCHAR(36) NOT NULL,
    PRIMARY KEY (complexeId, roomId),
    FOREIGN KEY (complexeId) REFERENCES Complexes (id),
    FOREIGN KEY (roomId) REFERENCES Rooms (id)
);
# Relation Films <-> Rooms
ALTER TABLE Rooms
    ADD filmId VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (filmId) REFERENCES Films (id);
#Relation Films <-> Séances
ALTER TABLE Seances
    ADD filmId VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (filmId) REFERENCES Films (id);
#Relation Rooms_Reservations
ALTER TABLE Reservations
    ADD roomId VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (roomId) REFERENCES Rooms (id);
#Relation Seance <-> Reservation
#Relation Customer <-> Reservation
ALTER TABLE Reservations
    ADD seanceId   VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (seanceId) REFERENCES Seances (id),
    ADD customerId VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (customerId) REFERENCES Customers (id);
#Relation Tarif <-> Reservation
CREATE TABLE IF NOT EXISTS tarif_reservation
(
    tarifId       VARCHAR(36) NOT NULL,
    reservationId VARCHAR(36),
    PRIMARY KEY (tarifId, reservationId),
    FOREIGN KEY (tarifId) REFERENCES Tarifs (id),
    FOREIGN KEY (reservationId) REFERENCES Reservations (id)
);
