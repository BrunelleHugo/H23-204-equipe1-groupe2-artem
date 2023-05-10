DROP TABLE IF EXISTS users_compatible;
DROP TYPE IF EXISTS oeuvre;

CREATE TYPE oeuvre AS (
    img TEXT,
    descrip TEXT,
    couleurs INT[5][3],
    dimensions DECIMAL[2]
);

CREATE TABLE users_compatible (
    id INT,
    email TEXT,
    mdp TEXT,
    nom TEXT,
    avatar TEXT,
    palette INT[5][3],
    oeuvres oeuvre[],
    aimees oeuvre[],
    compat DECIMAL
);
