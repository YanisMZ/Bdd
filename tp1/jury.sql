DROP VIEW IF EXISTS valide CASCADE;

CREATE VIEW valide(numEl, prenom, nom) AS (
  SELECT numEl, prenom, nom
  FROM eleve NATURAL JOIN suit
  WHERE note >= 10
  GROUP BY numEl, prenom, nom
  HAVING count(*) >= 4
);

CREATE OR REPLACE FUNCTION pointsJury()
RETURNS TRIGGER AS
$$
DECLARE
  total_matiere INT;
  total_valides INT;
  eleve_nom TEXT;
  eleve_prenom TEXT;
BEGIN

  SELECT prenom, nom INTO eleve_prenom, eleve_nom FROM eleve WHERE numEl = NEW.numEl;
  IF NOT FOUND THEN
    RAISE NOTICE 'L''élève n''existe pas.';
    RETURN NULL;
  END IF;

  IF (NEW.prenom IS NOT NULL AND NEW.prenom <> eleve_prenom) OR 
     (NEW.nom IS NOT NULL AND NEW.nom <> eleve_nom) THEN
    RAISE EXCEPTION 'Erreur: les informations de l''étudiant sont incorrectes.';
  END IF;

  PERFORM * FROM valide WHERE numEl = NEW.numEl;
  IF FOUND THEN
    RAISE NOTICE 'L''élève valide déjà son année.';
    RETURN NULL;
  END IF;

  SELECT COUNT(*) INTO total_valides FROM suit WHERE numEl = NEW.numEl AND note >= 10;
  SELECT COUNT(*) INTO total_matiere FROM suit WHERE numEl = NEW.numEl;

  IF total_valides + 1 < 4 THEN
    RAISE NOTICE 'L''élève a trop de retard pour que les points de jury suffisent.';
    RETURN NULL;
  END IF;

 
  IF NOT EXISTS (SELECT 1 FROM cours WHERE nomCours = 'jury') THEN
    INSERT INTO cours (nomCours) VALUES ('jury');
    RAISE NOTICE 'Le cours "jury" a été automatiquement créé.';
  END IF;

  INSERT INTO suit (numEl, nomCours, note) VALUES (NEW.numEl, 'jury', 10);
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER valideEleve
INSTEAD OF INSERT
ON valide
FOR EACH ROW
EXECUTE FUNCTION pointsJury();


