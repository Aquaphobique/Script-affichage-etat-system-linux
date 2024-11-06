#!/bin/bash

# Fonction pour afficher la version de l'OS
get_os_version() {
    echo -e "\n### Version de l'OS ###"
    cat /etc/os-release | grep -E '^NAME|^VERSION'
}

# Fonction pour afficher l'état du réseau
get_network_status() {
    echo -e "\n### État du Réseau ###"
    ip a | grep -E 'inet|inet6'
    echo -e "\nStatut de la connexion internet :"
    ping -c 1 8.8.8.8 &> /dev/null && echo "Connecté" || echo "Déconnecté"
}

# Fonction pour afficher l'utilisation de la RAM
get_memory_status() {
    echo -e "\n### Utilisation de la RAM ###"
    free -h
}

# Fonction pour afficher les infos sur le CPU
get_cpu_status() {
    echo -e "\n### Informations sur le CPU ###"
    lscpu | grep -E 'Model name|Architecture|CPU MHz|Core(s) per socket|Thread(s) per core'
}

# Fonction pour afficher l'état du disque dur
get_disk_status() {
    echo -e "\n### État du Disque Dur ###"
    df -h --total | grep -E '^/dev|^total'
    echo -e "\nÉtat SMART du disque :"
    sudo smartctl -a /dev/sda | grep -E 'Model|Temperature|Reallocated_Sector_Ct|Power_On_Hours'
}

# Affichage du résumé de l'état du système
clear
echo "### État du Système ###"
get_os_version
get_network_status
get_memory_status
get_cpu_status
get_disk_status
