#!/bin/bash

# exxecuter sudo ./install-config.sh
# Définir les chemins source et destination
SOURCE_DIR="./conky"
DEST_DIR="~/.config/conky"

# Vérifier si le dossier source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Le dossier source $SOURCE_DIR n'existe pas."
    exit 1
fi

# Vérifier si le dossier de destination existe
if [ ! -d "$DEST_DIR" ]; then
    echo "Le dossier de destination $DEST_DIR n'existe pas. Création du dossier."
    mkdir -p "$DEST_DIR"
fi

# Supprimer tous les fichiers existants dans le dossier de destination
echo "Suppression des fichiers existants dans $DEST_DIR..."
rm -rf "$DEST_DIR"/*

# Copier tous les fichiers du dossier source vers le dossier de destination
echo "Copie des fichiers de $SOURCE_DIR vers $DEST_DIR..."
cp -r "$SOURCE_DIR"/* "$DEST_DIR"

echo "Installation terminée !"
