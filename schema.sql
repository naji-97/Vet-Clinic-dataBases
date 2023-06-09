
/* Database schema to keep the structure of entire database. */

-- Create a table named animals
CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

-- Add the species column to the animals table
ALTER TABLE animals ADD COLUMN species VARCHAR(255);

-- Multi Table

-- Create owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

-- Create species table
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Modify animals table
ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INTEGER REFERENCES species(id),
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

-- Join Table
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets (id),
  species_id INTEGER REFERENCES species (id),
  PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
  animal_id INTEGER REFERENCES animals (id),
  vet_id INTEGER REFERENCES vets (id),
  visit_date DATE,
  PRIMARY KEY (animal_id, vet_id)
);

-- Performance
-- To decrease the execution time

CREATE INDEX visits_animal_id_idx ON visits (animal_id);
CREATE INDEX visits_vet_id_idx ON visits (vet_id);
CREATE INDEX owners_email_idx ON owners (email);

