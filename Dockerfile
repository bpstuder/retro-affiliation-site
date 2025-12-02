# syntax=docker/dockerfile:1

############################
# Étape 1 : Build du site Astro
############################
FROM node:20-alpine AS builder

# Dossier de travail
WORKDIR /app

# Copie des fichiers de dépendances
COPY package*.json ./

# Install des dépendances
RUN npm install

# Copie du reste du projet (src, public, astro.config, etc.)
COPY . .

# Build du site statique Astro (sortie dans /app/dist)
RUN npm run build


############################
# Étape 2 : Nginx pour servir le site
############################
FROM nginx:alpine

# On supprime la conf par défaut + le contenu HTML par défaut
RUN rm -f /etc/nginx/nginx.conf && rm -rf /usr/share/nginx/html/*

# On copie notre configuration Nginx custom
# (assure-toi d'avoir un fichier nginx.conf à la racine du projet)
COPY nginx.conf /etc/nginx/nginx.conf

# On copie le build Astro dans le dossier servi par Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Nginx écoute sur 80 dans le container
EXPOSE 80

# Commande de démarrage
CMD ["nginx", "-g", "daemon off;"]