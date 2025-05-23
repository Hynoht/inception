#!/bin/bash

set -e

create_user()
{
	local FTP_PASSWORD=$(cat /run/secrets/ftp_password)

	useradd -m $USER_FTP && echo "$USER_FTP:$FTP_PASSWORD" | chpasswd
}

create_user

mkdir -p /home/$USER_FTP/ftp
mkdir -p /var/run/vsftpd/empty
chown nobody:nogroup /home/$USER_FTP/ftp
chmod a-w /home/$USER_FTP/ftp
mkdir -p /home/$USER_FTP/ftp/files
chown $USER_FTP:$USER_FTP /home/$USER_FTP/ftp/files

exec /usr/sbin/vsftpd /etc/vsftpd.conf