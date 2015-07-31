#!/bin/bash
errorType(){
	while [ "$#" -ne "0" ]
	do
		case $1 in
			1) echo -e "\e[00;31mThis script is work proper as root user only, run this script again with root...\e[00m" ;;
			2) echo -e "\e[00;31m$file isn't accessible, make sure this file accessible...\e[00m";;
			3) echo -e "\e[00;31m$file premission error...\e[00m";;
			4) echo -e "\e[00;31mCheck internet connection...\e[00m";;
		esac
	shift 1
	done
}
_userPremission(){
	if [ "$(whoami)" != "root" ]
	then
	  errorType 1
	  exit 1
	fi
}	

_osDetect(){
	if [ -f /etc/lsb-release ]
		then
		. /etc/lsb-release
		DIST=$DISTRIB_ID
		DIST_VER=$DISTRIB_RELEASE
	elif [ -f /etc/redhat-release ]
		then
	     DIST=$(awk < /etc/redhat-release '{print $1}')
	     DIST_VER=$(cat /etc/redhat-release | grep -o '[0-9]*' | head -n 1)
     elif [ -f /etc/SuSE-release ]
     	then
     	DIST=$(awk < /etc/SuSE-release '{print $1$2}')
     	DIST_VER=$(grep VERSION /etc/SuSE-release | awk '{print $3}')

	else
		DIST="Unknown"
		DIST_VER="Unknown"	
	fi
}

_toolCheck(){
	while [ "$#" -ne "0" ]
	do
		command -v $1 > /dev/null ||
		{
			echo -e "\e[00;31mThis script require $1 command, Please install $1 command\e[00m"
			exit 1
		}
		shift 1
	done
}
_shortcut(){
		cp /etc/xdg/menus/applications.menu /etc/xdg/menus/applications.menu.original  > /dev/null 2>&1 
		if [ "$?" -ne "0" ]
		then
			 file="/etc/xdg/menus/applications.menu"
			 errorType 2
			 exit 1 
		fi
cd shotcuts
file=(
`ls | cut -d " " -f 1`
)
				for dsk in ${file[*]}
				do
				`xdg-desktop-menu install $dsk > /dev/null 2>&1` 
				done 
				cd $OLDPWD
		
}
_ubuntuInstaller(){
	grep 'backtrack-linux.org' /etc/apt/sources.list > /dev/null 2>&1
	if [ "$?" -ne "0" ]
	then
			cp /etc/apt/sources.list /etc/apt/sources.list.old > /dev/null 2>&1 
			if [ "$?" -ne "0" ]
				then
				file="/etc/apt/sources.list"
				errorType 3
				exit 1
			fi
			wget -q http://all.repository.backtrack-linux.org/backtrack.gpg -O- |  apt-key add - > /dev/null 2>&1 
			if [ "$?" -ne "0" ]
			then
			 	errorType 4
			 	exit 1
		    fi 
		    
			echo 'deb http://all.repository.backtrack-linux.org revolution main microverse non-free testing' >> /etc/apt/sources.list 
			if [ "$?" -ne "0" ]
			then
			 file="sources"
			 errorType 3
			 exit 1
			fi
		
			apt-get update > /dev/null 2>&1 
			if [ "$?" -ne "0" ]
			then
				errorType 4
			 	exit 1
			fi
	fi	
_shortcut
	
}
_rpmCheck(){
	if [ "$DIST" == "CentOS" ] || [ "$DIST" == "Red" ]
		then
		if [ ! -f /etc/yum.repos.d/rpmforge.repo ]
			then
			echo "rpmforge repo not found, Do you want to install this repo?(y/n)"
			read repo
			case $repo in
			y) 
						hardware=$(od -j4 -N1 -An -t u1 < /bin/sh | tr -d ' ')
						$hardware
						if [ "$DIST_VER" -eq "5" ]
						 	then
							 	if [ "$hardware" -eq "1" ]
							 		then
							 		wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el5.rf.i386.rpm > /dev/null 2>&1
							 		rpm -Uvh rpmforge-release-0.5.2-2.el5.rf.i386.rpm > /dev/null 2>&1 || echo "repo install Successfully"
							 	elif [ "$hardware" -eq "2"  ]
							 		then
							 		wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm > /dev/null 2>&1
							 		rpm -Uvh rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm > /dev/null 2>&1 || echo "repo install Successfully"
							 	fi
				 		fi

				 		if [ "$DIST_VER" -eq "6" ]
					 		then
			 				if [ "$hardware" -eq "1" ]
				 				then
					 				wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.i686.rpm > /dev/null 2>&1
					 				rpm -Uvh rpmforge-release-0.5.2-2.el6.rf.i686.rpm > /dev/null 2>&1 || echo "repo install Successfully"
			 				elif [  "$hardware" -eq "2" ]
			 					then
					 				wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm > /dev/null 2>&1
					 				rpm -Uvh rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm > /dev/null 2>&1 || echo "repo install Successfully"
							fi
							wget http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt > /dev/null 2>&1 
							rpm --import RPM-GPG-KEY.dag.txt > /dev/null 2>&1 
						fi 
						;;
				n) exit 1 ;;
				*) return 1 ;;
				esac
		fi
	fi
}
_Forensics(){
`yum --enablerepo=rpmforge install ddrescue gparted hexedit testdisk foremost  scanmem  unhide  dc3dd  ntfs-3g ntfsprogs -y > /dev/null 2>&1` 
}
_WebApplicationTesting(){
`yum --enablerepo=rpmforge install httping nikto skipfish -y > /dev/null 2>&1 `
}
_Wireless(){
`yum --enablerepo=rpmforge install aircrack-ng airsnort kismet weiplab -y > /dev/null 2>&1`
}
_IntrusionDetection(){
`yum --enablerepo=rpmforge install chkrootkit aide labrea honeyd  rkhunter -y > /dev/null 2>&1`
}
_PasswordTools(){
`yum --enablerepo=rpmforge install john -y > /dev/null 2>&1`
}
_httpd(){
`yum --enablerepo=rpmforge install httpd ruby mod_perl mod_python MySQL-python php php-pear php-mysql -y > /dev/null 2>&1`
}
_centInstaller(){
	_Forensics
	_WebApplicationTesting
	_Wireless
	_IntrusionDetection
	_PasswordTools
	_httpd
}
_report(){
	if [ "$?" -eq "0" ]
	then
	   	   echo $DIST_VER | egrep -i '9.10|10.04|10.10' > /dev/null 2>&1 
		   if [ "$?" -eq "0" ]
		   then
				echo -e "\e[00;32m Waoo ! Successfully Configure BT Tools on your OS , Now follow the step as per README_first\e[00m. . ."
				exit 0
			else
			echo -e "\e[00;32m Waoo ! Successfully Configure BT Tools on your OS ...\e[00m. . ."
			exit 0			
fi
	else
		echo -e "\e[00;31m Error Found ...\e[00m"
		exit 1
fi
}
