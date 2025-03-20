# Raccourcis clavier Sway - Configuration Mac US

Ce document présente les raccourcis clavier configurés pour Sway sur un clavier Mac US. La touche Mod par défaut est configurée sur `Mod4` (touche Command ⌘ sur Mac).

## Raccourcis essentiels

| Raccourci | Action |
|-----------|--------|
| `⌘ + Entrée` | Ouvrir le terminal |
| `⌘ + d` | Lancer le menu d'applications (wofi) |
| `⌘ + Shift + q` | Fermer la fenêtre active |
| `⌘ + Shift + c` | Recharger la configuration Sway |
| `⌘ + Shift + e` | Quitter Sway (avec confirmation) |

## Navigation

| Raccourci | Action |
|-----------|--------|
| `⌘ + h` | Déplacer le focus vers la gauche |
| `⌘ + j` | Déplacer le focus vers le bas |
| `⌘ + k` | Déplacer le focus vers le haut |
| `⌘ + l` | Déplacer le focus vers la droite |
| `⌘ + flèches` | Alternative pour déplacer le focus (si configuré) |

## Gestion des fenêtres

| Raccourci | Action |
|-----------|--------|
| `⌘ + Shift + h` | Déplacer la fenêtre vers la gauche |
| `⌘ + Shift + j` | Déplacer la fenêtre vers le bas |
| `⌘ + Shift + k` | Déplacer la fenêtre vers le haut |
| `⌘ + Shift + l` | Déplacer la fenêtre vers la droite |
| `⌘ + r` | Activer le mode redimensionnement |
| `⌘ + f` | Basculer la fenêtre en mode plein écran |
| `⌘ + Shift + espace` | Basculer la fenêtre en mode flottant |
| `⌘ + espace` | Basculer entre les layouts |

## Espaces de travail

| Raccourci | Action |
|-----------|--------|
| `⌘ + 1-5` | Passer à l'espace de travail correspondant |
| `⌘ + Shift + 1-5` | Déplacer la fenêtre active vers l'espace de travail correspondant |

## Capture d'écran (avec grim/slurp)

| Raccourci | Action |
|-----------|--------|
| `⌘ + Print` | Capture d'écran complète (à configurer) |
| `⌘ + Shift + Print` | Capture de zone (à configurer) |

## Mode système

Pour accéder aux fonctions système comme l'arrêt ou le redémarrage, vous pouvez configurer un mode système :

1. Appuyez sur `⌘ + Escape` pour entrer dans le mode système
2. Puis utilisez :
   - `r` pour redémarrer
   - `s` pour éteindre
   - `l` pour verrouiller l'écran
   - `Escape` ou `Entrée` pour annuler

## Notes pour clavier Mac US

- La touche Command (⌘) est utilisée comme touche Mod dans cette configuration
- Certaines touches spéciales comme Print Screen peuvent nécessiter des combinaisons différentes sur Mac
- Pour les touches média (volume, luminosité), utilisez les touches de fonction avec Fn

## Personnalisation

Pour personnaliser ces raccourcis, modifiez le fichier de configuration Sway :

```
~/.config/sway/config
```

Ou dans votre cas, modifiez le fichier NixOS correspondant :

```
home-manager/pkgs/sway/default.nix
```

Après modification, rechargez la configuration avec `⌘ + Shift + c` ou reconstruisez votre configuration NixOS.