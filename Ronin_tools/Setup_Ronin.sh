#! /bin/bash
echo -e "\e[38;5;82m"
echo -e "\e[38;0;1m#______________ Add User _______________#"
echo -e "\e[38;0;37m "

if [ $(id -u) -eq 0 ]; then
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		sudo useradd -m -p "$pass" "$username"
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system."
	exit 2
fi


sudo adduser $username sudo
sudo usermod -a -G root $username
read -p "Press [Enter] key to Next Step..."


echo -e "\e[38;1;1m#________ Download Github project ________#"
wget 


echo -e "\e[38;0;1m#______________ Install Open SSL Server _______________#"
echo -e "\e[38;0;37m "
sudo apt remove openssh-server		  ## remove Openssh
sudo apt purge openssh-server		  ## purge Openssh
sudo apt install openssh-server		  ## Install Openssh
touch /etc/ssh/sshd_config
echo "AllowUsers $username" >> /etc/ssh/sshd_config
service ssh restart
netstat -ntlp
read -p "Press [Enter] key to Next Step..."

