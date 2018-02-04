# mkvhosh: Make nginx virtual hosts with no effort
A dead simply script for making virtual host files for nginx reverse proxy.
Virtual hosts will be with **.localhost** TLD. 
_(exp. foobar.localhost, yoursite.localhost etc. )_ 

# Help
 - Run `./mkvhost -h` for help

# Usage
 - Simply pull the repository where you wish
 - Add `mkvhost.sh` permission to execute
 - Run `sudo ./mkvhost.sh YOUR_HOST_WITHOUT_TLD YOUR_LOCAL_PORT`
   _(exp. `./mkvhost.sh foobar 8080` will create **foobar.localhost** virtual host that will `proxy_pass` to http://localhost:8080)_
 
