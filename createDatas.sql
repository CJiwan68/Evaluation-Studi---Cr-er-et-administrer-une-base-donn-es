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
SELECT @complexeID := id FROM Complexes WHERE Complexes.name='CGR Turckheim';
INSERT INTO Administrators(id, name, email, password, isSuperAdmin, complexId)
VALUES (UUID(),
        'Maurice',
        'Maurice@email.com',
        MD5('Maurice'),
        false,
        @complexeID);
SELECT @complexeID := id FROM Complexes WHERE Complexes.name='CGR Colmar';
INSERT INTO Administrators(id, name, email, password, isSuperAdmin, complexId)
VALUES (UUID(),
        'Albert',
        'Albert@emaim.com',
        MD5('Albert'),
        false,
        @complexeID);




