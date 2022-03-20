CREATE DATABASE IF NOT EXISTS cineStudi;

USE cineStudi;

#
# Création des tables sans les liaisons
#
CREATE TABLE IF NOT EXISTS Administrators
(
    id           VARCHAR(36)  NOT NULL PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    email        VARCHAR(32) NOT NULL,
    password     BINARY(64)  NOT NULL,
    isSuperAdmin BOOLEAN     NOT NULL
);
CREATE TABLE IF NOT EXISTS Complexes
(
    id      VARCHAR(36)   NOT NULL PRIMARY KEY,
    name    VARCHAR(128) NOT NULL,
    address VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Rooms
(
    id          VARCHAR(36) NOT NULL PRIMARY KEY,
    number      INTEGER    NOT NULL,
    seatNumner  INTEGER    NOT NULL,
    description VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Seances
(
    id        VARCHAR(36) NOT NULL PRIMARY KEY,
    startTime TIME       NOT NULL
);
CREATE TABLE IF NOT EXISTS Films
(
    id          VARCHAR(36)  NOT NULL PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    description VARCHAR(255),
    duration    INTEGER     NOT NULL,
    image       VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Tarifs
(
    id          VARCHAR(36)   NOT NULL PRIMARY KEY,
    description VARCHAR(128) NOT NULL,
    price       INTEGER      NOT NULL
);
CREATE TABLE IF NOT EXISTS Reservations
(
    id      VARCHAR(36) NOT NULL PRIMARY KEY,
    prePaid BOOLEAN    NOT NULL,
    isPaid  BOOLEAN    NOT NULL
);
CREATE TABLE IF NOT EXISTS Customers
(
    id      VARCHAR(36)  NOT NULL PRIMARY KEY,
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
# Relation Reservations <-> Customers
ALTER TABLE Reservations
    ADD customerId VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (customerId) REFERENCES Customers (id);
# Relation Complexes <-> Rooms
CREATE TABLE IF NOT EXISTS Complexes_Rooms
(
    complexeId VARCHAR(36) NOT NULL,
    roomId     VARCHAR(36) NOT NULL,
    PRIMARY KEY (complexeId, roomId),
    FOREIGN KEY (complexeId) REFERENCES Complexes (id),
    FOREIGN KEY (roomId) REFERENCES Rooms (id)
);
# Relation Rooms <-> Séances
CREATE TABLE IF NOT EXISTS Rooms_Seances
(
    roomId   VARCHAR(36),
    seanceId VARCHAR(36),
    PRIMARY KEY (roomId, seanceId),
    FOREIGN KEY (roomId) REFERENCES Rooms (id),
    FOREIGN KEY (seanceId) REFERENCES Seances (id)
);
# Relation Seance <-> Films
CREATE TABLE IF NOT EXISTS Seances_Films
(
    seanceId VARCHAR(36),
    filmsId  VARCHAR(36),
    PRIMARY KEY (seanceId, filmsId),
    FOREIGN KEY (seanceId) REFERENCES Seances (id),
    FOREIGN KEY (filmsId) REFERENCES Films (id)
);
# Relation Reservations <-> Seances
ALTER TABLE Reservations
    ADD seanceId VARCHAR(36) NOT NULL,
    ADD FOREIGN KEY (seanceId) REFERENCES Seances (id);