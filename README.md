# Assistants Claude de Delta Reim

Place de marché de plugins Claude tenue par Legal Data Space pour l'équipe Delta Reim. Elle contient les assistants
(compétences Claude) construits pendant la formation-action. Ils fonctionnent dans Claude sur le web, dans
l'application Claude Desktop et dans Cowork.

## Contenu

| Plugin | Assistants |
|---|---|
| `delta-reim` | `fiche-synthese-bail` : fiche synthèse d'un bail avec l'article source de chaque information |
| | `compte-rendu-reunion` : compte rendu avec décisions, actions et points ouverts |
| | `atelier-creer-assistant` : guide pour créer un nouvel assistant avec la méthode Décrire, Instruire, Nourrir, Éprouver |

Les assistants de démarrage sont génériques et ne contiennent aucune donnée de Delta Reim.

## Installation

Il faut un abonnement Claude payant (Team ou Max) et l'option de création et modification de fichiers activée
(Paramètres, puis Capacités).

### Pour toute l'équipe (abonnement Team, par un propriétaire de l'organisation)

1. Paramètres de l'organisation, puis Plugins et compétences, puis Ajouter.
2. Choisir « Importer un plugin » et sélectionner le fichier `plugin-delta-reim.zip` fourni par Legal Data Space.
3. Dans l'inventaire, régler l'accès du plugin sur « Installé par défaut ».

Seuls les propriétaires de l'organisation voient cette page. Le rôle « Admin » ne suffit pas.

### Pour une seule personne

1. Menu Personnaliser, onglet Plugins, puis Ajouter, puis « Ajouter une place de marché ».
2. Saisir l'adresse du dépôt : `Legal-Data-Space/delta-reim`.
3. Dans l'onglet Découvrir, choisir le plugin `delta-reim` et cliquer sur Ajouter.

Autre possibilité : Personnaliser, Plugins, Ajouter, « Importer un plugin », avec le fichier `plugin-delta-reim.zip`.

### Un seul assistant, sans plugin

Personnaliser, Compétences, « + », « Importer une compétence », puis choisir le fichier `skill-<nom>.zip`.

Les intitulés des menus peuvent varier selon la langue et la version de l'application.

## Utilisation

Une fois le plugin installé, Claude utilise l'assistant quand la demande correspond à sa description, par exemple
« Fais la fiche synthèse de ce bail » avec le bail en pièce jointe. On peut aussi l'appeler directement en tapant `/`
dans la zone de saisie.

## Contact

Legal Data Space, contact@legaldataspace.eu
