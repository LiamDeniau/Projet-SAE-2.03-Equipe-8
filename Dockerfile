#Image debian
FROM debian:latest

#Installations
RUN apt update && apt upgrade -y
RUN apt-get install sudo
RUN sudo apt-get install debconf
RUN apt update && apt upgrade -y

RUN sudo apt-get install apt-utils
RUN apt update && apt upgrade -y

RUN sudo apt install apt-transport-https ca-certificates gnupg2 git -y
RUN sudo apt install wget
RUN sudo wget -O- https://repo.jellyfin.org/jellyfin_team.gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/jellyfin.gpg
RUN sudo echo "deb [arch=$( dpkg --print-architecture ) signed-by=/usr/share/keyrings/jellyfin.gpg] https://repo.jellyfin.org/debian bullseye main" | sudo tee /etc/apt/sources.list.d/jellyfin.list
RUN apt update && apt upgrade -y

RUN sudo apt install jellyfin -y
RUN apt update && apt upgrade -y

RUN sudo apt-get -y install systemctl

#Lancement de jellyfin au demarrage
CMD ["systemctl", "start", "jellyfin"]

#ouverture de port
EXPOSE 8096