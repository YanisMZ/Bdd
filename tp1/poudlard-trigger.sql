DROP TABLE IF EXISTS suit CASCADE;
DROP TABLE IF EXISTS familier CASCADE;
DROP TABLE IF EXISTS eleve CASCADE;
DROP TABLE IF EXISTS cours CASCADE;
DROP TABLE IF EXISTS baguette CASCADE;
DROP TABLE IF EXISTS prixBois CASCADE;
DROP TABLE IF EXISTS prixCoeur CASCADE;
DROP TABLE IF EXISTS requiert CASCADE;
DROP TABLE IF EXISTS incompatible CASCADE;
DROP TABLE IF EXISTS historiquePrix CASCADE;


CREATE TABLE eleve(
  numEl serial primary key,
  nom varchar(25),
  prenom varchar(25),
  dateNaissance date,
  sexe char(1),
  maison varchar(25)
);

CREATE TABLE familier(
  surnom varchar(25) primary key,
  espece varchar(25),
  description text,
  proprietaire int references eleve(numEl) ON DELETE SET NULL
);

CREATE TABLE cours(
  codeCours char(4) primary key,
  intitule varchar(40),
  heureDebut time,
  heureFin time,
  jour varchar(10)
);

CREATE TABLE suit(
  numEl int references eleve(numEl) ON DELETE CASCADE,
  codecours char(4) references cours(codeCours) ON DELETE CASCADE,
  note numeric(3,1) CHECK (note BETWEEN 0 AND 20),
  primary key(numEl, codeCours)
);

CREATE TABLE baguette (
  numbag serial PRIMARY KEY,
  bois varchar(15) NOT NULL,
  coeur varchar(15) NOT NULL,
  longueur numeric(3,1) NOT NULL,
  prix numeric(4,2),
  proprietaire int UNIQUE REFERENCES eleve(numel)
  ON DELETE SET NULL
);

CREATE TABLE prixBois (
  bois varchar(15) PRIMARY KEY,
  prixCm numeric(4,2) NOT NULL
);

CREATE TABLE prixCoeur (
  coeur varchar(15) PRIMARY KEY,
  prixUnitaire numeric(5,2) NOT NULL
);

CREATE TABLE requiert (
  codeCours char(4) REFERENCES cours(codeCours),
  codeCoursRequis char(4) REFERENCES cours(codeCours),
  PRIMARY KEY(codeCours, codeCoursRequis)
);

CREATE TABLE incompatible(
  bois varchar(15) NOT NULL, 
  coeur varchar(15) NOT NULL,
  PRIMARY KEY(bois, coeur)
);


CREATE TABLE historiquePrix(
  log_id serial PRIMARY KEY,
  date1 date,
  numbag INT NOT NULL,
  ancienPrix numeric(4,2),
  nouveauPrix numeric(4,2),
  Foreign key(numBag) REFERENCES baguette(numBag) ON DELETE CASCADE
);



-- Insertion des données pour la table eleve

