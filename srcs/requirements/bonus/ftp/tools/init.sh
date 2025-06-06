#!/bin/bash

set -e

create_user()
{
	local FTP_PASSWORD=$(cat /run/secrets/ftp_password)
	if [ -d "/home/$USER_FTP" ]; then
		useradd "$USER_FTP"
	else
		useradd -m "$USER_FTP"
	fi
	echo "$USER_FTP:$FTP_PASSWORD" | chpasswd
}

if ! getent passwd "$USER_FTP" > /dev/null 2>&1; then
	create_user
fi

mkdir -p "/home/$USER_FTP/ftp"
mkdir -p /var/run/vsftpd/empty
chown nobody:nogroup "/home/$USER_FTP/ftp"
chmod a-w "/home/$USER_FTP/ftp"
mkdir -p "/home/$USER_FTP/ftp/files"
chown "$USER_FTP:$USER_FTP" "/home/$USER_FTP/ftp/files"

exec /usr/sbin/vsftpd /etc/vsftpd.conf