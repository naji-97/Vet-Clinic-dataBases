/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

-- create table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

-- Update Table
  INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
  ('Charmander', '2020-02-08', 0, false, -11, ''),
  ('Plantmon', '2021-11-15', 2, true, -5.7, ''),
  ('Squirtle', '1993-04-02', 3, false, -12.13, ''),
  ('Angemon', '2005-06-12', 1, true, -45, ''),
  ('Boarmon', '2005-06-07', 7, true, 20.4, ''),
  ('Blossom', '1998-10-13', 3, true, 17, ''),
  ('Ditto', '2022-05-14', 4, true, 22, '');

  -- Multi Table
  -- Insert data into owners table
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert data into species table
INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

-- Update animals with species_id based on name
UPDATE animals
SET species_id = CASE
  WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
  ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

-- Update animals with owner_id based on owner's full_name
UPDATE animals
SET owner_id = CASE
  WHEN owner_id IS NULL THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
  WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;


-- Join Table
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1), -- William Tatcher specialized in Pokemon
       (3, 2), -- Stephanie Mendez specialized in Digimon
       (3, 1), -- Stephanie Mendez specialized in Pokemon
       (4, 2); -- Jack Harkness specialized in Digimon


INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 1, '2020-05-24'), -- Agumon visited William Tatcher on May 24th, 2020
       (1, 3, '2020-07-22'), -- Agumon visited Stephanie Mendez on Jul 22th, 2020
       (2, 4, '2021-02-02'), -- Gabumon visited Jack Harkness on Feb 2nd, 2021
       (3, 2, '2020-01-05'), -- Pikachu visited Maisy Smith on Jan 5th, 2020
       (3, 2, '2020-03-08'), -- Pikachu visited Maisy Smith on Mar 8th, 2020
       (3, 2, '2020-05-14'), -- Pikachu visited Maisy Smith on May 14th, 2020
       (4, 3, '2021-05-04'), -- Devimon visited Stephanie Mendez on May 4th, 2021
       (5, 4, '2021-02-24'), -- Charmander visited Jack Harkness on Feb 24th, 2021
       (6, 2, '2019-12-21'), -- Plantmon visited Maisy Smith on Dec 21st, 2019
       (6, 1, '2020-08-10'), -- Plantmon visited William Tatcher on Aug 10th, 2020
       (6, 2, '2021-04-07'), -- Plantmon visited Maisy Smith on Apr 7th, 2021
       (7, 3, '2019-09-29'), -- Squirtle visited Stephanie Mendez on Sep 29th, 2019
       (8, 4, '2020-10-03'), -- Angemon visited Jack Harkness on Oct 3rd, 2020
       (8, 4, '2020-11-04'), -- Angemon visited Jack Harkness on Nov 4th, 2020
       (9, 2, '2019-01-24'), -- Boarmon visited Maisy Smith on Jan 24th, 2019
       (9, 2, '2019-05-15'), -- Boarmon visited Maisy Smith on May 15th, 2019
       (9, 2, '2020-02-27'), -- Boarmon visited Maisy Smith on Feb 27th, 2020
       (9, 2, '2020-08-03'), -- Boarmon visited Maisy Smith on Aug 3rd, 2020
       (10, 3, '2020-05-24'), -- Blossom visited Stephanie Mendez on May 24th, 2020
       (10, 1, '2021-01-11'); -- Blossom visited William Tatcher on Jan 11th, 2021

