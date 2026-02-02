DROP TRIGGER IF EXISTS historique_trigger ON baguette;

CREATE OR REPLACE FUNCTION historique()
RETURNS TRIGGER AS
$$
  DECLARE 


  BEGIN
    INSERT INTO historiquePrix(numbag,date1, ancienprix,nouveauprix)
    VALUES (NEW.numBag,now(), OLD.prix, NEW.prix);
    RETURN NEW;
    END ;

$$
LANGUAGE plpgsql;

CREATE TRIGGER historique_trigger
AFTER UPDATE
ON baguette
FOR EACH ROW
WHEN (OLD.prix <> NEW.prix)
EXECUTE PROCEDURE historique();



--ALTER TABLE baguette ENABLE TRIGGER historique_trigger; --activer

--UPDATE baguette SET prix = 25 WHERE bois = 'orme';