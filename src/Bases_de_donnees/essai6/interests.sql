DROP TABLE IF EXISTS users_compatible;
DROP TABLE IF EXISTS compa_inter;

/* CREATE TABLE compa_inter (
    pers0 DECIMAL DEFAULT 0,
    pers1 DECIMAL DEFAULT 0,
    pers2 DECIMAL DEFAULT 0,
    pers3 DECIMAL DEFAULT 0,
    pers4 DECIMAL DEFAULT 0,
    pers5 DECIMAL DEFAULT 0,
    pers6 DECIMAL DEFAULT 0,
    pers7 DECIMAL DEFAULT 0,
    pers8 DECIMAL DEFAULT 0,
    pers9 DECIMAL DEFAULT 0,
    pers10 DECIMAL DEFAULT 0
); */

CREATE TABLE users_compatible (
    id INT,
    email TEXT,
    mdp TEXT,
    nom TEXT,
    avatar INT[],
    lien TEXT,
    palette JSONB,
    oeuvres JSONB,
    aimees JSONB,
    compat JSONB
);