#! /bin/bash
echo -e "\e[38;5;82m"
echo -e "\e[38;0;1m#______________ Add User _______________#"
echo -e "\e[38;0;37m "

read -p "Do you want to create new user yes/no: " usercre
if [ "$usercre" = "yes" ]; then

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
fi


sudo adduser $username sudo
sudo usermod -a -G root $username
read -p "Press [Enter] key to Next Step..."



echo -e "\e[38;0;1m#______________ Install Open SSL Server _______________#"
echo -e "\e[38;0;37m "
read -p "Do you want to install SSH yes/no: " sshinstallation
if [ "$sshinstallation" = "yes" ]; then
	sudo apt remove openssh-server		  ## remove Openssh
	sudo apt purge openssh-server		  ## purge Openssh
	sudo apt install openssh-server		  ## Install Openssh
	touch /etc/ssh/sshd_config
	echo "AllowUsers $username" >> /etc/ssh/sshd_config
	service ssh restart
	netstat -ntlp
fi
	
read -p "Press [Enter] key to Next Step..."


echo -e "\e[38;0;1m#______________ Install tools to Environment _______________#"
echo -e "\e[38;0;37m "
cp /linuxenv-main/Ronin_tools/sbin/* /sbin/
cp /linuxenv-main/Ronin_tools/etc/* /etc/
cd /sbin
chmod 777 cip cls conwifi minergu netstart netstatus netstop
ls -la cip cls conwifi minergu netstart netstatus netstop

read -p "Press [Enter] key to END"
