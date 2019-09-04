# Image de base
FROM nginx

# Installation de curl avec apt-get
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8
ENV LANG fr_FR.utf8


RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install git nano cron -y


# Changement du repertoire courant
WORKDIR /app

# Ajout des sources
ADD . /app/

RUN git clone https://github.com/CheckFly/niamoto_maquette.git

# ajout de la tâche cron
ADD pull_auto /etc/cron.d
#ADD cron /etc/init.d

# mise à jour du fichier de configuration nginx
RUN rm /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/conf.d

# On expose le port 80
EXPOSE 80

# On partage un dossier de log
VOLUME /app/log

