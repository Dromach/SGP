# SGP (Système de Gestion de Paie) en COBOL

## Description
Ce projet est un programme COBOL qui lit un fichier CSV contenant les informations des employés (nom, salaire brut, taux d'imposition et déductions) et génère un rapport contenant leur salaire net.

## Fonctionnalités
- Lecture d'un fichier CSV contenant les informations des employés.
- Calcul automatique du salaire net en soustrayant les taxes et déductions.
- Génération d'un fichier de sortie `rapport.txt` contenant les salaires nets formatés.
- Gestion des erreurs et validation des données.

## Prérequis
Avant d'exécuter ce programme, assurez-vous d'avoir :
- GNU COBOL installé sur votre machine.  
  Sur Linux, vous pouvez l'installer avec :
  ```sh
  sudo apt install gnucobol
  ```
  Sur Windows, vous pouvez utiliser mingw-w64 avec GnuCOBOL.

## Structure du projet
```bash
/GestionPaie
│── employes.csv      # Fichier d'entrée contenant les informations des employés
│── rapport.txt       # Fichier de sortie avec les salaires nets générés
│── gestion_paie.cbl  # Code source du programme COBOL
│── README.md         # Documentation du projet
```

## Format du fichier employes.csv
Le fichier doit être au format CSV avec les valeurs séparées par des virgules :
```csv
Nom, Salaire Brut, Taux d'Imposition, Déductions
Jean Dupont, 3000.00, 0.20, 50
Alice Martin, 2500.00, 0.18, 40
Marc Dubois, 2800.00, 0.22, 60
```

## Compilation et exécution
Pour compiler le programme COBOL, utilisez la commande suivante :
```sh
cobc -x -o GestionPaie GestionPaie.cbl
```
ou simplement :
```sh
cobc -x GestionPaie.cbl
```
Exécutez ensuite le programme avec :
```sh
./GestionPaie
```
Verifiez le fichier `rapport.txt` pour voir les salaires nets générés.

## Exemple de rapport généré
```txt
Jean Dupont - Salaire Net: 2300.00
Alice Martin - Salaire Net: 2050.00
Marc Dubois - Salaire Net: 2164.00
```

## Auteur
- [Yann TAURON](https://github.com/Dromach)
