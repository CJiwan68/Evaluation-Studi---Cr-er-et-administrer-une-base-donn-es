USE cinestudi;

# Création des complexes
INSERT INTO Complexes (id, name, address)
VALUES (UUID(),
        'CGR Turckheim',
        'Turckheim Centre');
INSERT INTO Complexes (id, name, address)
VALUES (UUID(),
        'CGR Colmar',
        'Colmar Centre');

# Création d'administateur
# Un SuperAdministrateurs
INSERT INTO Administrators (id, name, email, password, isSuperAdmin)
VALUES (UUID(),
        'Christian',
        'Christian@email.com',
        MD5('MotDePasse'),
        true);
# Administrateur d'un complexe
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Turckheim';
INSERT INTO Administrators(id, name, email, password, isSuperAdmin, complexId)
VALUES (UUID(),
        'Maurice',
        'Maurice@email.com',
        MD5('Maurice'),
        false,
        @complexeID);
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Colmar';
INSERT INTO Administrators(id, name, email, password, isSuperAdmin, complexId)
VALUES (UUID(),
        'Albert',
        'Albert@emaim.com',
        MD5('Albert'),
        false,
        @complexeID);

# Création des salles & liens avec les complexes pour le 1er Complexe
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Turckheim';
INSERT INTO Rooms(id, number, seatNumner, description, complexeId)
VALUES (UUID(),
        1,
        150,
        'Salle 3D', @complexeID),
       (UUID(),
        4,
        100,
        'Salle Standard', @complexeID);
# Création des salles & liens avec les complexes pour le 2eme Complexe
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Colmar';
INSERT INTO Rooms(id, number, seatNumner, description, complexeId)
VALUES (UUID(),
        1,
        150,
        'Salle 3D', @complexeID),
       (UUID(),
        2,
        250,
        'Salle IMAX', @complexeID),
       (UUID(),
        3,
        100,
        'Salle ICE', @complexeID),
       (UUID(),
        4,
        100,
        'Salle Standard', @complexeID),
       (UUID(),
        5,
        350,
        'Grande salle', @complexeID);

# Création des tarifs
INSERT INTO Tarifs (id, description, price)
VALUES (UUID(), 'Adultes', 12),
       (UUID(), 'Enfants', 9),
       (UUID(), 'Pass Culture', 10);

# Création de Clients
INSERT INTO Customers(id, name, address, email)
VALUES (UUID(), 'Doe', 'Unknow Street', 'Doe@email.com'),
       (UUID(), 'Jane', 'Rue de l\'inconnue', 'Jane@email.com'),
       (UUID(), 'Jon', 'WallStreet', 'Jon@email.com');

# Création des Films & Séances
INSERT INTO Films(id, name, description, duration)
VALUES (UUID(),
        'Alors on Danse',
        'Bien décidée à reprendre sa vie en main après avoir découvert les infidélités de son mari, Sandra se réfugie chez sa sœur Danie. A l\'opposé l\'une de l\'autre, elles se retrouvent autour de leur passion commune :....',
        87),
       (UUID(),
        'Notre-Dame Brûle',
        'Le long métrage de Jean-Jacques Annaud, reconstitue heure par heure l\'invresemblable rélité des évènements du 15 avril 2019 lorsque ...',
        110),
       (UUID(),
        'Le temps des secrets',
        'Marseille, juillet 1905. Le jeune Marcel Pagnol vient d\'achever ses études primaires, ....',
        107);

# Création des séances pour 'Alors on Danse'
# Récupération de l'ID du film
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Alors on Danse'
LIMIT 1;
INSERT INTO Seances(id, startTime, filmId)
VALUES (UUID(), TIME('11:00:00'), @filmID),
       (UUID(), TIME('13:55:00'), @filmID),
       (UUID(), TIME('16:00:00'), @filmID),
       (UUID(), TIME('20:10:00'), @filmID);
# Création des séances pour 'Notre-Dame Brûle'
# Récupération de l'ID du film
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Notre-Dame Brûle'
LIMIT 1;
INSERT INTO Seances(id, startTime, filmId)
VALUES (UUID(), TIME('10:50:00'), @filmID),
       (UUID(), TIME('13:30:00'), @filmID),
       (UUID(), TIME('15:50:00'), @filmID),
       (UUID(), TIME('18:05:00'), @filmID),
       (UUID(), TIME('20:20:00'), @filmID),
       (UUID(), TIME('22:10:00'), @filmID);
