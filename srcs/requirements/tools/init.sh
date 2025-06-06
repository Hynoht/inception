#!/bin/bash

read_password() {
	prompt=$1
	password=""
	echo -n "$prompt"

	while IFS= read -r -s -n1 char; do
		if [[ $char == $'\0' || $char == $'\n' ]]; then
			echo
			break
		fi

		if [[ $char == $'\x7f' ]]; then
			if [ -n "$password" ]; then
				password="${password%?}"
				echo -ne "\b \b"
			fi
		else
			password+="$char"
			echo -n '*'
		fi
	done
}

check_secrets() {
	passwords="db db_root admin user ftp redis"

	for name in $passwords; do
		file="secrets/${name}_password.txt"

		if [ ! -f "$file" ]; then
			password=""
			while [ -z "$password" ]; do
				read_password "Entrez un mot de passe pour $name : "
				if [ -n "$password" ]; then
					echo "$password" > "$file"
				fi
			done
		fi
	done
}

check_env() {
	if [ ! -f srcs/.env ]; then
		touch srcs/.env
	fi
	required_vars="DOMAINE_NAME MYSQL_USER MYSQL_DATABASE ADMIN_USER ADMIN_EMAIL SECOND_USER USER_EMAIL USER_FTP TITLE"
	for var in $required_vars; do
		value=$(grep "^$var=" srcs/.env | cut -d '=' -f2-)
		if [ -z "$value" ]; then
			if  grep -q "^$var=" srcs/.env ; then
				sed -i "/^$var=/d" srcs/.env
			fi
			if [ "$var" = "DOMAINE_NAME" ]; then
				echo "$var=tolrandr.42.fr" >> srcs/.env
			elif [ "$var" == "ADMIN_USER" ]; then
				while true; do
					echo "Ajouter une valeur pour $var : "
					read -r value;
					if ! echo "$value" | grep -qi "admin"; then
						echo "$var=$value" >> srcs/.env;
						break ;
					else
						echo "L'admin ne doit pas contenir le mot admin"
					fi
				done
			else
				value=""
				while [ -z "$value" ]; do
					echo "Ajouter une valeur pour $var : "
					read -r value
					if [ -n "$value" ]; then
						echo "$var=$value" >> srcs/.env
					fi
				done
			fi
		fi
	done
}

check_admin() {
	value=$(grep "ADMIN_USER=" srcs/.env | cut -d '=' -f2-)
	if [ -z "$value" ]; then
		echo "Veuillez definir l'admin user"
		exit 1
	fi
	if  echo "$value" | grep -qi "admin" ; then
		echo "Erreur de compilation, l'admin user contient le mot \"admin\""
		exit 1
	fi
}

check_certificate() {
	if [ ! -d secrets/certificate ]; then
		echo "Certificate is missing";
		exit 1;
	elif [ ! -f secrets/certificate/certificate.crt ]; then
		echo "certificate.crt is missing";
		exit 1;
	elif [ ! -f secrets/certificate/certificate.key ];then
		echo "certificate.key is missing";
		exit 1;
	fi;
}

check_data() {
	if [ ! -d $HOME/data ]; then
		mkdir $HOME/data;
	fi
	if [ ! -d $HOME/data/mariadb ]; then
		mkdir $HOME/data/mariadb;
	fi
	if [ ! -d $HOME/data/wordpress ]; then
		mkdir $HOME/data/wordpress;
	fi
	if [ ! -d $HOME/data/phpmyadmin ]; then
		mkdir $HOME/data/phpmyadmin;
	fi
}

if [ ! -d secrets ]; then
	echo "hello"
	pwd
	mkdir -p secrets
	check_secrets
else
	check_secrets
fi

check_env
check_admin
check_certificate
check_data