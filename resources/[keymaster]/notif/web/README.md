# NEVA Notifications UI

Système de notifications pour NEVA Framework basé sur RxNotify avec Vue.js et Tailwind CSS.

## Installation

1. Installer les dépendances :
```bash
npm install
# ou
yarn install
```

## Build

Pour compiler le projet en production :
```bash
npm run build
# ou
yarn build
```

Le build sera généré dans le dossier `build/`.

## Développement

Pour le mode développement avec hot-reload :
```bash
npm run dev
# ou
yarn dev
```

## Structure

- `src/App.vue` - Composant principal Vue.js
- `src/components/NotificationContainer.vue` - Composant de notification
- `src/stores/script.js` - Store Pinia pour la configuration
- `src/composables/useNui.js` - Composable pour les messages NUI
- `src/assets/css/` - Styles CSS et Tailwind
- `vite.config.js` - Configuration Vite
- `tailwind.config.js` - Configuration Tailwind CSS
- `index.html` - Template HTML

## Compatibilité

Le système écoute les messages NUI suivants (compatibles avec le système NEVA existant) :
- `SendNotif:Classic` - Notifications simples
- `SendNotif:Big` - Notifications avancées
- `Notifications:Hide` - Masquer toutes les notifications
- `Notifications:Show` - Afficher les notifications

## Notes

- Les notifications sont positionnées en bas à gauche par défaut
- Le système utilise Vue.js 3 avec Composition API
- Tailwind CSS est utilisé pour le styling
- Les animations sont fluides et modernes
