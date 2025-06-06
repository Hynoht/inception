<?php
/* Fichier de configuration phpMyAdmin */

$cfg['blowfish_secret'] = 'une_chaine_aleatoire_pour_le_cookie_securite'; // obligatoire, min 32 caractères recommandés

$i = 0;
$i++;
$cfg['Servers'][$i]['host'] = 'mariadb';  // Nom du service ou container MariaDB dans le réseau Docker
$cfg['Servers'][$i]['port'] = '3306';    // Port MariaDB, par défaut 3306
$cfg['Servers'][$i]['auth_type'] = 'cookie';  // méthode d’authentification, 'cookie' est standard
$cfg['Servers'][$i]['user'] = '';        // vide pour que l’utilisateur saisisse son login
$cfg['Servers'][$i]['password'] = '';    // vide pour que l’utilisateur saisisse son mot de passe

/* Options supplémentaires (optionnel) */
// $cfg['Servers'][$i]['compress'] = false;
// $cfg['Servers'][$i]['AllowNoPassword'] = false;
