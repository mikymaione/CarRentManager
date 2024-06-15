CREATE TABLE utente (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

	email VARCHAR(200) NOT NULL,
	psw VARCHAR(40) NOT NULL,

	amministratore BOOLEAN NOT NULL
);

CREATE TABLE gruppo (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

	descrizione VARCHAR(200) NOT NULL
);

CREATE TABLE vettura (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

	targa VARCHAR(15) NOT NULL,
	alimentazione VARCHAR(80) NOT NULL,

	marca VARCHAR(80) NOT NULL,
	modello VARCHAR(200) NOT NULL,

	colore VARCHAR(200) NOT NULL,

	gruppo INT NOT NULL,

	accessori VARCHAR(5000),

	proprieta VARCHAR(500),

	FOREIGN KEY (gruppo) REFERENCES gruppo(id)
);

CREATE TABLE tariffa (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

	gruppo INT NOT NULL,

	dal DATE NOT NULL,
	al DATE NOT NULL,

	costo_giornaliero NUMERIC(4, 2) NOT NULL, -- 9.999,22 €

	FOREIGN KEY (gruppo) REFERENCES gruppo(id)
);

CREATE TABLE conducente (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

	cf VARCHAR(50) NOT NULL,

	cognome VARCHAR(100) NOT NULL,
	nome VARCHAR(100) NOT NULL,

	data_nascita DATE NOT NULL,
	luogo_nascita VARCHAR(100) NOT NULL,

	patente VARCHAR(50) NOT NULL,
	patente_luogo_emissione VARCHAR(200),
	patente_data_emissione DATE NOT NULL,
	patente_data_scadenza DATE NOT NULL,

	residenza_indirizzo VARCHAR(250) NOT NULL,
	residenza_comune VARCHAR(200) NOT NULL,
	residenza_cap VARCHAR(5) NOT NULL,
	residenza_provincia VARCHAR(2) NOT NULL,
	residenza_stato VARCHAR(2) NOT NULL,

	telefono1 VARCHAR(20) NOT NULL,
	telefono2 VARCHAR(20),
	email VARCHAR(200)
);

CREATE TABLE noleggio (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

	creato TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	dal_previsto DATETIME NOT NULL,
	al_previsto DATETIME NOT NULL,
	al_effettivo DATETIME,	

	tariffa INT NOT NULL,
	vettura INT NOT NULL,

	totale_preventivo NUMERIC(9, 2) NOT NULL, -- 999.999.999,22 €
	cauzione NUMERIC(9, 2) NOT NULL, -- 999.999.999,22 €
	acconto NUMERIC(9, 2), -- 999.999.999,22 €

	serbatoio NUMERIC(3, 0) NOT NULL, -- percentuale 0 -> 100

	km_partenza NUMERIC(9, 0) NOT NULL, -- 999.999.999 km
	km_arrivo NUMERIC(9, 0), -- 999.999.999 km

	franchigia_rca BOOLEAN NOT NULL,
	franchigia_kasko BOOLEAN NOT NULL,
	franchigia_furto BOOLEAN NOT NULL,

	note VARCHAR(5000),

	conducente1 INT NOT NULL,
	conducente2 INT,
	conducente3 INT,
	conducente4 INT,
	conducente5 INT,

	FOREIGN KEY (tariffa) REFERENCES tariffa(id),
	FOREIGN KEY (vettura) REFERENCES vettura(id),

	FOREIGN KEY (conducente1) REFERENCES conducente(id),
	FOREIGN KEY (conducente2) REFERENCES conducente(id),
	FOREIGN KEY (conducente3) REFERENCES conducente(id),
	FOREIGN KEY (conducente4) REFERENCES conducente(id),
	FOREIGN KEY (conducente5) REFERENCES conducente(id)
);