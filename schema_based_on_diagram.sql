CREATE TABLE patients (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	date_of_birth DATE,
	PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
	id INT GENERATED ALWAYS AS IDENTITY,
	admitted_at DATE,
	status VARCHAR(100),
	patient_id INT,
	PRIMARY KEY(id),
	CONSTRAINT fk_patients FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
	id INT GENERATED ALWAYS AS IDENTITY,
	type VARCHAR(100),
	name VARCHAR(100),
	PRIMARY KEY (id)
);
