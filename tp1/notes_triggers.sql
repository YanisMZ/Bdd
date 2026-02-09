CREATE VIEW statNotes(codecours, meilleure_note, moins_bonne_note, moyenne_note) AS (
    SELECT codecours,
           MAX(note),
           MIN(note),
           AVG(note)
    FROM suit
    GROUP BY codecours
);


CREATE OR REPLACE FUNCTION harmonisation()
RETURNS TRIGGER AS
$$
 DECLARE
    old_min FLOAT;
    old_max FLOAT;
    a FLOAT;
    b FLOAT;
BEGIN
    
    SELECT MIN(note), MAX(note)
    INTO old_min, old_max
    FROM Notes
    WHERE codeCours = NEW.codeCours;

 
    a := (NEW.max - NEW.min) / (old_max - old_min);
    b := NEW.min - a * old_min;

    UPDATE Notes
    SET note = a * note + b
    WHERE codeCours = NEW.codeCours;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER 
INSTEAD OF UPDATE 
ON suit
FOR EACH ROW
EXECUTE FUNCTION harmonisation();










