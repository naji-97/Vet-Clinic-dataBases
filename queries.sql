/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg:
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered:
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon:
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including animals with weights equal  10.4kg or 17.3kg):
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;



-- Updtae Table
-- Inside a transaction: Update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;

-- Update the species column to unspecified
UPDATE animals
SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify that the species column went back to its state before the transaction
SELECT * FROM animals;

-- Inside a transaction: Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. Update the animals table by setting the species column to pokemon for all animals that don't have species already set. Verify that changes were made. Commit the transaction. Verify that changes persist after commit.
BEGIN;

-- Update the species column to digimon for animals with name ending in mon
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update the species column to pokemon for animals without a species
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify the changes
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Verify that changes persist after commit
SELECT * FROM animals;

-- Inside a transaction: Delete all records in the animals table, then roll back the transaction. After the rollback, verify if all records in the animals table still exist.
BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Verify that all records are deleted
SELECT * FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify that all records are restored
SELECT * FROM animals;

-- Inside a transaction: Delete all animals born after Jan 1st, 2022. Create a savepoint for the transaction. Update all animals' weight to be their weight multiplied by -1. Rollback to the savepoint. Update all animals' weights that are negative to be their weight multiplied by -1. Commit the transaction.
BEGIN;

-- Delete animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT my_savepoint;

-- Update weights of animals that are negative
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- Verify the changes
SELECT * FROM animals;

-- How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS animals_no_escape_attempts FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(*) AS escape_count FROM animals WHERE escape_attempts > 0 GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- Multiple Table
-- What animals belong to Melody Pond?
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animals.
SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.


SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;


-- Who owns the most animals?
SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;


-- Join Table
SELECT a.name AS animal_name
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
  AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


SELECT a.name AS animal_name, COUNT(*) AS visit_count
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;


SELECT vt.name AS vet_name, v.date_of_visit
FROM visits v
INNER JOIN vets vt ON v.vet_id = vt.id
INNER JOIN animals a ON v.animal_id = a.id
WHERE a.name = 'Maisy Smith'
ORDER BY v.date_of_visit ASC
LIMIT 1;



SELECT a.name AS animal_name, vt.name AS vet_name, v.date_of_visit
FROM visits v
INNER JOIN vets vt ON v.vet_id = vt.id
INNER JOIN animals a ON v.animal_id = a.id
ORDER BY v.date_of_visit DESC
LIMIT 1;


SELECT COUNT(*) AS visit_count
FROM visits v
INNER JOIN vets vt ON v.vet_id = vt.id
INNER JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;


SELECT s.name AS species_name, COUNT(*) AS visit_count
FROM visits v
INNER JOIN animals a ON v.animal_id = a.id
INNER JOIN species s ON a.species_id = s.id
INNER JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;




