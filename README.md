# SSH Manager

:warning: This script is not maintained anymore. It's a really old project and it's way better to use ssh_config with autocomplete or some alias for example.

A simple script to manage ssh connections on *inx ( Such as UNIX, Linux, Mac OS, etc)

![screenshot](https://github.com/robinparisi/ssh-manager/raw/master/screenshot.png)

## Basic introduction

    This shell script maintains a file database named ".ssh_servers " which located in "$HOME/.ssh_servers".
    With this sh, you can use its list to help you remember which hosts you can connect to and what username 
    and ip and port are them.

    You can customize it with more powerfull functions to easy and widly use.

    Thanks!

    # ./ssh-manager.sh add local:root:localhost:22
	new alias 'local:root:localhost:22' added
    # ./ssh-manager.sh add local:root:127.0.0.1:22
	new alias 'local:root:127.0.0.1:22' added
    # ./ssh-manager.sh add local:root:10.20.0.7:22
	new alias 'local:root:10.20.0.7:22' added
    # ./ssh-manager.sh
	--------------------------------------------------------------------------------
	List of availables servers for user root 
	--------------------------------------------------------------------------------
	[UP]   local ==> root@localhost -> 22
	[UP]   local ==> root@127.0.0.1 -> 22
	[UP]   local ==> root@10.20.0.7 -> 22
	--------------------------------------------------------------------------------
	Availables commands
	--------------------------------------------------------------------------------
	cc  <alias> [username]                           connect to server
	add <alias>:<user>:<host>:[port]                 add new server
	del <alias>                                      delete server
	export                                           export config
    # cat .ssh_servers 
	local:root:localhost:22:
	local:root:127.0.0.1:22:
	local:root:10.20.0.7:22:
    #

## Installation

    $ cd ~
    $ wget --no-check-certificate https://raw.github.com/robinparisi/ssh-manager/master/ssh-manager.sh
    $ chmod +x ssh-manager.sh
    $ ./ssh-manager.sh
    
For more convenience, you can create an alias into your .bashrc, .zshrc, etc...

For example :

    alias sshs="/Users/robin/ssh-manager.sh"

## Use

    cc  <alias> [username]                          
    add <alias>:<user>:<host>:[port]                 
    del <alias>                                      
    export                                           

