# syntax=docker/dockerfile:1

############################
# Étape 1 : Build Astro    #
############################
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

############################
# Étape 2 : Nginx static   #
############################
FROM nginx:alpine

# On vire l'ancienne conf et le contenu par défaut
RUN rm -rf /etc/nginx/nginx.conf /usr/share/nginx/html/*

# On copie notre conf nginx custom
COPY nginx.conf /etc/nginx/nginx.conf

# On copie le build Astro
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]