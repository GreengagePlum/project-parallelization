# Projet Programmation Parallèle

## Description générale

Il s'agira de paralléliser un code de génération des ensembles fractals
de Julia, célèbre mathématicien français du début du 20ème siècle.

Le code de départ que vous devrez paralléliser vous est donné sur ce git.

## Parallélisation naïve en OpenMP

Vous écrirez une version OpenMP naïve en partageant simplement l'image à
générer en blocs de taille fixe.

Vous effectuerez ensuite des mesures de performances, sur différents exemples
d'utilisation (par exemple ceux qui sont fournis au début du fichier source),
pour montrer que cette solution n'est pas très efficace en raison du
déséquilibre de charge entre les threads.

Fournissez cette version `julia_omp.c` dans votre rendu, et les mesures de
performances qui démontrent ce déséquilibre dans votre rapport
(accompagné de votre méthodologie de test et de la description de votre
architecture de test).

Il est facile de corriger la version OpenMP précédente pour garantir
l'équilibre de charge entre threads OpenMP. Faites-le et vérifiez qu'il n'y
a plus de déséquilibre.

## Parallélisation efficace en OpenMP et MPI

Il s'agira ensuite de paralléliser ce code en MPI afin de pouvoir l'exécuter
sur un cluster parallèle.
Vous écrirez un code MPI *et* OpenMP, à partir de la version précédente.
Vous déposerez ce fichier sur moodle en le nommant `julia_mpi_omp.c`.

Pour éviter que la distribution MPI ne subisse les mêmes effets de déséquilibre
entre processus qu'observé précédemment, il est nécessaire d'effectuer
une distribution des calculs intelligente. On pourrait utiliser une
distribution dynamique à la manière d'OpenMP en l'implémentant en MPI,
mais je vous propose d'implémenter une distribution régulière astucieuse qui
fonctionnera aussi : une distribution cyclique par ligne,
où chaque processus calcule les lignes de l'image dont le modulo
`nb_process` est égal à son `rang`. De cette manière, les lignes très complexes
à calculer et les lignes plus simples sont réparties à peu près uniformément
parmi tous les processus.

Le problème sera ensuite de rassembler ces données entrelacées sur le processus
maître qui doit effectuer la sauvegarde de l'image. Vous pourrez résoudre ce
problème en définissant votre propre `datatype` MPI, ce qui vous permettra
d'envoyer toutes ces données depuis chaque processus en une seule
communication MPI (par processus émetteur), et les rassembler aux bons
emplacements mémoire sur le processus maître.

Faites des mesures de performance et donnez-les dans votre rapport,
qui devra démontrer que votre accélération est quasi-linéaire en prenant en
compte les communications.

**Note 1.**
*Comme référence, j'obtiens un speedup de plus de 61 sur les 64 (16 * 4) coeurs
de la machine virtuelle vmCalculParallele, sur le plus gros exemple donné dans
le fichier source (`orange_huge`)*.

**Note 2.**
Pour lancer votre programme sur le cluster,
vous utiliserez l'option suivante permettant de lancer un
processus MPI par noeud *et* OpenMP pour utiliser les différents coeurs
disponibles sur le noeud : `mpirun --map-by ppr:1:node`


## Instructions de dépôt

Vous déposerez les trois fichiers `julia_omp.c`, `julia_mpi_omp.c` et
`rapport.pdf` sur moodle, **sans faire d'archive**.
Un seul dépôt est nécessaire par binôme. N'oubliez pas d'indiquer les noms des
deux participants dans le rapport et dans les fichiers sources.
