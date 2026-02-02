DROP TRIGGER IF EXISTS incompatible_trigger ON baguette;



CREATE OR REPLACE FUNCTION incompatible()
RETURNS TRIGGER AS
$$
BEGIN
  
   PERFORM 1
FROM incompatible
WHERE bois = NEW.bois
  AND coeur = NEW.coeur;

IF FOUND THEN
    RAISE EXCEPTION 'Incompatible';
END IF;



  RETURN NEW;
  END ;
$$

LANGUAGE plpgsql;

CREATE TRIGGER incompatible_trigger
AFTER INSERT
ON baguette
FOR EACH ROW
EXECUTE PROCEDURE incompatible();




--ALTER TABLE baguette ENABLE TRIGGER incompatible_trigger; --activer

---INSERT INTO baguette (bois, coeur, longueur, prix, proprietaire) VALUES('dragon', 'cèdre', 30.5, 29.99, NULL);
--ERREUR:  Incompatible
--CONTEXTE : fonction PL/pgSQL incompatible(), ligne 10 à RAISE