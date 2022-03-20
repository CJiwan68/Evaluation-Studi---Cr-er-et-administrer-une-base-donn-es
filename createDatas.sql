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

