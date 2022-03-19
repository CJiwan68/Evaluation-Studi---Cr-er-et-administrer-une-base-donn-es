CREATE DATABASE IF NOT EXISTS cineStudi;

USE cineStudi;
#
# Création des tables sans les liaisons
#
CREATE TABLE IF NOT EXISTS Administrators
(
    id           BINARY(16) PRIMARY KEY,
    name         VARCHAR(32) NOT NULL,
    email        VARCHAR(32) NOT NULL,
    password     BINARY(64)  NOT NULL,
    isSuperAdmin BOOLEAN     NOT NULL
);
CREATE TABLE IF NOT EXISTS Complexs
(
    id      BINARY(16) PRIMARY KEY,
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

#
# Ajout des liaisons simples
#