INSERT INTO eleve (numEl, nom, prenom, dateNaissance, maison, sexe) VALUES
(1, 'Blanchard', 'Oswald', '2002-01-15', 'Gryffondor', 'M'),
(2, 'Fitzroy', 'Morgane', '2002-02-28', 'Serdaigle', 'F'),
(3, 'Carroway', 'Silas', '2003-03-12', 'Serpentard', 'M'),
(4, 'Thistle', 'Evangeline', '2003-04-06', 'Poufsouffle', 'F'),
(5, 'Hawke', 'Benedict', '2002-05-23', 'Gryffondor', 'M'),
(6, 'Hallow', 'Seraphina', '2003-06-19', 'Serdaigle', 'F'),
(7, 'Winters', 'Cassius', '2002-07-03', 'Serpentard', 'M'),
(8, 'Tremblay', 'Fleur', '2003-08-15', 'Poufsouffle', 'F'),
(9, 'Briar', 'Lysander', '2002-09-17', 'Serdaigle', 'M'),
(10, 'Greenwood', 'Elora', '2002-10-11', 'Gryffondor', 'F'),
(11, 'Ashford', 'Cedrella', '2003-11-22', 'Serpentard', 'F'),
(12, 'Deverell', 'Lucan', '2003-12-08', 'Serdaigle', 'M'),
(13, 'Rosier', 'Mira', '2002-02-03', 'Poufsouffle', 'F'),
(14, 'Fawkes', 'Alaric', '2003-01-26', 'Gryffondor', 'M'),
(15, 'Harlow', 'Ophelia', '2002-03-09', 'Serpentard', 'F'),
(16, 'Drake', 'Percival', '2003-04-18', 'Gryffondor', 'M'),
(17, 'Hampton', 'Selene', '2002-05-14', 'Serdaigle', 'F'),
(18, 'Lancaster', 'Emery', '2002-06-07', 'Poufsouffle', 'M'),
(19, 'Ainsley', 'Isidore', '2003-07-21', 'Serpentard', 'M'),
(20, 'Morrison', 'Gideon', '2002-08-25', 'Gryffondor', 'M'),
(21, 'Beaumont', 'Vivienne', '2003-09-29', 'Serdaigle', 'F'),
(22, 'Prewett', 'Alistair', '2002-10-05', 'Serpentard', 'M'),x écailles brillantes, très mystérieux.', NULL),
('Puff', 'rat', 'Un rat avec un pelage doux et soyeux, très docile.', 14),
('Sparks', 'faucon', 'Un faucon aux ailes étincelantes, rapide et majestueux.', 13),
('Rusty', 'écureuil', 'Un écureuil au
(23, 'Fairfax', 'Juliette', '2003-11-14', 'Poufsouffle', 'F'),
(24, 'Wren', 'Orion', '2002-12-27', 'Gryffondor', 'M'),
(25, 'Thorpe', 'Isla', '2002-01-09', 'Serdaigle', 'F'),
(26, 'Langley', 'Rufus', '2003-02-17', 'Serpentard', 'M'),
(27, 'Huxley', 'Aurora', '2002-03-05', 'Serdaigle', 'F'),
(28, 'Caldwell', 'Damon', '2003-04-23', 'Gryffondor', 'M'),
(29, 'Peregrine', 'Imogen', '2002-05-30', 'Poufsouffle', 'F'),
(30, 'Sutton', 'Everard', '2003-06-25', 'Serpentard', 'M'),
(31, 'Belmont', 'Rowena', '2002-07-15', 'Serdaigle', 'F'),
(32, 'Kingsley', 'Thaddeus', '2003-08-09', 'Gryffondor', 'M'),
(33, 'Lockwood', 'Vivian', '2002-09-01', 'Poufsouffle', 'F'),
(34, 'Aldridge', 'Cassiopeia', '2003-10-11', 'Serdaigle', 'F'),
(35, 'Blackthorn', 'Ronan', '2002-11-05', 'Serpentard', 'M'),
(36, 'Wyndham', 'Magnus', '2003-12-19', 'Gryffondor', 'M'),
(37, 'Huntington', 'Cressida', '2002-01-20', 'Poufsouffle', 'F'),
(38, 'Lennox', 'Felix', '2003-03-31', 'Serpentard', 'M'),
(39, 'Ashcroft', 'Eleanora', '2002-04-12', 'Serdaigle', 'F'),
(40, 'Roscoe', 'Leander', '2003-05-06', 'Gryffondor', 'M');


-- insertion des données pour la table familier

INSERT INTO familier (surnom, espece, description, proprietaire) VALUES
('Nimbus', 'chat', 'Un chat noir avec des yeux perçants. Très agile et intelligent.', 1),
('Pipin', 'rat', 'Un rat gris-argenté, connu pour être très rapide et discret.', 4),
('Hedwig', 'chouette', 'Une chouette blanche majestueuse avec des plumes d’une grande beauté.', 7),
('Scabbers', 'rat', 'Un rat aux poils épars, très fidèle mais avec une grande curiosité.', 1),
('Flame', 'chat', 'Un chat orange vif, aux yeux verts brillants, à la personnalité enflammée.', 8),
('Gizmo', 'serpent', 'Un serpent vert émeraude, silencieux et très rapide.', 10),
('Whisper', 'chauve-souris', 'Une chauve-souris noire aux ailes délicates, très discrète.', 12),
('Shadow', 'chat', 'Un chat noir comme l’ombre, très mystérieux et discret.', 2),
('Thistle', 'chouette', 'Une chouette au plumage brun et tacheté, très sage et observatrice.', 15),
('Echo', 'rat', 'Un rat noir avec une grande intelligence et une grande vivacité.', 4),
('Sable', 'serpent', 'Un serpent sable aux écailles brillantes, vif et élégant.', 16),
('Basil', 'serpent', 'Un serpent de couleur bronze, à la présence imposante.', 3),
('Nox', 'hibou', 'Un hibou aux plumes nocturnes, sage et très observateur.', 17),
('Moss', 'souris', 'Une souris brune et vive, très curieuse.', 9),
('Velvet', 'chat', 'Un chat aux poils noirs doux comme du velours, très affectueux.', 5),
('Jasper', 'furet', 'Un furet au pelage crème, vif et intelligent.', 18),
('Flick', 'chauve-souris', 'Une petite chauve-souris aux ailes scintillantes, très rapide.', 19),
('Star', 'chouette', 'Une chouette aux plumes étoilées, sage et observatrice.', 11),
('Fuzz', 'rat', 'Un rat avec un pelage épars et duveteux, très curieux.', NULL),
('Pip', 'chauve-souris', 'Une chauve-souris aux ailes en forme de feuille, très agile.', 2),
('Marble', 'chat', 'Un chat tigré aux motifs marbrés, très espiègle.', 8),
('Kiki', 'hibou', 'Un hibou au regard perçant, très protecteur.', 6),
('Draco', 'serpent', 'Un serpent noir aux écailles brillantes, très mystérieux.', NULL),
('Puff', 'rat', 'Un rat avec un pelage doux et soyeux, très docile.', 14),
('Sparks', 'faucon', 'Un faucon aux ailes étincelantes, rapide et majestueux.', 13),
('Rusty', 'écureuil', 'Un écureuil aux poils roux, très agité et vif.', NULL),
('Webster', 'araignée', 'Une araignée aux pattes fines et au venin léger, très discrète.', NULL),
('Raven', 'corbeau', 'Un corbeau noir brillant avec un regard sage, très intelligent.', 15);


-- Insertion de données pour la table cours :

INSERT INTO cours VALUES
('poti','Potions','10:15','13:15','mardi'),
('sort','Sortilèges','9:30','12:00','mercredi'),
('dcfm','Défense contre les Forces du Mal','16:45','18:45','jeudi'),
('meta','Métamorphose','15:15','18:00','vendredi'),
('hdlm','Histoire de la Magie','12:30','14:30','vendredi'),
('divi','Divination','12:30','14:00','mercredi'),
('rune','Runes','12:45','14:30','mercredi'),
('bota','Botanique','8:30','10:30','jeudi'),
('crea','Soins aux créatures magiques','8:30','10:30','jeudi'),
('astr','Astronomie','21:00','23:00','lundi'),
('arit','Arithmancie','8:45','10:15','lundi'),
('pot2','Potions Avancées','14:00','16:00','mardi'),
('pot3','Potions Expertes','16:15','18:00','mardi'),
('anim','Animagus','14:00','15:30','jeudi'),
('jury','Points de jury',NULL,NULL,NULL);

-- Insertion de données pour la table suit :

INSERT INTO suit VALUES
(1,'poti',13.5),
(1,'sort',14.5),
(1,'dcfm',15.5),
(1,'meta',14.5),
(1,'hdlm',14.5),
(1,'rune',20.0),
(1,'arit',14.0),
(2,'poti',17.5),
(2,'sort',10.5),
(2,'dcfm',13.5),
(2,'meta',12.0),
(2,'hdlm',14.0),
(2,'crea',13.5),
(2,'astr',11.0),
(2,'divi',11.0),
(3,'poti',16.0),
(3,'sort',14.5),
(3,'dcfm',17.5),
(3,'meta',12.5),
(3,'astr',17.5),
(4,'poti',14.5),
(4,'sort',7.0),
(4,'dcfm',11.5),
(4,'meta',4.5),
(4,'hdlm',1.5),
(4,'arit',4.5),
(5,'poti',19.5),
(5,'sort',15.0),
(5,'dcfm',13.0),
(5,'meta',17.5),
(5,'hdlm',9.5),
(5,'divi',20.0),
(6,'poti',8.5),
(6,'sort',14.0),
(6,'dcfm',10.5),
(6,'meta',6.0),
(6,'hdlm',7.0),
(6,'bota',6.5),
(6,'rune',2.5),
(6,'astr',6.0),
(7,'poti',5.0),
(7,'sort',9.0),
(7,'dcfm',9.5),
(7,'meta',8.0),
(7,'rune',9.5),
(7,'crea',4.0),
(7,'astr',10.5),
(8,'poti',12.5),
(8,'sort',12.0),
(8,'dcfm',8.0),
(8,'meta',6.0),
(8,'hdlm',16.5),
(9,'poti',12.0),
(9,'sort',11.5),
(9,'dcfm',9.0),
(9,'meta',19.5),
(9,'hdlm',12.5),
(9,'astr',12.0),
(9,'bota',13.0),
(10,'poti',20),
(10,'sort',18.0),
(10,'dcfm',18.0),
(10,'meta',14.0),
(10,'hdlm',20),
(10,'rune',19.5),
(10,'divi',18.0),
(11,'poti',8.5),
(11,'sort',11.5),
(11,'dcfm',12.5),
(11,'meta',10.5),
(11,'hdlm',9.0),
(12,'poti',11.0),
(12,'sort',9.5),
(12,'dcfm',8.0),
(12,'meta',11.5),
(12,'astr',11.0),
(13,'poti',13.0),
(13,'sort',10.5),
(13,'dcfm',9.0),
(13,'meta',5.5),
(13,'hdlm',9.0),
(13,'bota',8.5),
(13,'arit',13.5),
(13,'divi',12.5),
(14,'poti',8.5),
(14,'sort',10.0),
(14,'dcfm',13.0),
(14,'meta',9.0),
(14,'hdlm',13.0),
(14,'astr',13.5),
(14,'rune',13.5),
(15,'poti',8.5),
(15,'sort',0),
(15,'dcfm',10.5),
(15,'meta',9.5),
(15,'hdlm',9.0),
(16,'poti',20),
(16,'sort',16.0),
(16,'dcfm',16.0),
(16,'meta',13.0),
(16,'hdlm',14.0),
(16,'astr',10.5),
(16,'crea',11.0),
(17,'poti',18.0),
(17,'sort',9.5),
(17,'dcfm',7.5),
(17,'meta',12.5),
(17,'hdlm',11.5),
(17,'crea',12.5),
(17,'arit',7.0),
(18,'poti',6.5),
(18,'sort',4.0),
(18,'dcfm',11.5),
(18,'meta',5.5),
(18,'hdlm',10.0),
(18,'bota',3.0),
(18,'astr',9.5),
(18,'rune',6.0),
(19,'poti',5.5),
(19,'sort',6.5),
(19,'dcfm',6.0),
(19,'meta',7.0),
(19,'bota',0.5),
(20,'poti',4.5),
(20,'sort',6.5),
(20,'dcfm',11.5),
(20,'meta',8.0),
(20,'hdlm',4.5),
(21,'poti',13.0),
(21,'sort',10.0),
(21,'dcfm',18.0),
(21,'meta',17.5),
(21,'hdlm',17.5),
(21,'divi',15.5),
(22,'poti',11.0),
(22,'sort',7.0),
(22,'dcfm',8.0),
(22,'meta',10.0),
(22,'rune',10.5),
(23,'poti',17.0),
(23,'sort',11.0),
(23,'dcfm',10.5),
(23,'meta',5.5),
(23,'hdlm',10.0),
(23,'bota',9.5),
(24,'poti',12.0),
(24,'sort',8.5),
(24,'dcfm',5.5),
(24,'meta',11.5),
(24,'hdlm',14.5),
(25,'poti',18.5),
(25,'sort',11.0),
(25,'dcfm',15.0),
(25,'meta',17.0),
(25,'hdlm',20.0),
(25,'astr',15.5),
(25,'crea',16.0),
(25,'rune',17.5),
(26,'poti',16.5),
(26,'sort',17.0),
(26,'dcfm',15.5),
(26,'meta',16.0),
(26,'hdlm',6.5),
(27,'poti',20),
(27,'sort',18.5),
(27,'dcfm',14.0),
(27,'meta',14.0),
(27,'hdlm',17.5),
(28,'poti',15.5),
(28,'sort',11.0),
(28,'dcfm',15.5),
(28,'meta',14.5),
(28,'hdlm',15.5),
(29,'poti',9.5),
(29,'sort',16.0),
(29,'dcfm',19.0),
(29,'meta',13.0),
(29,'hdlm',14.0),
(29,'crea',15.5),
(29,'arit',14.5),
(30,'poti',14.5),
(30,'sort',8.5),
(30,'dcfm',13.5),
(30,'meta',10.5),
(30,'hdlm',9.5),
(30,'arit',13.5),
(31,'poti',12.0),
(31,'sort',13.5),
(31,'dcfm',12.5),
(31,'meta',10.5),
(31,'hdlm',12.5),
(32,'poti',14.5),
(32,'sort',11.0),
(32,'dcfm',9.5),
(32,'meta',14.5),
(32,'hdlm',14.0),
(32,'arit',10.5),
(32,'rune',10.5),
(33,'poti',15.0),
(33,'sort',7.0),
(33,'dcfm',16.5),
(33,'meta',11.5),
(33,'hdlm',13.0),
(33,'rune',13.5),
(33,'crea',10.5),
(33,'arit',13.5),
(34,'poti',11.0),
(34,'sort',7.5),
(34,'dcfm',7.0),
(34,'meta',7.5),
(34,'hdlm',9.0),
(34,'arit',9.5),
(35,'poti',7.5),
(35,'sort',7.5),
(35,'dcfm',8.5),
(35,'meta',7.0),
(35,'hdlm',13.5),
(35,'divi',7.0),
(35,'astr',8.5),
(35,'bota',12.0),
(36,'poti',9.5),
(36,'sort',9.0),
(36,'dcfm',10.0),
(36,'meta',9.5),
(36,'hdlm',8.5),
(36,'divi',9.0),
(36,'crea',9.0),
(36,'arit',11.0),
(37,'poti',12.0),
(37,'sort',15.5),
(37,'dcfm',13.5),
(37,'meta',7.0),
(37,'hdlm',8.0),
(37,'astr',17.5),
(38,'poti',8.5),
(38,'sort',9.0),
(38,'dcfm',10.0),
(38,'meta',11.5),
(38,'hdlm',7.0),
(38,'crea',4.5),
(39,'poti',8.5),
(39,'sort',15.5),
(39,'dcfm',12.5),
(39,'meta',13.5),
(39,'hdlm',11.5),
(39,'rune',10.0),
(39,'bota',15.5),
(39,'arit',9.5),
(40,'poti',20),
(40,'sort',19.0),
(40,'dcfm',12.5),
(40,'meta',17.5),
(40,'hdlm',16.0);

-- Insertion des données pour la table baguette

INSERT INTO baguette (bois, coeur, longueur, prix, proprietaire) VALUES
('sapin', 'dragon', 30.5, 29.99, NULL),
('cèdre', 'licorne', 28.0, 25.00, NULL),
('if', 'phoenix', 35.0, 45.50, NULL),
('bouleau', 'vélane', 32.7, 33.00, NULL),
('chêne', 'basilic', 31.2, 37.99, NULL),
('érable', 'sirène', 27.5, 28.50, NULL),
('hêtre', 'dragon', 29.0, 30.00, NULL),
('acacia', 'phoenix', 34.3, 39.00, NULL),
('acacia', 'sirène', 33.0, 34.50, NULL),
('if', 'dragon', 28.9, 32.75, NULL),
('saule', 'licorne', 26.5, 27.99, NULL),
('orme', 'vélane', 29.7, 31.00, NULL),
('noyer', 'phoenix', 30.1, 30.50, NULL),
('bouleau', 'basilic', 32.2, 35.00, NULL),
('peuplier', 'phoenix', 31.5, 29.99, NULL),
('charme', 'vélane', 28.3, 26.50, NULL),
('érable', 'licorne', 33.7, 38.50, NULL),
('cèdre', 'sirène', 27.9, 28.99, NULL),
('orme', 'phoenix', 29.6, 29.50, NULL),
('chêne', 'dragon', 34.8, 42.00, NULL),
('sapin', 'basilic', 32.4, 30.75, NULL),
('érable', 'vélane', 28.7, 28.50, NULL),
('if', 'phoenix', 30.5, 31.00, NULL),
('bouleau', 'basilic', 31.2, 29.99, NULL),
('cèdre', 'sirène', 27.8, 27.50, NULL),
('chêne', 'phoenix', 33.0, 36.00, NULL),
('orme', 'licorne', 29.5, 30.99, NULL),
('saule', 'vélane', 26.9, 25.00, NULL),
('acacia', 'basilic', 32.0, 33.50, NULL),
('orme', 'dragon', 34.5, 39.99, NULL);

-- Insertion des données pour la table prixBois

INSERT INTO prixBois (bois, prixCm) VALUES
('sapin', 0.80),
('cèdre', 1.00),
('if', 1.20),
('bouleau', 0.75),
('chêne', 1.10),
('érable', 0.90),
('hêtre', 0.85),
('acacia', 1.15),
('saule', 0.70),
('orme', 1.00),
('noyer', 1.30),
('cormier', 1.25),
('peuplier', 0.65),
('charme', 0.95);

-- Insertion des données pour la table prixCoeur

INSERT INTO prixCoeur (coeur, prixUnitaire) VALUES
('dragon', 15.00),
('licorne', 12.50),
('phoenix', 18.00),
('vélane', 14.00),
('basilic', 20.00),
('sirène', 16.50);

-- Insertion des données pour la table requiert

INSERT INTO requiert VALUES
('pot2','poti'),
('pot3','pot2'),
('pot3','bota'),
('anim','crea'),
('anim','meta');



INSERT INTO incompatible VALUES
('dragon','cèdre');
