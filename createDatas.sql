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

# Création des salles & liens avec les complexes
INSERT INTO Rooms(id, number, seatNumner, description)
VALUES (UUID(),
        1,
        150,
        'Salle 3D'),
       (UUID(),
        2,
        250,
        'Salle IMAX'),
       (UUID(),
        3,
        100,
        'Salle ICE'),
       (UUID(),
        4,
        100,
        'Salle Standard'),
       (UUID(),
        5,
        350,
        'Grande salle 3D');

# Liaison salles <-> Complexes
# Récupération des ID des salles
SELECT @rooms_1_ID := id
FROM Rooms
WHERE Rooms.number = 1;
SELECT @rooms_2_ID := id
FROM Rooms
WHERE Rooms.number = 2;
SELECT @rooms_3_ID := id
FROM Rooms
WHERE Rooms.number = 3;
SELECT @rooms_4_ID := id
FROM Rooms
WHERE Rooms.number = 4;
SELECT @rooms_5_ID := id
FROM Rooms
WHERE Rooms.number = 5;
# Récupération ID du 1er complexe
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Turckheim';
# Création des liaisons
INSERT INTO complexes_rooms (complexeId, roomId)
VALUES (@complexeID, @rooms_1_ID),
       (@complexeID, @rooms_2_ID),
       (@complexeID, @rooms_3_ID),
       (@complexeID, @rooms_4_ID),
       (@complexeID, @rooms_5_ID);
# Récupération ID du 2eme complexe
SELECT @complexeID := id
FROM Complexes
WHERE Complexes.name = 'CGR Colmar';
# Création des liaisons
INSERT INTO complexes_rooms(complexeId, roomId)
VALUES (@complexeID, @rooms_1_ID),
       (@complexeID, @rooms_2_ID),
       (@complexeID, @rooms_3_ID);

# Création des séances
INSERT INTO Seances(id, startTime)
VALUES (UUID(),
        TIME("09:00:00")),
       (UUID(),
        TIME("11:00:00")),
       (UUID(),
        TIME("13:00:00")),
       (UUID(),
        TIME("15:00:00")),
       (UUID(),
        TIME("17:00:00")),
       (UUID(),
        TIME("19:00:00")),
       (UUID(),
        TIME("21:00:00")),
       (UUID(),
        TIME("23:00:00"));

#Création des films
INSERT INTO Films(id, name, description, duration)
VALUES (UUID(),
        'L\'Homme de Dieu',
        'Exilé injustement, condamné sans jugement, calomnié sans motif. La ve, les épreuves et les tribulations d\'un homme de Dieu, Saint Nectarios d\'Egine.....',
        110),
       (UUID(),
        'Le chêne',
        'Il était une fois l\'histoire d\'un chêne, vieux de 210 ans, devenu un pilier en son royaume. Ce film d\'aventure spectaculaire rassemble un casting hors du commun :.....',
        80),
       (UUID(),
        'Uncharted',
        'Nathan Drake, voleur astucieux et intrépide, est recruté par le chasseur de trésors chevronné, .....',
        116);

# Relations Films séances
# Récupération de l'Id du 1er films
SELECT @filmsID := id
FROM Films
WHERE Films.name = 'L\'Homme de Dieu';
INSERT INTO seances_films(seanceId, filmsId)
VALUES ((SELECT id FROM Seances WHERE startTime = TIME("09:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("11:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("13:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("15:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("17:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("19:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("21:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("23:00:00") LIMIT 1),
        @filmsID);
# Second film
SELECT @filmsID := id
FROM Films
WHERE Films.name = 'Le chêne';
INSERT INTO seances_films(seanceId, filmsId)
VALUES ((SELECT id FROM Seances WHERE startTime = TIME("09:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("11:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("13:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("15:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("17:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("19:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("21:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("23:00:00") LIMIT 1),
        @filmsID);
# Troisième film
SELECT @filmsID := id
FROM Films
WHERE Films.name = 'Uncharted';
INSERT INTO seances_films(seanceId, filmsId)
VALUES ((SELECT id FROM Seances WHERE startTime = TIME("09:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("13:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("17:00:00") LIMIT 1),
        @filmsID),
       ((SELECT id FROM Seances WHERE startTime = TIME("21:00:00") LIMIT 1),
        @filmsID);

# Création des liaison salles <-> séances
# Récupération de l'Id du 1er films
SELECT @filmsID := id
FROM Films
WHERE Films.name = 'L\'Homme de Dieu';
SELECT @roomsID := id FROM Rooms WHERE Rooms.number = 4;
FOREACH(
    'SELECT seanceId FROM seances_films WHERE seances_films.id = @filmID',
    'INSERT INTO rooms_seances(roomId, seanceId)
    VALUES(@roomsID,${1})'
    );