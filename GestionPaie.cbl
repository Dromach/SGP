       IDENTIFICATION DIVISION.                                                 *> Cette division contient des informations sur le programme
       PROGRAM-ID. GestionPaie.

       ENVIRONMENT DIVISION.                                                    *> Cette division contient des informations sur l'environnement
       INPUT-OUTPUT SECTION.                                                    *> Cette section permet de gerer et déclarer les variables des fichiers
       FILE-CONTROL.
           SELECT EMP-FILE ASSIGN TO "employes.csv"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL.                                           *> Décrit les types des fichiers et comment les traités
           SELECT OUTPUT-FILE ASSIGN TO "rapport.txt"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL.                                           *> Dans ce cas, les fichiers sont des fichiers textes et traités ligne par ligne (séquentiel)

       DATA DIVISION.                                                           *> Cette division contient les déclarations des données du programme
       FILE SECTION.
       FD EMP-FILE.                                                             *> le mot-clé FD déclare le fichier (dans ce cas ci celui d'entrée)
       01 EMP-RECORD PIC X(80).                                                 *> Cette ligne décrit la structure d'une ligne du fichier

       FD OUTPUT-FILE.                                                          *> le mot-clé FD déclare le fichier (dans ce cas ci celui de sortie)
       01 OUTPUT-RECORD.                                                        *> Cette ligne décrit la ligne a sortir avec son nombre de caractères maximum
           05 OUTPUT-FIELD PIC X(80).                                           *> Cette ligne décrit le champ de la ligne a sortir avec son nombre de caractères maximum

       WORKING-STORAGE SECTION.                                                 *> Cette section contient les variables temporaires
       01 NET-SALARY       PIC 9(4).99.                                         *> NET-SALARY va stocker le salaire net calculé
       01 EOF-FLAG         PIC X VALUE 'N'.                                     *> Indicateur de fin de fichier ('N' = pas fini, 'O' = fini)
       01 TEMP-STRING      PIC X(80).                                           *> Variable temporaire pour formater la sortie
       01 EMP-NAME         PIC X(30).                                           *> le mot-clé PIC défini le type et la taille de la variable (X=caractères alphanumériques, 30=taille)
       01 EMP-SALARY-BRUT  PIC 9(5)V99.                                         *> 9=chiffres, 5=chiffres avant la virgule, V99=partie décimale de 2 chiffres
       01 EMP-TAX-RATE     PIC 9(1)V99.                                         *> 9=chiffres, 1=chiffres avant la virgule, V99=partie décimale de 2 chiffres
       01 EMP-DEDUCTIONS   PIC 9(4).                                            *> 9=chiffres, 4=chiffres sans virgule
       01 TEMP-LINE        PIC X(80).                                           *> Variable temporaire pour lire une ligne du fichier

       PROCEDURE DIVISION.                                                      *> Cette division contient toute la logique du programme
      *> cobol-lint CL002 main-procedure
       MAIN-PROCEDURE.
           OPEN INPUT EMP-FILE.                                                 *> Ouvre les fichiers pour ecriture (output) et lecture (input)
           OPEN OUTPUT OUTPUT-FILE.

           PERFORM UNTIL EOF-FLAG = 'O'                                         *> Boucle qui lit le fichier ligne par ligne jusqu'à la fin
               READ EMP-FILE AT END                                             *> Lit une ligne du fichier jusqu'à la fin
                   SET EOF-FLAG TO 'O'                                          *> Si on est à la fin du fichier, EOF-FLAG est mis à 'O' et ca coupe la boucle
               NOT AT END                                                       *> tant qu'on est pas a la fin on lit ce bout de code
                   MOVE EMP-RECORD TO TEMP-LINE                                 *> le mot-clé MOVE permet de copier une variable dans une autre
                   UNSTRING TEMP-LINE DELIMITED BY ","
                       INTO EMP-NAME EMP-SALARY-BRUT EMP-TAX-RATE 
                       EMP-DEDUCTIONS                                           *> le mot-clé UNSTRING permet de découper une chaine de caractères en plusieurs variables
                   COMPUTE NET-SALARY = EMP-SALARY-BRUT                         *> le mot-clé permet de calculer le salaire net (brut - impots - deductions)
                        - (EMP-SALARY-BRUT * EMP-TAX-RATE)
                        - EMP-DEDUCTIONS
                   STRING EMP-NAME ' - Salaire Net: ' NET-SALARY                *> le mot-clé STRING permet de formater notre resultat et le concatener a une chaine de caractères
                       DELIMITED BY SIZE
                       INTO TEMP-STRING
                   END-STRING
                   MOVE TEMP-STRING TO OUTPUT-FIELD                             *> le mot-clé MOVE permet de copier une variable dans une autre
                   WRITE OUTPUT-RECORD                                          *> le mot-clé WRITE permet d'écrire la ligne formater dans le fichier de sortie
               END-READ
           END-PERFORM.                                                         *> Fin de la boucle

           CLOSE EMP-FILE.                                                      *> Ferme les fichiers
           CLOSE OUTPUT-FILE.

           STOP RUN.                                                            *> Termine l'exécution du programme
