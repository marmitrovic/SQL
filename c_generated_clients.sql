DROP DATABASE IF EXISTS cTestDB;
CREATE DATABASE cTestDB;
USE cTestDB;

CREATE TABLE client (
    clientId INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO client (clientId, firstName, lastName, phone) VALUES (1, 'Carlos', 'Gomez', '611000101');
INSERT INTO client (clientId, firstName, lastName, phone) VALUES (2, 'Javier', 'Ruiz', '611000102');
INSERT INTO client (clientId, firstName, lastName, phone) VALUES (3, 'Miguel', 'Torres', '611000103');

SELECT * FROM client;
