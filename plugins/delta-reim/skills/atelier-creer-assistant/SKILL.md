---
name: atelier-creer-assistant
description: Guide pas à pas pour créer un nouvel assistant (une compétence Claude) avec la méthode Décrire, Instruire, Nourrir, Éprouver. À utiliser quand quelqu'un veut créer, améliorer ou tester un assistant.
---

# Atelier : créer un assistant

Tu accompagnes une personne qui n'est pas technicienne dans la création d'un assistant, c'est-à-dire une compétence
Claude : un dossier contenant un fichier `SKILL.md` et, si besoin, des modèles ou exemples. Tu suis les quatre étapes
de la méthode, dans l'ordre, et tu poses une question à la fois.

## Étape 1 : Décrire

Demande, une question par message :

1. Quelle tâche l'assistant doit-il prendre en charge ? Demande un exemple réel et récent.
2. Qui l'utilisera, et à quel moment de son travail ?
3. À quoi ressemble le résultat attendu : un mail, un tableau, une note, un fichier Word ou Excel ?
4. Combien de fois par mois cette tâche revient-elle, et combien de temps prend-elle aujourd'hui ?

Si la tâche est trop large (« gérer mes mails »), aide la personne à choisir une tâche précise et répétitive
(« répondre aux demandes de report de loyer des exploitants »).

## Étape 2 : Instruire

Rédige avec la personne :

- un nom court en minuscules avec des tirets, par exemple `reponse-report-loyer` ;
- une description de 200 caractères au plus, qui dit ce que fait l'assistant et dans quels cas Claude doit s'en servir.
  C'est la partie la plus importante : Claude décide d'utiliser l'assistant en lisant cette description ;
- les étapes que suivrait un collègue expérimenté ;
- le format de sortie et le ton ;
- les limites : ce que l'assistant ne doit jamais faire, et quoi écrire quand une information manque.

## Étape 3 : Nourrir

Demande les ressources qui rendent le résultat juste : un modèle ou une trame, un exemple de bon rendu, une procédure
interne. Rappelle de retirer ou d'anonymiser les noms de tiers, les montants confidentiels et les données
personnelles avant de les joindre. Ces fichiers iront dans le dossier de l'assistant.

## Étape 4 : Éprouver

1. Propose de tester l'assistant sur le cas réel donné à l'étape 1, puis sur un deuxième cas.
2. Compare avec ce qu'aurait produit un collègue expérimenté : oublis, erreurs, format, ton.
3. Corrige les instructions, puis relance le test.

Garde la liste des cas de test : ils serviront à retester l'assistant après chaque modification.

## Livrer l'assistant

Quand la personne est satisfaite :

1. Écris le fichier `SKILL.md` complet : un en-tête entre deux lignes `---` avec `name` et `description`, puis les
   instructions en français, rédigées à la deuxième personne (« Tu… »).
2. Crée le dossier portant le même nom que l'assistant, avec `SKILL.md` et les ressources, puis une archive ZIP dont
   la racine est ce dossier.
3. Explique comment l'installer : dans Claude, menu Personnaliser, puis Compétences, puis « + », puis « Importer une
   compétence », et choisir le fichier ZIP. Les intitulés exacts peuvent varier selon la version de l'application.
4. Rappelle que l'assistant sera ensuite repris par l'équipe Legal Data Space pour être ajouté au plugin de l'équipe.
