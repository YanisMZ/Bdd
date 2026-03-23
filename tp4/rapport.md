## exercice 1


- ctid(0,3) le premier chiffre represente le numero du block,
le deuxieme chiffre reprensente sa position dans le block

- xmin le numero de la transaction qui a cree le tuple

- xmax : Le numéro de la transaction qui a demandé la suppression du tuple (peut être vu lorsque qu'on commence un transaction ou une modification par begin, car après une update le tuple est supprimé et remplacé par un autre).


#### 2-
poudlarddb=> insert into test(a, b) values (5, 6);
INSERT 0 1
poudlarddb=> insert into test(a, b) values (7, 6);
INSERT 0 1
poudlarddb=> SELECT *, ctid, xmin, xmax FROM test;
 id | a | b | ctid  | xmin | xmax 
----+---+---+-------+------+------
  1 | 5 | 6 | (0,1) | 2069 |    0
  2 | 7 | 6 | (0,2) | 2070 |    0
(2 rows)

#### 4-
xmax ne se met pas à 0 alors qu'on a fait un rollback.

pendant la transaction
delete je vois
update je vois pas
parce que
delete le supprime directe alors que update marque comme suppr

## exercice 2

#### 1-
un seul bloc (chercher dans ctid 2eme veleur)

#### 3-
185 enregistrements par bloc
environ 55 blocs

#### 4-
(32* 185* 10 /8 octect)(7  champs (xmax,xmin ...etc)  + les 3 int (id ,a , b))

8000 octet un bloc


## exercice 3

#### 2-
le nombre de bloc ne changent pas, le bloc n'est pas encore vide

#### 3-
INSERT INTO test(a,b)
SELECT 99, round(random()*100)
FROM generate_series (1,4000);
le nombre d'enregistrement ne change pas on insert sur des enregistrements vides.

#### 4- 
4-
update from test set b = b + 1 where a = 99;
quand on fait un update on marque comme suppr et et insert 

 relpages | reltuples 
----------+-----------
       55 |      9517

 relpages | reltuples 
----------+-----------
       74 |      9517



#### 5

