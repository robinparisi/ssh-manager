=============================
SSH Manager
=============================

A simple script to manage ssh connections

![screenshot](https://github.com/Fendtwick/ssh-manager/raw/master/screenshot.png)

## Installation

    $ cd ~
    $ wget --no-check-certificate https://raw.github.com/Fendtwick/ssh-manager/master/ssh-manager.sh
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