# Création des séances pour 'Le temps des secrets'
# Récupération de l'ID du film
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Le temps des secrets'
LIMIT 1;
INSERT INTO Seances(id, startTime, filmId)
VALUES (UUID(), TIME('21:00:00'), @filmID);

# Affectation des films aux salles
# Films Alors on Danse - Projeté uniquement à Colmar dans la salle 'Grande salle'
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Alors on Danse'
LIMIT 1;
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Colmar'
LIMIT 1;
UPDATE Rooms
SET filmId = @filmID
WHERE Rooms.description = 'Grande salle'
  AND Rooms.complexeId = @complexeID;
# Films 'Notre-Dame Brûle' projeté dans toutes les salles 3D et salle Ice (Colmar & Turckheim)
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Notre-Dame Brûle'
LIMIT 1;
UPDATE Rooms
SET filmId = @filmID
WHERE Rooms.description = 'Salle 3D'
   OR Rooms.description = 'Salle ICE';
# Films 'Le temps des secrets' projeté uniquement dans les salles standard (Colmar & Turckheim)
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Le temps des secrets'
LIMIT 1;
UPDATE Rooms
SET filmId = @filmID
WHERE Rooms.description = 'Salle Standard';

# Création de réservations
# Pour Doe : Alors on Danse à 13:55:00 à Colmar dans la salle 'Grande Salle'
# 2 Adultes - 1 Enfants
SELECT @customerID := id
FROM Customers
WHERE Customers.name = 'Doe';
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Colmar';
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Alors on Danse';
SELECT @roomID := id
FROM Rooms
WHERE Rooms.complexeId = @complexeID AND Rooms.filmId = @filmID;
SELECT @seanceID := id
FROM Seances
WHERE Seances.startTime = TIME('13:55:00')
  AND Seances.filmId = @filmID;
INSERT INTO Reservations(date, prePaid, isPaid, roomId, seanceId, customerId)
VALUES (DATE('2022-03-26'),
        false,
        true,
        @roomID,
        @seanceID,
        @customerID);
SELECT @lastResaID := LAST_INSERT_ID();
#Ajout des tarifs sélectionné avec le nbr de place.
#Récupération des ID des tarifs
SELECT @adulteID := id FROM Tarifs WHERE Tarifs.description = 'Adultes';
SELECT @enfantID := id FROM Tarifs WHERE Tarifs.description = 'Enfants';
INSERT INTO tarif_reservation (tarifId, reservationId, nbrPlace)
VALUES (@adulteID, @lastResaID, 2),
       (@enfantID, @lastResaID, 1);

SELECT @nbrSiege := seatNumner FROM Rooms WHERE Rooms.id = @roomID;
SELECT SUM(nbrPlace) FROM tarif_reservation
    INNER JOIN Reservations ON Reservations.roomId = @roomID AND Reservations.seanceId = @seanceID AND Reservations.date = DATE('2022-03-26');

# Pour Jane : Alors on Danse à 13:55:00 à Colmar dans la salle 'Grande Salle'
# 1 Adultes - 3 Enfants
SELECT @customerID := id
FROM Customers
WHERE Customers.name = 'Jane';
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Colmar';
SELECT @filmID := id
FROM Films
WHERE Films.name = 'Alors on Danse';
SELECT @roomID := id
FROM Rooms
WHERE Rooms.complexeId = @complexeID AND Rooms.filmId = @filmID;
SELECT @seanceID := id
FROM Seances
WHERE Seances.startTime = TIME('13:55:00')
  AND Seances.filmId = @filmID;
INSERT INTO Reservations(date, prePaid, isPaid, roomId, seanceId, customerId)
VALUES (DATE('2022-03-25'),
        false,
        true,
        @roomID,
        @seanceID,
        @customerID);
SELECT @lastResaID := LAST_INSERT_ID();
#Ajout des tarifs sélectionné avec le nbr de place.
#Récupération des ID des tarifs
SELECT @adulteID := id FROM Tarifs WHERE Tarifs.description = 'Adultes';
SELECT @enfantID := id FROM Tarifs WHERE Tarifs.description = 'Enfants';
INSERT INTO tarif_reservation (tarifId, reservationId, nbrPlace)
VALUES (@adulteID, @lastResaID, 1),
       (@enfantID, @lastResaID, 3);

SELECT @nbrSiege := seatNumner FROM Rooms WHERE Rooms.id = @roomID;
SELECT DISTINCT  * FROM tarif_reservation
    JOIN Reservations ON Reservations.roomId = @roomID AND Reservations.seanceId = @seanceID AND Reservations.date = DATE('2022-03-26');