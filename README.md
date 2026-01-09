# Nginx Log Analyser
Outil en bash pour analyser les fichiers de logs Nginx et extraire des statistiques utiles.

## Description
Ce script permet d'analyser des fichiers de logs Nginx en :

- Identifiant les **Top 5 des IPs** avec le plus de requêtes
- Listant les **Top 5 des chemins (paths)** les plus demandés
- Affichant les **Top 5 des codes de statut HTTP** les plus fréquents
- Fournissant des statistiques formatées et lisibles

**Cas d'usage :** Analyse rapide de logs serveur pour identifier les patterns de trafic, détecter des anomalies, ou monitorer l'activité d'un serveur web.

## Prérequis
- Système Linux (Ubuntu, Debian, etc.) ou macOS
- Bash 4.0+
- Commandes système : `awk`, `sort`, `uniq`, `grep`
- Fichier de logs Nginx au format standard

## 📥 Installation

### 1. Cloner le repository
```bash
git clone https://github.com/AMM48/devops-lab.git
cd devops-lab/Devops-Project3_Nginx_Log_Analyser
```

### 2. Copier le script dans le système
```bash
sudo cp nginx_log_analyser.sh /usr/local/bin/nginx-log-analyser
sudo chmod +x /usr/local/bin/nginx-log-analyser
```

## Utilisation

### Syntaxe
```bash
nginx-log-analyser <chemin_vers_fichier_logs>
```

### Exemples

**Analyser les logs Nginx par défaut :**
```bash
nginx-log-analyser /var/log/nginx/access.log
```

**Analyser un fichier de logs personnalisé :**
```bash
nginx-log-analyser ./nginx.log
```

### Résultat

```
======================================
TOP 5 DES IPs AVEC LE PLUS DE REQUESTS
======================================
178.128.94.113 - 245 requests
142.93.136.176 - 234 requests
138.68.248.85 - 198 requests
159.89.185.30 - 187 requests
45.76.135.253 - 142 requests

======================================
TOP 5 DES PATH LES PLUS UTILISE
======================================
/v1-health - 1523 requests
/ - 89 requests
/api/v1/users - 45 requests
/static/css/main.css - 32 requests
/favicon.ico - 28 requests

======================================
TOP 5 STATUS CODE LES PLUS FREQUENTS
======================================
200 - 1845 requests
404 - 123 requests
500 - 12 requests
301 - 8 requests
403 - 3 requests
```

## Format de log supporté

Le script analyse les logs au **format Nginx standard** :
```
IP - - [Date] "METHOD PATH PROTOCOL" STATUS SIZE "REFERER" "USER_AGENT"
```

Exemple :
```
178.128.94.113 - - [04/Oct/2024:00:00:18 +0000] "GET /v1-health HTTP/1.1" 200 51 "-" "DigitalOcean Uptime Probe"
```

## Configuration du Cron (Automatisation)

### Éditer le crontab
```bash
crontab -e
```

### Exemples de planification

**Analyser les logs toutes les heures :**
```bash
0 * * * * /usr/local/bin/nginx-log-analyser /var/log/nginx/access.log >> /var/log/nginx_analysis.log
```

**Tous les jours à 1h du matin :**
```bash
0 1 * * * /usr/local/bin/nginx-log-analyser /var/log/nginx/access.log >> /var/log/nginx_analysis.log
```

**Toutes les 6 heures :**
```bash
0 */6 * * * /usr/local/bin/nginx-log-analyser /var/log/nginx/access.log >> /var/log/nginx_analysis.log
```

### ⚠️ Important pour cron
Toujours utiliser des **chemins ABSOLUS** dans le crontab :

✅ `/usr/local/bin/nginx-log-analyser /var/log/nginx/access.log`
❌ `nginx-log-analyser ./logs/nginx.log` (ne fonctionnera pas)

### Vérifier que le cron fonctionne
```bash
# Voir les crons actifs
crontab -l

# Vérifier les logs du cron
tail -f /var/log/syslog | grep CRON
```

## Ce que j'ai appris sur ce projet

### Concepts Bash
- **Arguments de script** : Utilisation de `$1` pour récupérer le fichier de logs
- **Pipes multiples** : Chaînage de commandes avec `|` pour traiter les données
- **Formatage de sortie** : Utilisation d'`awk` pour afficher des résultats personnalisés

### Commandes Linux essentielles
- `awk '{print $N}'` : Extraction de colonnes spécifiques (champ 1=IP, 7=path, 9=status)
- `sort | uniq -c` : Comptage des occurrences uniques
- `sort -n -r` : Tri numérique inversé (du plus grand au plus petit)
- `head -5` : Limitation aux 5 premiers résultats
- `grep -v` : Filtrage inversé pour exclure certaines lignes

### Analyse de logs
- **Format Nginx** : Compréhension de la structure des logs access.log
- **Métriques importantes** :
  - IPs les plus actives → Détection d'utilisation intensive ou attaques
  - Chemins populaires → Optimisation des endpoints
  - Codes HTTP → Santé du serveur (200=OK, 404=Not Found, 500=Erreur)

### Parsing de texte
- Extraction de données structurées depuis des logs non structurés
- Combinaison de plusieurs commandes Unix pour transformer des données brutes en statistiques

## 📝 Licence
MIT License

## 👤 Auteur
**Adriusops**

- GitHub: [@Adriusops](https://github.com/AMM48)

## 🔗 Ressources
Ce projet fait partie des [roadmap.sh DevOps Projects](https://roadmap.sh/projects/log-archive-tool).

---

⭐ Si ce projet vous aide, n'hésitez pas à lui donner une étoile sur GitHub !
