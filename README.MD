# ENG | Cuff Script for ESX 🚔

## Description
This is an optimized cuff script for ESX that allows players to handcuff and unhandcuff other players in FiveM. The script is highly efficient, consuming minimal resources (0.0ms).

## Features
- 🔒 Handcuff and unhandcuff players
- 🌐 Configurable language (English and French)
- 🛠️ Customizable default key for the cuff command

## Installation

1. 📥 Clone or download this repository. If you download the ZIP file, 
make sure to remove the `-main` from the folder name.
2. ➕ Add the resource to your `server.cfg`:
    ```plaintext
    ensure nks_cuff
    ```
3. ⚙️ Configure the `config.json` file to set the language and default key:
    ```json
    {
        "language": "eng",
        "defaultKey": "YOUR KEY" (Example: "F5")
    }
    ```

## Usage

- 🗝️ Use the default key (configured in `config.json`) to handcuff or unhandcuff the nearest player.
- 💬 You can also use the `/cuff` command in the chat.

---

# FR | Script de Menottes pour ESX 🚔

## Description
Ceci est un script de menottes optimisé pour ESX qui permet aux joueurs de menotter et de démenotter d'autres joueurs dans FiveM. Le script est très efficace, consommant peu de ressources (0.0ms).

## Fonctionnalités
- 🔒 Menotter et démenotter les joueurs
- 🌐 Langue configurable (anglais et français)
- 🛠️ Touche par défaut personnalisable pour la commande de menottage

## Installation

1. 📥 Clonez ou téléchargez ce dépôt. Si vous téléchargez le fichier ZIP, 
assurez-vous de retirer le `-main` du nom du dossier.
2. ➕ Ajoutez la ressource à votre `server.cfg` :
    ```plaintext
    ensure nks_cuff
    ```
3. ⚙️ Configurez le fichier `config.json` pour définir la langue et la touche par défaut :
    ```json
    {
        "language": "fr",
        "defaultKey": "TA TOUCHE" (Exemple : "F5")
    }
    ```

## Utilisation

- 🗝️ Utilisez la touche par défaut (configurée dans `config.json`) pour menotter ou démenotter le joueur le plus proche.
- 💬 Vous pouvez également utiliser la commande `/cuff` dans le chat.