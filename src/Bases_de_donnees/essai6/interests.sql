DROP TABLE IF EXISTS users_compatible;
DROP TABLE IF EXISTS oeuvre;

CREATE TABLE oeuvre (
    img INT [],
    descrip TEXT,
    couleurs TEXT,
    dimensions TEXT
);

CREATE TABLE users_compatible (
    id INT,
    email TEXT,
    mdp TEXT,
    nom TEXT,
    avatar TEXT,
    palette INT,
    oeuvres oeuvre [],
    aimees oeuvre [],
    compat DECIMAL
);