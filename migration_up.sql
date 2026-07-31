CREATE TYPE motif_visite_enum AS ENUM ('professionnel', 'maintenance', 'entretien', 'livraison', 'autre');

CREATE TABLE visiteur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    entreprise VARCHAR(100)
);

CREATE TABLE visite (
    id SERIAL PRIMARY KEY,
    visiteur_id INT REFERENCES visiteur(id),
    employe_id INT REFERENCES employe(id),
    date_visite TIMESTAMP,
    motif motif_visite_enum
);