DROP TRIGGER IF EXISTS trigger_prix ON baguette;

CREATE OR REPLACE FUNCTION calcul_prix()
RETURNS TRIGGER AS
$$
  DECLARE 
    prix_1 numeric;
    prix_2 numeric;

  BEGIN

    SELECT prixUnitaire INTO prix_1
    FROM prixCoeur
    WHERE coeur = NEW.coeur;
    IF NOT FOUND THEN RAISE 'le coeur n''est pas ajouté'; 
    RETURN NULL;
    END IF;
    
    SELECT prixCm INTO prix_2
    FROM prixBois
    WHERE bois = NEW.bois;

    IF NOT FOUND THEN RAISE 'le bois n''est pas ajouté' ;
    RETURN NULL;
    END IF;
    
    
    NEW.prix = prix_1 + NEW.longueur * prix_2;



  RETURN NEW;
  END ;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_prix
BEFORE INSERT
ON baguette
FOR EACH ROW
WHEN (NEW.prix IS NULL)
EXECUTE PROCEDURE calcul_prix();





---exercice 1
---1)
--ALTER TABLE baguette ENABLE TRIGGER trigger_prix; --activer
-- ALTER TABLE baguette DISABLE TRIGGER trigger_prix; -- Désactiver


---- 3)
-- on essaye d'inserer  baguette qui ne contient pas de bois
--INSERT INTO baguette (bois, coeur, longueur, prix, proprietaire) VALUES('rien', 'dragon', 30.5, 29.99, NULL);






