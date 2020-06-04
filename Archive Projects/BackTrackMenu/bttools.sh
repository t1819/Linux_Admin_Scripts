#!/bin/bash  

# Please file bugs at github!
# https://github.com/t1819/scripting

if [ ! -x function.sh ]
 then
 	echo -e "\e[00;31mError:\e[00m function file is not found... please insert function file ..." 
 	return 1
fi
_userInterface(){
. function.sh
_userPremission
_toolCheck unzip egrep xdg-desktop-menu
_osDetect
			echo -e "\e[00;37m
######################################################### 
\e[00;32m#BackTrack Menu written by Ritesh Singh 	        #
\e[00;37m########################################################\e[00m"
echo -e "Your operating system is $DIST $DIST_VER\n"
	if [ "$DIST" == "Ubuntu" ]
		then
			_ubuntuInstaller
			_report
	fi 
	if [ "$DIST" == "Unknown" ]
		then
			echo -e "Your operating system is $DIST,This script only work with Ubuntu/CentOS\n\e[00;31mDo you really want to continue this script?(y/n)\e[00m"
			read answer
			case $answer in
				y)
							echo "Your operating system is like Ubuntu/CentOS?(1,2) "
							read os
							case $os in
								1)_ubuntuInstaller
									_report
								;;
								2)_centInstaller
									_report
								;;
								*) echo "enter in between 1-2 number , try again " || exit 1
							esac

				;; 
				n) exit 1
				;;
				*) return 1 
				;;
			esac
	
	elif [ "$DIST" == "CentOS" -o "$DIST" == "Red" ]
	then
	_rpmCheck
	echo "Choice 1-7 pakages options:
				  1) Forensics(ddrescue,gparted,hexedit,testdisk,foremost,scanmem,unhide,dc3dd,ntfs-3g,ntfsprogs) 
				  2) WebApplicationTesting(httping,nikto,skipfish)
				  3) Wireless(aircrack-ng,airsnort,kismet,weiplab)
				  4) IntrusionDetection(chkrootkit,aide,labrea,honeyd,rkhunter)
				  5) PasswordTools(john)
				  6) httpd(httpd,ruby,mod_perl,mod_python,MySQL-python,php,php-pear,php-mysql)
				  7) All pakages install "
			read options
			case $options in
				1) _Forensics;;
				2) _WebApplicationTesting;;
				3) _Wireless;;
				4) _IntrusionDetection;;
				5) _PasswordTools;;
				6) _httpd;;
				7) _centInstaller;;
			esac
	fi		

}
_userInterface
_report
