
DROP TABLE IF EXISTS test CASCADE;

CREATE TABLE test(
a int,
b int
);



INSERT INTO test (a,b) VALUES
(1, 1),(2,2);

---question 1

--organistateur
Begin;

SELECT COUNT(*) 
FROM demande 
NATURAL JOIN partie 
WHERE etat = 'ouvert' 
AND pid = 8
HAVING COUNT(*) <= (SELECT nbmax FROM partie WHERE pid = 8);

UPDATE partie set etat = "fermé" where pid = 8;
UPDATE demande set statut = 'valide' where pid = 8;

--Joueur (le joueur se désiste d’une partie )
Begin;
SELECT * from partie where pid = 8;

SELECT * from demande where pid = 8;
DELETE from demande where pid = 8 and jid = 1;

--joueur
commit;


--organistateur 
commit;


---REPEATABLE READ erreur update en paralle;

 
-- question 2

--- Pour l'organisateur (il verifie que la partie est ouverte donc il annule la partie et il met tous les joueur en refusés saut qu il ne commit pas
Begin;
select etat from partie where etat = 'ouvert' and pid = 8;
Update partie set etat = 'annule' where pid = 8;
Update demande set statut = 'refuse' where pid =8;



---Pour le joueur (il s'ajoute donc en attente automatiquement )
Begin;
select etat from partie where etat = 'ouvert' and pid = 8;
Insert Into demande values (3,8, now(),'en attente');

--- Pour l'organisateur 
commit;
--- Pour le joueur
commit;

--- cela ne marche pas en serializable