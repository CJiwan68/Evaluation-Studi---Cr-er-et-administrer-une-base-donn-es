CREATE DATABASE IF NOT EXISTS cineStudi;

USE cineStudi;

#
# Création des tables sans les liaisons
#
CREATE TABLE IF NOT EXISTS Administrators
(
    id           BINARY(16)  NOT NULL PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    email        VARCHAR(32) NOT NULL,
    password     BINARY(64)  NOT NULL,
    isSuperAdmin BOOLEAN     NOT NULL
);
CREATE TABLE IF NOT EXISTS Complexes
(
    id      BINARY(16)   NOT NULL PRIMARY KEY,
    name    VARCHAR(128) NOT NULL,
    address VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Rooms
(
    id          BINARY(16) NOT NULL PRIMARY KEY,
    number      INTEGER    NOT NULL,
    seatNumner  INTEGER    NOT NULL,
    description VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Seances
(
    id        BINARY(16) NOT NULL PRIMARY KEY,
    startTime TIME       NOT NULL
);
CREATE TABLE IF NOT EXISTS Films
(
    id          BINARY(16)  NOT NULL PRIMARY KEY,
    name        VARCHAR(64) NOT NULL,
    description VARCHAR(255),
    duration    INTEGER     NOT NULL,
    image       VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Tarifs
(
    id          BINARY(16)   NOT NULL PRIMARY KEY,
    description VARCHAR(128) NOT NULL,
    price       INTEGER      NOT NULL
);
CREATE TABLE IF NOT EXISTS Reservations
(
    id      BINARY(16) NOT NULL PRIMARY KEY,
    prePaid BOOLEAN    NOT NULL,
    isPaid  BOOLEAN    NOT NULL
);
CREATE TABLE IF NOT EXISTS Customers
(
    id      BINARY(16)  NOT NULL PRIMARY KEY,
    name    VARCHAR(32) NOT NULL,
    address VARCHAR(255),
    email   VARCHAR(32) NOT NULL
);

#
# Ajout des liaisons simples
#
# Relation Administrators <-> Complexes
ALTER TABLE Administrators
    ADD complexId BINARY(16),
    ADD FOREIGN KEY (complexId) REFERENCES Complexes (id);
# Relation Reservations <-> Customers
ALTER TABLE Reservations
    ADD customerId BINARY(16) NOT NULL,
    ADD FOREIGN KEY (customerId) REFERENCES Customers (id);
# Relation Complexes <-> Rooms
CREATE TABLE IF NOT EXISTS Complexes_Rooms
(
    complexeId BINARY(16) NOT NULL,
    roomId     BINARY(16) NOT NULL,
    PRIMARY KEY (complexeId, roomId),
    FOREIGN KEY (complexeId) REFERENCES Complexes (id),
    FOREIGN KEY (roomId) REFERENCES Rooms (id)
);
# Relation Rooms <-> Séances
CREATE TABLE IF NOT EXISTS Rooms_Seances
(
    roomId   BINARY(16),
    seanceId BINARY(16),
    PRIMARY KEY (roomId, seanceId),
    FOREIGN KEY (roomId) REFERENCES Rooms (id),
    FOREIGN KEY (seanceId) REFERENCES Seances (id)
);
# Relation Seance <-> Films
CREATE TABLE IF NOT EXISTS Seances_Films
(
    seanceId BINARY(16),
    filmsId  BINARY(16),
    PRIMARY KEY (seanceId, filmsId),
    FOREIGN KEY (seanceId) REFERENCES Seances (id),
    FOREIGN KEY (filmsId) REFERENCES Films (id)
);
# Relation Reservations <-> Seances
ALTER TABLE Reservations
    ADD seanceId BINARY(16) NOT NULL,
    ADD FOREIGN KEY (seanceId) REFERENCES Seances (id);