DROP TRIGGER IF EXISTS requis ON suit;
CREATE OR REPLACE FUNCTION cours_requis()
RETURNS TRIGGER AS $$
DECLARE
    c_req CHAR(4);
BEGIN
  
    FOR c_req IN
        SELECT codeCoursRequis
        FROM requiert
        WHERE codeCours = NEW.codecours
    LOOP
        INSERT INTO suit(numEl, codecours, note)
        SELECT NEW.numEl, c_req, NULL
        WHERE NOT EXISTS (
            SELECT 1
            FROM suit
            WHERE numEl = NEW.numEl
              AND codecours = c_req
        );
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE TRIGGER requis
AFTER INSERT ON suit
FOR EACH ROW
EXECUTE FUNCTION cours_requis();



--ALTER TABLE suit ENABLE TRIGGER requis;









