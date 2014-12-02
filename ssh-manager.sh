#!/bin/bash
#########################################
# Original script by Errol Byrd
# Copyright (c) 2010, Errol Byrd <errolbyrd@gmail.com>
#########################################
# Modified by Robin Parisi
# Contact at parisi.robin@gmail.com
# Github https://github.com/Fendtwick/ssh-manager 

#================== Globals ==================================================

# Version
VERSION="0.5"

# Configuration
HOST_FILE="$HOME/.ssh_servers"
DATA_DELIM=":"
DATA_ALIAS=1
DATA_HUSER=2
DATA_HADDR=3
DATA_HPORT=4
SSH_DEFAULT_PORT=22

#================== Functions ================================================

function exec_ping() {
	case $(uname) in 
		MINGW*)
			ping -n 1 -i 2 $@
			;;
		*)
			ping -c1 -t 2 $@
			;;
	esac
}

function test_host() {
	exec_ping $* > /dev/null
	if [ $? != 0 ] ; then
		echo -n "["
		cecho -n -red "KO"
		echo -n "]  "
	else
		echo -n "["
		cecho -n -green "UP"
		echo -n "]  "
	fi 
}

function separator() {
	echo "--------------------------------------------------------------------------------"
}

function list_commands() {
	separator
	echo -e "Availables commands"
	separator
	echo "cc  <alias> [username]                           connect to server"
	echo "add <alias>:<user>:<host>:[port]                 add new server"
	echo "del <alias>                                      delete server"
	echo "export                                           export config"
}

function probe ()
{
	als=$1
	grep -w -e $als $HOST_FILE > /dev/null
	return $?
}

function get_raw ()
{
	als=$1
	grep -w -e $als $HOST_FILE 2> /dev/null
}

function get_addr ()
{
	als=$1
	get_raw "$als" | awk -F "$DATA_DELIM" '{ print $'$DATA_HADDR' }'
}

function get_port ()
{
	als=$1
	get_raw "$als" | awk -F "$DATA_DELIM" '{ print $'$DATA_HPORT'}'
}

function get_user ()
{
	als=$1
	get_raw "$als" | awk -F "$DATA_DELIM" '{ print $'$DATA_HUSER' }'
}

function cecho {
	while [ "$1" ]; do
		case "$1" in 
			-normal)        color="\033[00m" ;;
-black)         color="\033[30;01m" ;;
-red)           color="\033[31;01m" ;;
-green)         color="\033[32;01m" ;;
-yellow)        color="\033[33;01m" ;;
-blue)          color="\033[34;01m" ;;
-magenta)       color="\033[35;01m" ;;
-cyan)          color="\033[36;01m" ;;
-white)         color="\033[37;01m" ;;
-n)             one_line=1;   shift ; continue ;;
*)              echo -n "$1"; shift ; continue ;;
esac

shift
echo -en "$color"
echo -en "$1"
echo -en "\033[00m"
shift

done
if [ ! $one_line ]; then
	echo
fi
}

#=============================================================================

cmd=$1
alias=$2
user=$3

# if config file doesn't exist
if [ ! -f $HOST_FILE ]; then touch "$HOST_FILE"; fi


# without args
if [ $# -eq 0 ]; then
	separator 
	echo "List of availables servers for user $(whoami) "
	separator
	while IFS=: read label user ip port         
	do    
	test_host $ip
	echo -ne " "
	cecho -n -blue $label
	echo -ne ' ==> '
	cecho -n -red $user 
	cecho -n -yellow "@"
	cecho -n -white $ip
	echo -ne ' -> '
	if [ "$port" == "" ]; then
		port=$SSH_DEFAULT_PORT
	fi
	cecho -yellow $port
	echo
done < $HOST_FILE

list_commands

exit 1;
fi

case "$cmd" in
# Connect to host
cc )
probe "$alias"
if [ $? -eq 0 ]; then
	if [ "$user" == ""  ]; then
		user=$(get_user "$alias")
	fi

	addr=$(get_addr "$alias")
	port=$(get_port "$alias")

			# Use default port when parameter is missing
			if [ "$port" == "" ]; then
				port=$SSH_DEFAULT_PORT
			fi

			echo "connecting to '$alias' ($addr:$port)"
			ssh $user@$addr -p $port
		else
			echo "$0: unknown alias '$alias'"
		fi
		;;

# Add new alias
add )
probe "$alias"
if [ $? -eq 0 ]; then
	as	echo "$0: alias '$alias' is in use"
else
	echo "$alias$DATA_DELIM$user" >> $HOST_FILE
	echo "new alias '$alias' added"
fi
;;
# Export config
export )
echo
cat $HOST_FILE
;;
# Delete ali
del )
probe "$alias"
if [ $? -eq 0 ]; then
	cat $HOST_FILE | sed '/^'$alias$DATA_DELIM'/d' > /tmp/.tmp.$$
	mv /tmp/.tmp.$$ $HOST_FILE
	echo "alias '$alias' removed"
else
	echo "$0: unknown alias '$alias'"
fi
;;
* )
echo "$0: unrecognised command '$cmd'"
;;
esac	


