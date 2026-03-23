
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



--- question 3

--- Pour l'organisateur il verifie que le nombre de joueur ne depasse pas le nbmax 
SELECT COUNT(*) 
FROM demande 
NATURAL JOIN partie 
WHERE etat = 'ouvert' 
AND pid = 2 
HAVING COUNT(*) <= (SELECT nbmax FROM partie WHERE pid = 2);


--- Pour le joueur il s'ajoute car la partie est encore ouverte
select etat from partie where etat = 'ouvert' and pid = 2;
Insert Into demande values (5,2, now(),'en attente');
commit;


--- Pour l'organisateur(il cherche pas a comprendre comme il a deja verifier nb joueur est inferieur a nbmax donc il valide tout le monde sauf que entre temps un jouer s'est ajouté)
select etat from partie where etat = 'ouvert' and pid = 2;
Update partie set etat = 'ferme' where pid = 2;
Update demande set statut = 'valide' where pid = 2;
commit;


--question 4 


-- joueur 1 (il s 'ajoute sans commit)
select etat from partie where etat = 'ouvert' and pid = 2;
Insert Into demande values (4,2, now(),'en attente');



---- joueur 2 (il s'ajoute avec commit)
select etat from partie where etat = 'ouvert' and pid = 2;
Insert Into demande values (5,2, now(),'en attente');
commit;



----- l'organisatuer valide( valide la partie avec le joeueur 2 )
select etat from partie where etat = 'ouvert' and pid = 2;
Update partie set etat = 'ferme' where pid = 2;
Update demande set statut = 'valide' where pid = 2;
commit;


---- (le joueur 1 va commit)
commit;


--- le joueur 1 aura une date plus ancienne mais ne sera pas accepté 



--- question 5 



--- l'organisateur 1 valide la partie 

SELECT COUNT(*) 
FROM demande 
NATURAL JOIN partie 
WHERE etat = 'ouvert' 
AND pid = 2 
HAVING COUNT(*) <= (SELECT nbmax FROM partie WHERE pid = 2);


select etat from partie where etat = 'ouvert' and pid = 2;
Update partie set etat = 'ferme' where pid = 2;
Update demande set statut = 'valide' where pid = 2;



---- l'organisateur 2 annule la partie

select etat from partie where etat = 'ouvert' and pid = 2;
Update partie set etat = 'annulé' where pid = 2;

--- l'organisateur 1 commit
commit; 


---- l'organsateur annule les joueurs en attente

select * from demande where etat = "en attente"
Update demande set statut = "annule" where pid = 2;



--- ne focntionne pas en repeatable read

















