# NUI React Prompt

Interface de prompt/dialogue pour FiveM NUI construite avec React, TypeScript et Vite.

## Fonctionnalités

- 💬 Système de prompt interactif avec boutons Accepter/Refuser
- ⌨️ Raccourcis clavier (Y pour accepter, N pour refuser)
- 🎨 Formatage de texte avec couleurs personnalisées
- ✨ Animations d'entrée/sortie fluides
- 🔄 Communication bidirectionnelle avec FiveM

## Structure du projet

```
src/
├── components/        # Composants React
│   └── Prompt.tsx    # Composant principal du prompt
├── hooks/            # Hooks personnalisés
│   └── useNuiEvent.ts # Hook pour écouter les événements NUI
├── providers/        # Providers React Context
│   └── VisibilityProvider.tsx # Gestion de la visibilité
├── utils/            # Utilitaires
│   ├── fetchNui.ts   # Communication avec FiveM
│   └── misc.ts       # Fonctions utilitaires
├── App.tsx           # Composant App avec routing
├── main.tsx          # Point d'entrée
└── index.css         # Styles globaux
```

## Installation

```bash
npm install
```

## Développement

```bash
npm run dev
```

L'application sera accessible sur `http://localhost:5173` (par défaut).

### 🛠️ Outils de développement

Lorsque vous êtes dans le navigateur (mode développement), un panneau **DevTools** s'affiche automatiquement sur la droite de l'écran. Il vous permet de :

- 📝 Modifier le titre, la description et la description2 du prompt
- 📤 Envoyer un événement pour afficher le prompt
- 👁️ Afficher/Masquer l'interface
- 📖 Consulter les codes de couleur disponibles
- ⌨️ Voir les raccourcis clavier

**Pour tester :**
1. Lancez `npm run dev`
2. Ouvrez votre navigateur
3. Utilisez le panneau DevTools à droite pour envoyer des prompts
4. Testez les raccourcis clavier Y (accepter) et N (refuser)

Les DevTools ne s'affichent **que** dans le navigateur et sont automatiquement désactivés en jeu.

## Build

```bash
npm run build
```

Le build sera généré dans le dossier `build/`.

## Utilisation dans FiveM

### Côté Client (Lua)

```lua
-- Afficher le prompt
SendNUIMessage({
  action = "createPrompt",
  data = {
    title = "Titre du prompt",
    description = "Description principale",
    description2 = "Description secondaire"
  }
})

-- Gérer la visibilité
SendNUIMessage({
  action = "setVisible",
  data = true
})

-- Callbacks
RegisterNUICallback("prompt:accept", function(data, cb)
  print("Prompt accepté")
  cb("ok")
end)

RegisterNUICallback("prompt:refuse", function(data, cb)
  print("Prompt refusé")
  cb("ok")
end)
```

### Formatage du texte

Le système supporte plusieurs codes de couleur :
- `~w~` - Blanc
- `~r~` - Rouge
- `~g~` - Vert
- `~b~` - Bleu
- `~y~` - Jaune
- `~h~` - Gras (highlight)
- `\n` - Nouvelle ligne

Exemple :
```lua
title = "~h~ATTENTION~h~"
description = "~r~Action dangereuse~w~\nÊtes-vous sûr ?"
```

## Technologies

- React 18
- TypeScript
- Vite
- React Router
